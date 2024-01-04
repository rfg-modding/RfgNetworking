using RfgNetworking.Backend;
using RfgNetworking.Win32;
using RfgNetworking.Misc;
using RfgNetworking.API;
using System.Threading;
using System;
using System.Collections;
using Bon;

namespace RfgNetworking.Backend.Debug
{
    //Wrapper DLL backend. Passes all function calls to the original and logs their arguments & results
    public class DebugBackend : IDLLBackend
    {
        function bool() SW_CCSys_Init_original = null;
        function ISteamClient*(char8* interfaceName) SW_CCSys_CreateInternalModule_original = null;
        function CSteamAPIContext*(void** callbackCounterAndContext) SW_CCSys_DynamicInit_original = null;
        function void() SW_CCSys_GetP_original = null;
        function HSteamPipe() SW_CCSys_GetPInterface_original = null;
        function void() SW_CCSys_GetU_original = null;
        function HSteamUser() SW_CCSys_GetUInterface_original = null;
        function void(void* callbackFunc, CallbackType callbackId) SW_CCSys_InitCallbackFunc_original = null;
        function void(void* callbackFunc) SW_CCSys_RemoveCallbackFunc_original = null;
        function void() SW_CCSys_IsBackendActive_original = null;
        function void() SW_CCSys_ProcessApiCb_original = null;
        function void(CCallbackBase* callbackResult, u32 apiCallHandleLower, u32 apiCallHandleUpper) SW_CCSys_RegisterCallResult_original = null;
        function void(CCallbackBase* callbackResult, u32 apiCallHandleLower, u32 apiCallHandleUpper) SW_CCSys_UnregisterCallResult_original = null;
        function void() SW_CCSys_Shutdown_original = null;
        function void() SW_CCSys_TestInitialConditions_original = null;
        function bool() SW_HasAchievements_original = null;
        function bool() SW_HasInvites_original = null;
        function bool() SW_HasLeaderboards_original = null;
        function void() SW_RegisterCallback_original = null;
        function void() SW_UnregisterCallback_original = null;

        //Input thread state
        Thread _inputThread = null;
        bool _exit = false;

        HINSTANCE _originalDLLHandle = 0;

        //Interface logging wrappers
        bool steamClientWrapperInitialized = false;
        SteamClientDebugWrapper SteamClientWrapper;
        SteamUserDebugWrapper SteamUserWrapper;
        SteamFriendsDebugWrapper SteamFriendsWrapper;
        SteamUtilsDebugWrapper SteamUtilsWrapper;
        SteamMatchmakingDebugWrapper SteamMatchmakingWrapper;
        SteamUserStatsDebugWrapper SteamUserStatsWrapper;
        SteamAppsDebugWrapper SteamAppsWrapper;
        SteamNetworkingDebugWrapper SteamNetworkingWrapper;
        SteamRemoteStorageDebugWrapper SteamRemoteStorageWrapper;
        SteamControllerDebugWrapper SteamControllerWrapper;

        List<CCallbackBase*> CallbackLoggers = new .() ~DeleteContainerAndItems!(_);
        Dictionary<CallbackType, CCallbackBase*> CallResultLoggers = new .() ~DeleteDictionaryAndValues!(_);

        struct CallbackLogger<T> : CCallbackBase where T : struct
        {
            public CallbackType CallbackType;
            public CCallbackBase* Original;
            private CCallbackBase.VTable* _originalVtable = null;
            private CCallbackBase.VTable _loggedVtable = .();

            public this(CCallbackBase* original, CallbackType callbackType)
            {
                CallbackType = callbackType;
                Original = original;

                //Point the struct to a new vtable that logs any calls then passes them onto the real vtable
                _originalVtable = Original.Vfptr;
                _loggedVtable.Run = => Run;
                _loggedVtable.Run2 = => Run2;
                _loggedVtable.GetCallbackSizeBytes = => GetCallbackSizeBytes;

                base.Vfptr = &_loggedVtable;
                base.CallResultType = original.CallResultType;
                base.CallbackFlags = original.CallbackFlags;

                Original.Vfptr = &_loggedVtable;
            }

            public void Cleanup()
            {
                Original.Vfptr = _originalVtable;
            }

