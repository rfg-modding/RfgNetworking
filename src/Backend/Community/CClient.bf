using RfgNetworking.API;

namespace RfgNetworking.Backend.Community
{
    public struct CClient : ISteamClient
    {
        private static readonly var DummyPointerValue = 0xDEADC0DE; //Unimplemented interfaces are set to this to make it obvious

        public void ModuleInit() mut
        {
            Vtable = new ISteamClient.VTable();
            Vtable.CreateSteamPipe = => CreateSteamPipe;
            Vtable.BReleaseSteamPipe = => BReleaseSteamPipe;
            Vtable.ConnectToGlobalUser = => ConnectToGlobalUser;
            Vtable.CreateLocalUser = => CreateLocalUser;
            Vtable.ReleaseUser = => ReleaseUser;
            Vtable.GetISteamUser = => GetISteamUser;
            Vtable.GetISteamGameServer = => GetISteamGameServer;
            Vtable.SetLocalIPBinding = => SetLocalIPBinding;
            Vtable.GetISteamFriends = => GetISteamFriends;
            Vtable.GetISteamUtils = => GetISteamUtils;
            Vtable.GetISteamMatchmaking = => GetISteamMatchmaking;
            Vtable.GetISteamMatchmakingServers = => GetISteamMatchmakingServers;
            Vtable.GetISteamGenericInterface = => GetISteamGenericInterface;
            Vtable.GetISteamUserStats = => GetISteamUserStats;
            Vtable.GetISteamGameServerStats = => GetISteamGameServerStats;
            Vtable.GetISteamApps = => GetISteamApps;
            Vtable.GetISteamNetworking = => GetISteamNetworking;
            Vtable.GetISteamRemoteStorage = => GetISteamRemoteStorage;
            Vtable.GetISteamScreenshots = => GetISteamScreenshots;
            Vtable.RunFrame = => RunFrame;
            Vtable.GetIPCCallCount = => GetIPCCallCount;
            Vtable.SetWarningMessageHook = => SetWarningMessageHook;
            Vtable.BShutdownIfAllPipesClosed = => BShutdownIfAllPipesClosed;
            Vtable.GetISteamHTTP = => GetISteamHTTP;
            Vtable.DEPRECATED_GetISteamUnifiedMessages = => DEPRECATED_GetISteamUnifiedMessages;
            Vtable.GetISteamController = => GetISteamController;
            Vtable.GetISteamUGC = => GetISteamUGC;
            Vtable.GetISteamAppList = => GetISteamAppList;
            Vtable.GetISteamMusic = => GetISteamMusic;
            Vtable.GetISteamMusicRemote = => GetISteamMusicRemote;
            Vtable.GetISteamHTMLSurface = => GetISteamHTMLSurface;
            Vtable.DEPRECATED_Set_SteamAPI_CPostAPIResultInProcess = => DEPRECATED_Set_SteamAPI_CPostAPIResultInProcess;
            Vtable.DEPRECATED_Remove_SteamAPI_CPostAPIResultInProcess = => DEPRECATED_Remove_SteamAPI_CPostAPIResultInProcess;
            Vtable.Set_SteamAPI_CCheckCallbackRegisteredInProcess = => Set_SteamAPI_CCheckCallbackRegisteredInProcess;
            Vtable.GetISteamInventory = => GetISteamInventory;
            Vtable.GetISteamVideo = => GetISteamVideo;
            Vtable.GetISteamParentalSettings = => GetISteamParentalSettings;
        }

        public void ModuleShutdown()
        {
            delete Vtable;
        }

        public HSteamPipe CreateSteamPipe()
        {
            return 0;
        }

        public bool BReleaseSteamPipe(HSteamPipe hSteamPipe)
        {
            return true;
        }

        public HSteamUser ConnectToGlobalUser(HSteamPipe hSteamPipe)
        {
            return 0;
        }

        public HSteamUser CreateLocalUser(HSteamPipe hSteamPipe, AccountType eAccountType)
        {
            return 0;
        }

        public void ReleaseUser(HSteamPipe hSteamPipe, HSteamUser hUser)
        {

        }

        public ISteamUser* GetISteamUser(HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion)
        {
            return &CommunityBackend.User;
        }

