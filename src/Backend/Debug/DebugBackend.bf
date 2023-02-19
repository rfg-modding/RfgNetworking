using RfgNetworking.Backend;
using RfgNetworking.Win32;
using RfgNetworking.Misc;
using RfgNetworking.API;
using System.Threading;
using System;

namespace RfgNetworking.Backend.Debug
{
    //Wrapper DLL backend. Passes all function calls to the original and logs their arguments & results
    public class DebugBackend : IDLLBackend
    {
        static function bool() SW_CCSys_Init_original = null;
        static function ISteamClient*(char8* interfaceName) SW_CCSys_CreateInternalModule_original = null;
        static function CSteamAPIContext*(void** callbackCounterAndContext) SW_CCSys_DynamicInit_original = null;
        static function void() SW_CCSys_GetP_original = null;
        static function HSteamPipe() SW_CCSys_GetPInterface_original = null;
        static function void() SW_CCSys_GetU_original = null;
        static function HSteamUser() SW_CCSys_GetUInterface_original = null;
        static function void(void* callbackFunc, i32 callbackId) SW_CCSys_InitCallbackFunc_original = null;
        static function void(void* callbackFunc) SW_CCSys_RemoveCallbackFunc_original = null;
        static function void() SW_CCSys_IsBackendActive_original = null;
        static function void() SW_CCSys_ProcessApiCb_original = null;
        static function void(CCallbackBase* callbackResult, u32 apiCallHandleLower, u32 apiCallHandleUpper) SW_CCSys_RegisterCallResult_original = null;
        static function void(CCallbackBase* callbackResult, u32 apiCallHandleLower, u32 apiCallHandleUpper) SW_CCSys_UnregisterCallResult_original = null;
        static function void() SW_CCSys_Shutdown_original = null;
        static function void() SW_CCSys_TestInitialConditions_original = null;
        static function bool() SW_HasAchievements_original = null;
        static function bool() SW_HasInvites_original = null;
        static function bool() SW_HasLeaderboards_original = null;
        static function void() SW_RegisterCallback_original = null;
        static function void() SW_UnregisterCallback_original = null;

        //Input thread state
        static Thread _inputThread = new .(new () => InputThreadLoop());
        static bool _exit = false;

        static HINSTANCE _originalDLLHandle = 0;

        //Interface logging wrappers
        static bool steamClientWrapperInitialized = false;
        static append SteamClientDebugWrapper SteamClientWrapper;
        static append SteamUserDebugWrapper SteamUserWrapper;
        static append SteamFriendsDebugWrapper SteamFriendsWrapper;
        static append SteamUtilsDebugWrapper SteamUtilsWrapper;
        static append SteamMatchmakingDebugWrapper SteamMatchmakingWrapper;
        static append SteamUserStatsDebugWrapper SteamUserStatsWrapper;
        static append SteamAppsDebugWrapper SteamAppsWrapper;
        static append SteamNetworkingDebugWrapper SteamNetworkingWrapper;
        static append SteamRemoteStorageDebugWrapper SteamRemoteStorageWrapper;
        static append SteamControllerDebugWrapper SteamControllerWrapper;

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
        public static void InputThreadLoop()
        {
            while (!_exit)
            {
                bool keyUpStateF1 = (Win32.GetKeyState(0x70) & 0x8000) == 0; //True if F1 key is up
                if (keyUpStateF1 && !_lastKeyUpStateF1)
                {
                    LogDebugWrappersState();
                }
                _lastKeyUpStateF1 = keyUpStateF1;
            }
        }

        private static void LogDebugWrappersState()
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

        [Log]
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
        void IDLLBackend.SW_CCSys_InitCallbackFunc(void* callbackFunc, int32 callbackId)
        {
            SW_CCSys_InitCallbackFunc_original(callbackFunc, callbackId);
        }

        [Log]
        void IDLLBackend.SW_CCSys_RemoveCallbackFunc(void* callbackFunc)
        {
            SW_CCSys_RemoveCallbackFunc_original(callbackFunc);
        }

        [Log]
        void IDLLBackend.SW_CCSys_IsBackendActive()
        {
        	SW_CCSys_IsBackendActive_original(); //Unused by game
        }

        [Log]
        void IDLLBackend.SW_CCSys_ProcessApiCb()
        {
            SW_CCSys_ProcessApiCb_original(); //Game uses this but it's just a void func(void)
        }

        [Log]
        void IDLLBackend.SW_CCSys_RegisterCallResult(CCallbackBase* callbackResult, uint32 apiCallHandleLower, uint32 apiCallHandleUpper)
        {
            SW_CCSys_RegisterCallResult_original(callbackResult, apiCallHandleLower, apiCallHandleUpper);
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