            public void Run(void* param, u8 param1, u64 param2)
            {
                //Convert param and its fields to string and log it
                String dataFields = scope .();
                gBonEnv.serializeFlags |= .Verbose;
                Bon.Serialize<T>(*(T*)param, dataFields);

                String logString = scope $"[CALLBACK] {CallbackType.ToString(.. scope .())}.Run({typeof(T).GetName(.. scope .())}* param:\n{dataFields},\nuint8 param1: {param1}, uint64 param2: {param2})";
                logString.Replace("{", "{{"); //Have to escape these so StreamWriter doesn't think they're formatting parameters
                logString.Replace("}", "}}");
                Logger.WriteLine(logString);

                //Call original vtable func
                _originalVtable.Run(Original, param, param1, param2);
            }

            public void Run2(void* param)
            {
                //Convert param and its fields to string and log it
                String dataFields = scope .();
                gBonEnv.serializeFlags |= .Verbose;
                Bon.Serialize<T>(*(T*)param, dataFields);

                String logString = scope $"[CALLBACK] {CallbackType.ToString(.. scope .())}.Run2({typeof(T).GetName(.. scope .())}* param:\n{dataFields})";
                logString.Replace("{", "{{");
                logString.Replace("}", "}}");
                Logger.WriteLine(logString);

                //Call original vtable func
                _originalVtable.Run2(Original, param);
            }

            public i32 GetCallbackSizeBytes()
            {
                i32 result = _originalVtable.GetCallbackSizeBytes(Original);
                Logger.WriteLine(scope $"[CALLBACK] {CallbackType.ToString(.. scope .())}.GetCallbackSizeBytes() -> {result}");
                return result;
            }
        }

        struct CallResultLogger <T> : CCallbackBase where T : struct
        {
            public u32 APICallLower;
            public u32 APICallUpper;
            public CCallbackBase* Original;
            private CCallbackBase.VTable* _originalVtable = null;
            private CCallbackBase.VTable _loggedVtable = .();

            public this(CCallbackBase* original, u32 apiCallLower, u32 apiCallUpper)
            {
                APICallLower = apiCallLower;
                APICallUpper = apiCallUpper;
                Original = original;

                //Point the struct to a new vtable that logs any calls then passes them onto the real vtable
                _originalVtable = Original.Vfptr;
                _loggedVtable.Run = => Run;
                _loggedVtable.Run2 = => Run2;
                _loggedVtable.GetCallbackSizeBytes = => GetCallbackSizeBytes;

                base.Vfptr = &_loggedVtable;
                base.CallResultType = original.CallResultType;
                base.CallbackFlags = original.CallbackFlags;

                Original.Vfptr = &_loggedVtable;
            }

            public void Cleanup()
            {
                Original.Vfptr = _originalVtable;
            }

            public void Run(void* param, u8 param1, u64 param2)
            {
                //Convert param and its fields to string and log it
                String dataFields = scope .();
                gBonEnv.serializeFlags |= .Verbose;
                Bon.Serialize<T>(*(T*)param, dataFields);

                String logString = scope $"[CALL_RESULT] {CallResultType.ToString(.. scope .())}.Run({typeof(T).GetName(.. scope .())}* param:\n{dataFields},\nuint8 param1: {param1}, uint64 param2: {param2})";
                logString.Replace("{", "{{"); //Have to escape these so StreamWriter doesn't think they're formatting parameters
                logString.Replace("}", "}}");
                Logger.WriteLine(logString);

                //Call original vtable func
                _originalVtable.Run(Original, param, param1, param2);
            }

            public void Run2(void* param)
            {
                //Convert param and its fields to string and log it
                String dataFields = scope .();
                gBonEnv.serializeFlags |= .Verbose;
                Bon.Serialize<T>(*(T*)param, dataFields);

                String logString = scope $"[CALL_RESULT] {CallResultType.ToString(.. scope .())}.Run2({typeof(T).GetName(.. scope .())}* param:\n{dataFields})";
                logString.Replace("{", "{{");
                logString.Replace("}", "}}");
                Logger.WriteLine(logString);

                //Call original vtable func
                _originalVtable.Run2(Original, param);
            }

            public i32 GetCallbackSizeBytes()
            {
                i32 result = _originalVtable.GetCallbackSizeBytes(Original);
                Logger.WriteLine(scope $"[CALL_RESULT] {base.CallResultType.ToString(.. scope .())}.GetCallbackSizeBytes() -> {result}");
                return result;
            }
        }


        public static mixin GetDLLFunction<T>(HINSTANCE dllHandle, T* func, char8* name) where T : operator explicit void*
        {
            *func = (T)(void*)Win32.GetProcAddress(dllHandle, name);
        }

