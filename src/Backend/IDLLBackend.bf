using RfgNetworking;
using RfgNetworking.API;

namespace RfgNetworking.Backend
{
    //DLL implementation. Lets Program.bf easily swap between the debug passthrough DLL and the standalone DLL
    public interface IDLLBackend
    {
        public void Init();
        public void Shutdown();

        public bool SW_CCSys_Init();
        public ISteamClient* SW_CCSys_CreateInternalModule(char8* interfaceName);
        public CSteamAPIContext* SW_CCSys_DynamicInit(CallbackCounterAndContext* callbackCounterAndContext);
        public void SW_CCSys_GetP();
        public HSteamPipe SW_CCSys_GetPInterface();
        public void SW_CCSys_GetU();
        public HSteamUser SW_CCSys_GetUInterface();
        public void SW_CCSys_InitCallbackFunc(CCallbackBase* callback, CallbackType callbackId);
        public void SW_CCSys_RemoveCallbackFunc(CCallbackBase* callback);
        public void SW_CCSys_IsBackendActive();
        public void SW_CCSys_ProcessApiCb();
        public void SW_CCSys_RegisterCallResult(CCallbackBase* callbackResult, u32 apiCallHandleLower, u32 apiCallHandleUpper);
        public void SW_CCSys_UnregisterCallResult(CCallbackBase* callbackResult, u32 apiCallHandleLower, u32 apiCallHandleUpper);
        public void SW_CCSys_Shutdown();
        public void SW_CCSys_TestInitialConditions();
        public bool SW_HasAchievements();
        public bool SW_HasInvites();
        public bool SW_HasLeaderboards();
        public void SW_RegisterCallback();
        public void SW_UnregisterCallback();
    }
}