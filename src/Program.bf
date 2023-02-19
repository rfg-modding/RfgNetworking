using RfgNetworking.Backend.Community;
using RfgNetworking.Backend.Debug;
using RfgNetworking.Backend;
using RfgNetworking.Misc;
using RfgNetworking.API;
using System;

//When uncommented this DLL will act as a wrapper DLL to log calls to the original sw_api.dll. Otherwise it'll be a standalone DLL
//#define UseDebugBackend

namespace RfgNetworking
{
    [AlwaysInclude]
    public static class Program
    {
        private static IDLLBackend _backend = null;

        public static this()
        {
            Logger.Init();

#if UseDebugBackend
            _backend = new DebugBackend();
#else
            _backend = new CommunityBackend();
#endif
            _backend.Init();
        }

        public static ~this()
        {
            _backend.Shutdown();
            Logger.Shutdown();
        }

        [Export, CLink]
        public static bool SW_CCSys_Init()
        {
            return _backend.SW_CCSys_Init();
        }

        [Export, CLink]
        public static HSteamUser SW_CCSys_GetUInterface()
        {
            return _backend.SW_CCSys_GetUInterface();
        }

        [Export, CLink]
        public static HSteamPipe SW_CCSys_GetPInterface()
        {
            return _backend.SW_CCSys_GetPInterface();
        }

        [Export, CLink]
        public static ISteamClient* SW_CCSys_CreateInternalModule(char8* interfaceVersion)
        {
            return _backend.SW_CCSys_CreateInternalModule(interfaceVersion);
        }

        [Export, CLink]
        public static CSteamAPIContext* SW_CCSys_DynamicInit(CallbackCounterAndContext* callbackCounterAndContext)
        {
            return _backend.SW_CCSys_DynamicInit(callbackCounterAndContext);
        }

        [Export, CLink]
        public static void SW_CCSys_InitCallbackFunc(CCallbackBase* callbackFunc, i32 callbackId)
        {
            _backend.SW_CCSys_InitCallbackFunc(callbackFunc, callbackId);
        }

        [Export, CLink]
        public static void SW_CCSys_RemoveCallbackFunc(CCallbackBase* callbackFunc)
        {
            _backend.SW_CCSys_RemoveCallbackFunc(callbackFunc);
        }

        [Export, CLink]
        public static void SW_CCSys_ProcessApiCb()
        {
            _backend.SW_CCSys_ProcessApiCb();
        }

        [Export, CLink]
        public static void SW_CCSys_RegisterCallResult(CCallbackBase* callbackResult, u32 apiCallHandleLower, u32 apiCallHandleUpper)
        {
            _backend.SW_CCSys_RegisterCallResult(callbackResult, apiCallHandleLower, apiCallHandleUpper);
        }

        [Export, CLink]
        public static void SW_CCSys_UnregisterCallResult(CCallbackBase* callbackResult, u32 apiCallHandleLower, u32 apiCallHandleUpper)
        {
            _backend.SW_CCSys_UnregisterCallResult(callbackResult, apiCallHandleLower, apiCallHandleUpper);
        }

        [Export, CLink]
        public static void SW_CCSys_Shutdown()
        {
            _backend.SW_CCSys_Shutdown();
        }

        [Export, CLink]
        public static bool SW_HasAchievements()
        {
            return _backend.SW_HasAchievements();
        }

        [Export, CLink]
        public static bool SW_HasInvites()
        {
            return _backend.SW_HasInvites();
        }

        [Export, CLink]
        public static bool SW_HasLeaderboards()
        {
            return _backend.SW_HasLeaderboards();
        }

        [Export, CLink]
        public static void SW_CCSys_IsBackendActive()
        {
            _backend.SW_CCSys_IsBackendActive();
        }

        [Export, CLink]
        public static void SW_CCSys_TestInitialConditions()
        {
            _backend.SW_CCSys_TestInitialConditions();
        }

        [Export, CLink]
        public static void SW_RegisterCallback()
        {
            _backend.SW_RegisterCallback();
        }

        [Export, CLink]
        public static void SW_UnregisterCallback()
        {
            _backend.SW_UnregisterCallback();
        }

        [Export, CLink]
        public static void SW_CCSys_GetP()
        {
            _backend.SW_CCSys_GetP();
        }

        [Export, CLink]
        public static void SW_CCSys_GetU()
        {
            _backend.SW_CCSys_GetU();
        }
    }
}