        void IDLLBackend.Init()
        {
            System.Threading.Thread.Sleep(5000);

            Logger.WriteLine("********************");
            Logger.WriteLine("Log opened!");
            Logger.WriteLine("Notes:");
            Logger.WriteLine("    - SW_CCSys_DynamicInit() only has the first call logged. The game spams it sometimes. Vanilla sw_api.dll doesn't do anything after the first call.");
            Logger.WriteLine("    - SW_CCSys_ProcessApiCb() calls aren't logged since it called at least once per frame. Makes the log hard to read.");
            Logger.WriteLine("********************\n");

            //Load original DLL and get original functions for passthrough
            _originalDLLHandle = Win32.LoadLibraryA("sw_api.original.dll");
            if (_originalDLLHandle == 0)
                return;

            GetDLLFunction!(_originalDLLHandle, &SW_CCSys_Init_original, "SW_CCSys_Init");
            GetDLLFunction!(_originalDLLHandle, &SW_CCSys_CreateInternalModule_original, "SW_CCSys_CreateInternalModule");
            GetDLLFunction!(_originalDLLHandle, &SW_CCSys_DynamicInit_original, "SW_CCSys_DynamicInit");
            GetDLLFunction!(_originalDLLHandle, &SW_CCSys_GetP_original, "SW_CCSys_GetP");
            GetDLLFunction!(_originalDLLHandle, &SW_CCSys_GetPInterface_original, "SW_CCSys_GetPInterface");
            GetDLLFunction!(_originalDLLHandle, &SW_CCSys_GetU_original, "SW_CCSys_GetU");
            GetDLLFunction!(_originalDLLHandle, &SW_CCSys_GetUInterface_original, "SW_CCSys_GetUInterface");
            GetDLLFunction!(_originalDLLHandle, &SW_CCSys_InitCallbackFunc_original, "SW_CCSys_InitCallbackFunc");
            GetDLLFunction!(_originalDLLHandle, &SW_CCSys_RemoveCallbackFunc_original, "SW_CCSys_RemoveCallbackFunc");
            GetDLLFunction!(_originalDLLHandle, &SW_CCSys_IsBackendActive_original, "SW_CCSys_IsBackendActive");
            GetDLLFunction!(_originalDLLHandle, &SW_CCSys_ProcessApiCb_original, "SW_CCSys_ProcessApiCb");
            GetDLLFunction!(_originalDLLHandle, &SW_CCSys_RegisterCallResult_original, "SW_CCSys_RegisterCallResult");
            GetDLLFunction!(_originalDLLHandle, &SW_CCSys_UnregisterCallResult_original, "SW_CCSys_UnregisterCallResult");
            GetDLLFunction!(_originalDLLHandle, &SW_CCSys_Shutdown_original, "SW_CCSys_Shutdown");
            GetDLLFunction!(_originalDLLHandle, &SW_CCSys_TestInitialConditions_original, "SW_CCSys_TestInitialConditions");
            GetDLLFunction!(_originalDLLHandle, &SW_HasAchievements_original, "SW_HasAchievements");
            GetDLLFunction!(_originalDLLHandle, &SW_HasInvites_original, "SW_HasInvites");
            GetDLLFunction!(_originalDLLHandle, &SW_HasLeaderboards_original, "SW_HasLeaderboards");
            GetDLLFunction!(_originalDLLHandle, &SW_RegisterCallback_original, "SW_RegisterCallback");
            GetDLLFunction!(_originalDLLHandle, &SW_UnregisterCallback_original, "SW_UnregisterCallback");

            _inputThread = new .(new () => InputThreadLoop(this));
            _inputThread.Start();
        }

        void IDLLBackend.Shutdown()
        {
            //Log state on close in case I forget to
            LogDebugWrappersState();

            //Stop input thread
            _exit = true;
            _inputThread.Join(500);

            if (_originalDLLHandle != 0)
            {
                Win32.FreeLibrary(_originalDLLHandle);
            }
        }

        static bool _lastKeyUpStateF1 = true;
        public static void InputThreadLoop(DebugBackend backend)
        {
            while (!backend._exit)
            {
                bool keyUpStateF1 = (Win32.GetKeyState(0x70) & 0x8000) == 0; //True if F1 key is up
                if (keyUpStateF1 && !_lastKeyUpStateF1)
                {
                    backend.LogDebugWrappersState();
                }
                _lastKeyUpStateF1 = keyUpStateF1;
            }
        }

