using RfgNetworkAPI.Steam;
using RfgNetworkAPI.Win32;
using System;

namespace RfgNetworkAPI
{
    [AlwaysInclude]
    public static class Program
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
        static function void(CCallbackBase* callbackResult, u64 apiCallHandle) SW_CCSys_RegisterCallResult_original = null;
        static function void(CCallbackBase* callbackResult, u32 apiCallHandleUpper, void* resultObject) SW_CCSys_UnregisterCallResult_original = null;
        static function void() SW_CCSys_Shutdown_original = null;
        static function void() SW_CCSys_TestInitialConditions_original = null;
        static function bool() SW_HasAchievements_original = null;
        static function bool() SW_HasInvites_original = null;
        static function bool() SW_HasLeaderboards_original = null;
        static function void() SW_RegisterCallback_original = null;
        static function void() SW_UnregisterCallback_original = null;

        static HINSTANCE _originalDLLHandle = 0;

        public static this()
        {
            System.Threading.Thread.Sleep(10000);

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
        }

        public static ~this()
        {
            if (_originalDLLHandle != 0)
            {
                Win32.FreeLibrary(_originalDLLHandle);
            }
        }

        public static mixin GetDLLFunction<T>(HINSTANCE dllHandle, T* func, char8* name) where T : operator explicit void*
        {
            *func = (T)(void*)Win32.GetProcAddress(dllHandle, name);
        }

        [Export, CLink]
        public static bool SW_CCSys_Init()
        {
            bool result = SW_CCSys_Init_original();
            return result;
        }

        [Export, CLink]
        public static ISteamClient* SW_CCSys_CreateInternalModule(char8* interfaceVersion)
        {
            ISteamClient* steamClient = SW_CCSys_CreateInternalModule_original(interfaceVersion);
            return steamClient;
        }

        [Export, CLink]
        public static CSteamAPIContext* SW_CCSys_DynamicInit(void** callbackCounterAndContext) //arg is possibly a void*[23] ???
        {
        	CSteamAPIContext* steamApiContext = SW_CCSys_DynamicInit_original(callbackCounterAndContext);
        	return steamApiContext;
        }

        [Export, CLink]
        public static void SW_CCSys_GetP()
        {
        	SW_CCSys_GetP_original(); //Unused by game
        }

        [Export, CLink]
        public static HSteamPipe SW_CCSys_GetPInterface()
        {
        	HSteamPipe pipe = SW_CCSys_GetPInterface_original();
        	return pipe;
        }

        [Export, CLink]
        public static void SW_CCSys_GetU()
        {
        	SW_CCSys_GetU_original(); //Unused by game
        }

        [Export, CLink]
        public static HSteamUser SW_CCSys_GetUInterface()
        {
        	HSteamUser userHandle = SW_CCSys_GetUInterface_original();
        	return userHandle;
        }

        [Export, CLink]
        public static void SW_CCSys_InitCallbackFunc(void* callbackFunc, i32 callbackId) //Could callbackId be a u64?
        {
        	SW_CCSys_InitCallbackFunc_original(callbackFunc, callbackId);
        }

        [Export, CLink]
        public static void SW_CCSys_RemoveCallbackFunc(void* callbackFunc)
        {
        	SW_CCSys_RemoveCallbackFunc_original(callbackFunc);
        }

        [Export, CLink]
        public static void SW_CCSys_IsBackendActive()
        {
        	SW_CCSys_IsBackendActive_original(); //Unused by game
        }

        [Export, CLink]
        public static void SW_CCSys_ProcessApiCb()
        {
        	SW_CCSys_ProcessApiCb_original(); //Game uses this but it's just a void func(void)
        }

        [Export, CLink]
        public static void SW_CCSys_RegisterCallResult(CCallbackBase* callbackResult, u64 apiCallHandle)
        {
        	SW_CCSys_RegisterCallResult_original(callbackResult, apiCallHandle);
        }

        [Export, CLink]
        public static void SW_CCSys_UnregisterCallResult(CCallbackBase* callbackResult, u32 apiCallHandleUpper, void* resultObject) //Don't know what the second arg really is
        {
        	SW_CCSys_UnregisterCallResult_original(callbackResult, apiCallHandleUpper, resultObject);
        }

        [Export, CLink]
        public static void SW_CCSys_Shutdown()
        {
        	SW_CCSys_Shutdown_original();
        }

        [Export, CLink]
        public static void SW_CCSys_TestInitialConditions()
        {
        	SW_CCSys_TestInitialConditions_original(); //Unused by game
        }

        [Export, CLink]
        public static bool SW_HasAchievements()
        {
        	bool hasAchievements = SW_HasAchievements_original();
        	return hasAchievements;
        }

        [Export, CLink]
        public static bool SW_HasInvites()
        {
        	bool hasInvites = SW_HasInvites_original();
        	return hasInvites;
        }

        [Export, CLink]
        public static bool SW_HasLeaderboards()
        {
        	//bool hasLeaderboards = SW_HasLeaderboards();
        	//return hasLeaderboards;
        	return true;
        }

        [Export, CLink]
        public static void SW_RegisterCallback()
        {
        	SW_RegisterCallback_original(); //Unused by game
        }

        [Export, CLink]
        public static void SW_UnregisterCallback()
        {
        	SW_UnregisterCallback_original(); //Unused by game
        }
    }
}