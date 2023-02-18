using RfgNetworking.Win32;
using RfgNetworking.Misc;
using RfgNetworking.API;
using System.Threading;
using System.IO;
using System;

namespace RfgNetworkAPI
{
    [AlwaysInclude]
    public static class Program
    {
#region DllInit
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
        //static function void(CCallbackBase* callbackResult, u64 apiCallHandle) SW_CCSys_RegisterCallResult_original = null;
        static function void(CCallbackBase* callbackResult, u32 apiCallHandleLower, u32 apiCallHandleUpper) SW_CCSys_RegisterCallResult_original = null;
        //static function void(CCallbackBase* callbackResult, u32 apiCallHandleUpper, void* resultObject) SW_CCSys_UnregisterCallResult_original = null;
        static function void(CCallbackBase* callbackResult, u32 apiCallHandleLower, u32 apiCallHandleUpper) SW_CCSys_UnregisterCallResult_original = null;
        static function void() SW_CCSys_Shutdown_original = null;
        static function void() SW_CCSys_TestInitialConditions_original = null;
        static function bool() SW_HasAchievements_original = null;
        static function bool() SW_HasInvites_original = null;
        static function bool() SW_HasLeaderboards_original = null;
        static function void() SW_RegisterCallback_original = null;
        static function void() SW_UnregisterCallback_original = null;

        //Input thread state
        static Thread _inputThread = new .(new () => Program.InputThreadLoop());
        static bool _exit = false;

        static HINSTANCE _originalDLLHandle = 0;

        public static this()
        {
            System.Threading.Thread.Sleep(5000);

            Logger.Init();
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

        public static ~this()
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
            Logger.Shutdown();
        }

        public static mixin GetDLLFunction<T>(HINSTANCE dllHandle, T* func, char8* name) where T : operator explicit void*
        {
            *func = (T)(void*)Win32.GetProcAddress(dllHandle, name);
        }
#endregion DllInit

        //TODO: Move these + the init/hooking code to separate files. Ideally do it via an interface so you can easily swap between using debug wrappers and the standalone DLL.
        //      The end goal is to fully replace the original sw_api.dll. But I want to keep the option of using this as a wrapper DLL to log the input/output of the original DLL.
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

        [Export, CLink, Log]
        public static bool SW_CCSys_Init()
        {
            bool result = SW_CCSys_Init_original();
            return result;
        }

        [Export, CLink, Log]
        public static HSteamUser SW_CCSys_GetUInterface()
        {
        	HSteamUser userHandle = SW_CCSys_GetUInterface_original();
        	return userHandle;
        }

        [Export, CLink, Log]
        public static HSteamPipe SW_CCSys_GetPInterface()
        {
        	HSteamPipe pipe = SW_CCSys_GetPInterface_original();
        	return pipe;
        }

        [Export, CLink, Log]
        public static ISteamClient* SW_CCSys_CreateInternalModule(char8* interfaceVersion)
        {
            ISteamClient* steamClient = SW_CCSys_CreateInternalModule_original(interfaceVersion);
            if (!steamClientWrapperInitialized)
            {
                Logger.WriteLine(scope $"{steamClient}");
                SteamClientWrapper.Init(steamClient, steamClient.Vtable);
                steamClientWrapperInitialized = true;
                return &SteamClientWrapper;
			}
            return steamClient;
        }


        [Export, CLink]
        public static CSteamAPIContext* SW_CCSys_DynamicInit(CallbackCounterAndContext* callbackCounterAndContext)
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

        [Export, CLink, Log]
        public static void SW_CCSys_InitCallbackFunc(CCallbackBase* callbackFunc, i32 callbackId)
        {
            //TODO: Try to make a ToString-able enum for callbackId (if viable)
            //TODO: Go through all ~~~CallBack~~~ classes in rfg.exe that inherit CCallbackBase. Look at constructors to see their callback id
            //TODO: See if vanilla sw_api has special behavior for each call back
            //TODO: ^^ Do the same to SW_CCSys_RegisterCallResult
        	SW_CCSys_InitCallbackFunc_original(callbackFunc, callbackId);
        }

        [Export, CLink, Log]
        public static void SW_CCSys_RemoveCallbackFunc(CCallbackBase* callbackFunc)
        {
        	SW_CCSys_RemoveCallbackFunc_original(callbackFunc);
        }

        [Export, CLink] //Note: Log disabled since it seems to be called every frame
        public static void SW_CCSys_ProcessApiCb()
        {
        	SW_CCSys_ProcessApiCb_original(); //Game uses this but it's just a void func(void)
        }

        [Export, CLink, Log]
        public static void SW_CCSys_RegisterCallResult(CCallbackBase* callbackResult, u32 apiCallHandleLower, u32 apiCallHandleUpper)
        {
        	SW_CCSys_RegisterCallResult_original(callbackResult, apiCallHandleLower, apiCallHandleUpper);//apiCallHandle);
        }

        [Export, CLink, Log]
        public static void SW_CCSys_UnregisterCallResult(CCallbackBase* callbackResult, u32 apiCallHandleLower, u32 apiCallHandleUpper)
        {
        	SW_CCSys_UnregisterCallResult_original(callbackResult, apiCallHandleLower, apiCallHandleUpper);
        }

        [Export, CLink, Log]
        public static void SW_CCSys_Shutdown()
        {
        	SW_CCSys_Shutdown_original();
        }

        [Export, CLink, Log]
        public static bool SW_HasAchievements()
        {
        	bool hasAchievements = SW_HasAchievements_original();
        	return hasAchievements;
        }

        [Export, CLink, Log]
        public static bool SW_HasInvites()
        {
        	bool hasInvites = SW_HasInvites_original();
        	return hasInvites;
        }

        [Export, CLink, Log]
        public static bool SW_HasLeaderboards()
        {
        	bool hasLeaderboards = SW_HasLeaderboards_original();
        	return hasLeaderboards;
        }

#region Unused
        [Export, CLink, Log]
        public static void SW_CCSys_IsBackendActive()
        {
        	SW_CCSys_IsBackendActive_original(); //Unused by game
        }

        [Export, CLink, Log]
        public static void SW_CCSys_TestInitialConditions()
        {
        	SW_CCSys_TestInitialConditions_original(); //Unused by game
        }

        [Export, CLink, Log]
        public static void SW_RegisterCallback()
        {
        	SW_RegisterCallback_original(); //Unused by game
        }

        [Export, CLink, Log]
        public static void SW_UnregisterCallback()
        {
        	SW_UnregisterCallback_original(); //Unused by game
        }

        [Export, CLink, Log]
        public static void SW_CCSys_GetP()
        {
        	SW_CCSys_GetP_original(); //Unused by game
        }

        [Export, CLink, Log]
        public static void SW_CCSys_GetU()
        {
        	SW_CCSys_GetU_original(); //Unused by game
        }
#endregion Unused
    }
}