        private void LogDebugWrappersState()
        {
            //Log function call data tracked by the debug wrappers.
            SteamClientWrapper.LogState();
            SteamUserWrapper.LogState();
            SteamFriendsWrapper.LogState();
            SteamUtilsWrapper.LogState();
            SteamMatchmakingWrapper.LogState();
            SteamUserStatsWrapper.LogState();
            SteamAppsWrapper.LogState();
            SteamNetworkingWrapper.LogState();
            SteamRemoteStorageWrapper.LogState();
            SteamControllerWrapper.LogState();
        }

        [Log]
        bool IDLLBackend.SW_CCSys_Init()
        {
            bool result = SW_CCSys_Init_original();
            return result;
        }

        [Log]
        ISteamClient* IDLLBackend.SW_CCSys_CreateInternalModule(char8* interfaceName)
        {
            ISteamClient* steamClient = SW_CCSys_CreateInternalModule_original(interfaceName);
            if (!steamClientWrapperInitialized)
            {
                Logger.WriteLine(scope $"{steamClient}");
                SteamClientWrapper.Init(steamClient, steamClient.Vtable);
                steamClientWrapperInitialized = true;
                return &SteamClientWrapper;
            }

            return steamClient;
        }

        CSteamAPIContext* IDLLBackend.SW_CCSys_DynamicInit(CallbackCounterAndContext* callbackCounterAndContext)
        {
            bool firstRun = (callbackCounterAndContext.Counter == 0);
            CSteamAPIContext* steamApiContext = SW_CCSys_DynamicInit_original((void**)callbackCounterAndContext);

            //Init wrappers
            if (firstRun)
            {
                if (steamClientWrapperInitialized)
                {
                    //SW_CCSys_DynamicInit() calls the RFG callback which sets up CSteamAPIContext. So as long as client initialized all the other steam interfaces should've too
                    SteamUserWrapper.Init(steamApiContext.User, steamApiContext.User.Vtable);
                    steamApiContext.User = &SteamUserWrapper;

                    SteamFriendsWrapper.Init(steamApiContext.Friends, steamApiContext.Friends.Vtable);
                    steamApiContext.Friends = &SteamFriendsWrapper;

                    SteamUtilsWrapper.Init(steamApiContext.Utils, steamApiContext.Utils.Vtable);
                    steamApiContext.Utils = &SteamUtilsWrapper;

                    SteamMatchmakingWrapper.Init(steamApiContext.Matchmaking, steamApiContext.Matchmaking.Vtable);
                    steamApiContext.Matchmaking = &SteamMatchmakingWrapper;

                    SteamUserStatsWrapper.Init(steamApiContext.UserStats, steamApiContext.UserStats.Vtable);
                    steamApiContext.UserStats = &SteamUserStatsWrapper;

                    SteamAppsWrapper.Init(steamApiContext.Apps, steamApiContext.Apps.Vtable);
                    steamApiContext.Apps = &SteamAppsWrapper;

                    SteamNetworkingWrapper.Init(steamApiContext.Networking, steamApiContext.Networking.Vtable);
                    steamApiContext.Networking = &SteamNetworkingWrapper;

                    SteamRemoteStorageWrapper.Init(steamApiContext.RemoteStorage, steamApiContext.RemoteStorage.Vtable);
                    steamApiContext.RemoteStorage = &SteamRemoteStorageWrapper;

                    SteamControllerWrapper.Init(steamApiContext.Controller, steamApiContext.Controller.Vtable);
                    steamApiContext.Controller = &SteamControllerWrapper;
            	}
                Logger.Write(scope $"SW_CCSys_DynamicInit(CallbackCounterAndContext* callbackCounterAndContext: 0x{(int)(void*)callbackCounterAndContext:X})");
                Logger.Write(scope $" -> CSteamAPIContext*(0x{(int)(void*)steamApiContext:X})");
                Logger.Flush();
                Logger.WriteLine("");
            }

            return steamApiContext;
        }

        [Log]
        void IDLLBackend.SW_CCSys_GetP()
        {
        	SW_CCSys_GetP_original(); //Unused by game
        }

        [Log]
        HSteamPipe IDLLBackend.SW_CCSys_GetPInterface()
        {
            HSteamPipe pipe = SW_CCSys_GetPInterface_original();
            return pipe;
        }

        [Log]
        void IDLLBackend.SW_CCSys_GetU()
        {
        	SW_CCSys_GetU_original(); //Unused by game
        }