        public ISteamGameServer* GetISteamGameServer(HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion)
        {
            return (ISteamGameServer*)(void*)(int)DummyPointerValue;
        }

        public void SetLocalIPBinding(uint32 unIP, uint16 usPort)
        {

        }

        public ISteamFriends* GetISteamFriends(HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion)
        {
            return &CommunityBackend.Friends;
        }

        public ISteamUtils* GetISteamUtils(HSteamPipe hSteamPipe, char8* pchVersion)
        {
            return &CommunityBackend.Utils;
        }

        public ISteamMatchmaking* GetISteamMatchmaking(HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion)
        {
            return &CommunityBackend.Matchmaking;
        }

        public ISteamMatchmakingServers* GetISteamMatchmakingServers(HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion)
        {
            return (ISteamMatchmakingServers*)(void*)(int)DummyPointerValue;
        }

        public void* GetISteamGenericInterface(HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion)
        {
            return null;
        }

        public ISteamUserStats* GetISteamUserStats(HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion)
        {
            return &CommunityBackend.UserStats;
        }

        public ISteamGameServerStats* GetISteamGameServerStats(HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion)
        {
            return (ISteamGameServerStats*)(void*)(int)DummyPointerValue;
        }

        public ISteamApps* GetISteamApps(HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion)
        {
            return &CommunityBackend.Apps;
        }

        public ISteamNetworking* GetISteamNetworking(HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion)
        {
            return &CommunityBackend.Networking;
        }

        public ISteamRemoteStorage* GetISteamRemoteStorage(HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion)
        {
            return &CommunityBackend.RemoteStorage;
        }

        public ISteamScreenshots* GetISteamScreenshots(HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion)
        {
            return (ISteamScreenshots*)(void*)(int)DummyPointerValue;
        }

        public void RunFrame()
        {

        }

        public uint32 GetIPCCallCount()
        {
            return 0;
        }

        public void SetWarningMessageHook(function void(int32 severity, char8* pchDebugText) pFunction)
        {

        }

        public bool BShutdownIfAllPipesClosed()
        {
            return true;
        }

        public ISteamHTTP* GetISteamHTTP(HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion)
        {
            return (ISteamHTTP*)(void*)(int)DummyPointerValue;
        }

        public ISteamUnifiedMessages* DEPRECATED_GetISteamUnifiedMessages(HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion)
        {
            return (ISteamUnifiedMessages*)(void*)(int)DummyPointerValue;
        }

        public ISteamController* GetISteamController(HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion)
        {
            return &CommunityBackend.Controller;
        }

        public ISteamUGC* GetISteamUGC(HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion)
        {
            return (ISteamUGC*)(void*)(int)DummyPointerValue;
        }

        public ISteamAppList* GetISteamAppList(HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion)
        {
            return (ISteamAppList*)(void*)(int)DummyPointerValue;
        }

        public ISteamMusic* GetISteamMusic(HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion)
        {
            return (ISteamMusic*)(void*)(int)DummyPointerValue;
        }

        public ISteamMusicRemote* GetISteamMusicRemote(HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion)
        {
            return (ISteamMusicRemote*)(void*)(int)DummyPointerValue;
        }

        public ISteamHTMLSurface* GetISteamHTMLSurface(HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion)
        {
            return (ISteamHTMLSurface*)(void*)(int)DummyPointerValue;
        }

        public void DEPRECATED_Set_SteamAPI_CPostAPIResultInProcess(function void() pFunc)
        {

        }

        public void DEPRECATED_Remove_SteamAPI_CPostAPIResultInProcess(function void() pFunc)
        {

        }

        public void Set_SteamAPI_CCheckCallbackRegisteredInProcess(function uint32(int32 arg00) pFunc)
        {

        }

        public ISteamInventory* GetISteamInventory(HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion)
        {
            return (ISteamInventory*)(void*)(int)DummyPointerValue;
        }

        public ISteamVideo* GetISteamVideo(HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion)
        {
            return (ISteamVideo*)(void*)(int)DummyPointerValue;
        }

        public ISteamParentalSettings* GetISteamParentalSettings(HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion)
        {
            return (ISteamParentalSettings*)(void*)(int)DummyPointerValue;
        }
    }    
}