        [Log]
        HSteamUser IDLLBackend.SW_CCSys_GetUInterface()
        {
            HSteamUser userHandle = SW_CCSys_GetUInterface_original();
            return userHandle;
        }

        [Log]
        void IDLLBackend.SW_CCSys_InitCallbackFunc(CCallbackBase* callback, CallbackType callbackId)
        {
            //Put trampoline function in place of the original that logs calls and then passes the data to the real callback handler
            CCallbackBase* callbackOverride = null;
            switch (callbackId)
            {
                case .ValidateAuthTicketResponse:
                    CallbackLogger<ValidateAuthTicketResponse>* logger = new .(callback, callbackId);
                    CallbackLoggers.Add(logger);
                    callbackOverride = logger;

                case .GetAuthSessionTicketResponse:
                    CallbackLogger<GetAuthSessionTicketResponse>* logger = new .(callback, callbackId);
                    CallbackLoggers.Add(logger);
                    callbackOverride = logger;

                case .GameLobbyJoinRequested:
                    CallbackLogger<GameLobbyJoinRequested>* logger = new .(callback, callbackId);
                    CallbackLoggers.Add(logger);
                    callbackOverride = logger;

                case .LobbyEnter:
                    /*var callbackTyped = (CCallback<GameLinkInternet, LobbyEnter, 0>*)callback;*/
                    //Had to use a pointer here because I couldn't get a reference or pointer to the struct from the list for some reason. Possibly was the debugger lying to me. It doesn't work perfectly in DLLs.
                    CallbackLogger<LobbyEnter>* logger = new .(callback, callbackId);
                    CallbackLoggers.Add(logger);
                    callbackOverride = logger;

                case .LobbyDataUpdate:
                    CallbackLogger<LobbyDataUpdate>* logger = new .(callback, callbackId);
                    CallbackLoggers.Add(logger);
                    callbackOverride = logger;

                case .LobbyChatUpdate:
                    CallbackLogger<LobbyChatUpdate>* logger = new .(callback, callbackId);
                    CallbackLoggers.Add(logger);
                    callbackOverride = logger;

                case .SteamUserStatsReceived:
                    CallbackLogger<UserStatsReceived>* logger = new .(callback, callbackId);
                    CallbackLoggers.Add(logger);
                    callbackOverride = logger;

                case .SteamUserStatsStored:
                    CallbackLogger<UserStatsStored>* logger = new .(callback, callbackId);
                    CallbackLoggers.Add(logger);
                    callbackOverride = logger;

                case .SteamUserAchievementStored:
                    CallbackLogger<UserAchievementStored>* logger = new .(callback, callbackId);
                    CallbackLoggers.Add(logger);
                    callbackOverride = logger;

                case .P2PSessionRequest:
                    CallbackLogger<P2PSessionRequest>* logger = new .(callback, callbackId);
                    CallbackLoggers.Add(logger);
                    callbackOverride = logger;

                //The vanilla game only uses these with CCallResult<T>. So report a problem if used here.
                case .LobbyMatchList, .LobbyCreated:
                    String errorMessage = scope $"Callback '{callbackId.ToString(.. scope .())}' passed to CommunityBackend.SW_CCSys_InitCallbackFunc(). The vanilla game only passes this to SW_CCSys_RegisterCallResult(). Either something broke or you're using a modded game and this needs to be updated.";
                    Logger.WriteLine(errorMessage);
                    Runtime.FatalError(errorMessage);

                default:
                    String errorMessage = scope $"Unsupported callback ID '{(i32)callbackId}' in CommunityBackend.SW_CCSys_InitCallbackFunc()";
                    Logger.WriteLine(errorMessage);
                    Runtime.FatalError(errorMessage);
            }

            if (callbackOverride != null)
            {
                SW_CCSys_InitCallbackFunc_original(callbackOverride, callbackId);
            }
            else
            {
                //TODO: Once all callbacks are wrapped we'll want this case to throw an error instead so we don't miss any callbacks
                SW_CCSys_InitCallbackFunc_original(callback, callbackId);
            }
        }

        [Log]
        void IDLLBackend.SW_CCSys_RemoveCallbackFunc(CCallbackBase* callback)
        {
            SW_CCSys_RemoveCallbackFunc_original(callback);
        }

        [Log]
        void IDLLBackend.SW_CCSys_IsBackendActive()
        {
        	SW_CCSys_IsBackendActive_original(); //Unused by game
        }

        //[Log]
        void IDLLBackend.SW_CCSys_ProcessApiCb()
        {
            SW_CCSys_ProcessApiCb_original(); //Game uses this but it's just a void func(void)
        }

        [Log]
        void IDLLBackend.SW_CCSys_RegisterCallResult(CCallbackBase* callbackResult, uint32 apiCallHandleLower, uint32 apiCallHandleUpper)
        {
            Logger.WriteLine(scope $"Registering callback. lower: {apiCallHandleLower}, upper: {apiCallHandleUpper}, ID: {callbackResult.CallResultType}, Flags: {callbackResult.CallbackFlags}");

            CCallbackBase* callResultOverride = null;
            switch (callbackResult.CallResultType)
            {
                case .LobbyEnter:
                    if (CallResultLoggers.ContainsKey(.LobbyEnter))
                    {
                        var logger = (CallResultLogger<LobbyEnter>*)CallResultLoggers[.LobbyEnter];
                        logger.Cleanup();
                        delete logger;
                        CallResultLoggers.Remove(.LobbyEnter);
                    }

                    CallResultLogger<LobbyEnter>* logger = new .(callbackResult, apiCallHandleLower, apiCallHandleUpper);
                    CallResultLoggers[callbackResult.CallResultType] = logger;
                    callResultOverride = logger;

                case .LobbyMatchList:
                    if (CallResultLoggers.ContainsKey(.LobbyMatchList))
                    {
                        var logger = (CallResultLogger<LobbyMatchList>*)CallResultLoggers[.LobbyMatchList];
                        logger.Cleanup();
                        delete logger;
                        CallResultLoggers.Remove(.LobbyMatchList);
                    }

                    CallResultLogger<LobbyMatchList>* logger = new .(callbackResult, apiCallHandleLower, apiCallHandleUpper);
                    CallResultLoggers[callbackResult.CallResultType] = logger;
                    callResultOverride = logger;

                case .LobbyCreated:
                    if (CallResultLoggers.ContainsKey(.LobbyCreated))
                    {
                        var logger = (CallResultLogger<LobbyCreated>*)CallResultLoggers[.LobbyCreated];
                        logger.Cleanup();
                        delete logger;
                        CallResultLoggers.Remove(.LobbyCreated);
                    }

                    CallResultLogger<LobbyCreated>* logger = new .(callbackResult, apiCallHandleLower, apiCallHandleUpper);
                    CallResultLoggers[callbackResult.CallResultType] = logger;
                    callResultOverride = logger;

                default:
                    String errorMessage = scope $"Unsupported callback ID '{(i32)callbackResult.CallResultType}' in CommunityBackend.SW_CCSys_RegisterCallResult()";
                    Logger.WriteLine(errorMessage);
                    Runtime.FatalError(errorMessage);
            }

            if (callResultOverride != null)
            {
                SW_CCSys_RegisterCallResult_original(callResultOverride, apiCallHandleLower, apiCallHandleUpper);
            }
            else
            {
                SW_CCSys_RegisterCallResult_original(callbackResult, apiCallHandleLower, apiCallHandleUpper);
            }
        }

        [Log]
        void IDLLBackend.SW_CCSys_UnregisterCallResult(CCallbackBase* callbackResult, uint32 apiCallHandleLower, uint32 apiCallHandleUpper)
        {
            SW_CCSys_UnregisterCallResult_original(callbackResult, apiCallHandleLower, apiCallHandleUpper);
        }

        [Log]
        void IDLLBackend.SW_CCSys_Shutdown()
        {
            SW_CCSys_Shutdown_original();
        }

        [Log]
        void IDLLBackend.SW_CCSys_TestInitialConditions()
        {
        	SW_CCSys_TestInitialConditions_original(); //Unused by game
        }

        [Log]
        bool IDLLBackend.SW_HasAchievements()
        {
            bool hasAchievements = SW_HasAchievements_original();
            return hasAchievements;
        }

        [Log]
        bool IDLLBackend.SW_HasInvites()
        {
            bool hasInvites = SW_HasInvites_original();
            return hasInvites;
        }

        [Log]
        bool IDLLBackend.SW_HasLeaderboards()
        {
            bool hasLeaderboards = SW_HasLeaderboards_original();
            return hasLeaderboards;
        }

        [Log]
        void IDLLBackend.SW_RegisterCallback()
        {
        	SW_RegisterCallback_original(); //Unused by game
        }

        [Log]
        void IDLLBackend.SW_UnregisterCallback()
        {
        	SW_UnregisterCallback_original(); //Unused by game
        }
    }
}