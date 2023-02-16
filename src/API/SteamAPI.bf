using System;

namespace RfgNetworking.API
{
    typealias HSteamPipe = i32;
    typealias HSteamUser = i32;
    typealias AppId_t = u32;
    typealias SteamAPICall_t = u64;

    public static class DebugWrapperContext
    {
        public static CSteamAPIContext* SteamAPIContext = null;
        public static CallbackCounterAndContext* InitContext = null;
    }

    [CRepr]
    public struct CSteamAPIContext
    {
        public ISteamClient* Client;
        public ISteamUser* User;
        public ISteamFriends* Friends;
        public ISteamUtils* Utils;
        public ISteamMatchmaking* Matchmaking;
        public ISteamUserStats* UserStats;
        public ISteamApps* Apps;
        public ISteamMatchmakingServers* MatchmakingServers;
        public ISteamNetworking* Networking;
        public ISteamRemoteStorage* RemoteStorage;
        public ISteamScreenshots* Screenshots;
        public ISteamHTTP* HTTP;
        public ISteamController* Controller;
        public ISteamUGC* UGC;
        public ISteamAppList* AppList;
        public ISteamMusic* Music;
        public ISteamMusicRemote* MusicRemote;
        public ISteamHTMLSurface* HTMLSurface;
        public ISteamInventory* Inventory;
        public ISteamVideo* Video;
        public ISteamParentalSettings* ParentalSettings;
    }

    //Structure the game passes to sw_api.dll to ensure its initialized before use
    [CRepr]
    struct CallbackCounterAndContext
    {
        //The game sets this to SteamInternal_OnContextInit prior to calling SW_CCSysDynamicInit. The game uses this callback to set the pointers in Context
        public function void(CSteamAPIContext* context) InitCallback;
        public i32 Counter; //The number of times SW_CCSys_DynamicInit has been called
        public CSteamAPIContext* Context;
    }

    //Meant to imitate the real ISteamClient interface that the real sw_api.dll provides. The GOG version of sw_api.dll seems to something similar.
    [CRepr]
    public struct ISteamClient
    {
        public ISteamClient.VTable* Vtable;

        [CRepr]
        public struct VTable
        {
            public function HSteamPipe(ISteamClient* this) CreateSteamPipe;
            public function bool(ISteamClient* this, HSteamPipe hSteamPipe) BReleaseSteamPipe;
            public function HSteamUser(ISteamClient* this, HSteamPipe hSteamPipe) ConnectToGlobalUser;
            public function HSteamUser(ISteamClient* this, HSteamPipe hSteamPipe, EAccountType eAccountType) CreateLocalUser;
            public function void(ISteamClient* this, HSteamPipe hSteamPipe, HSteamUser hUser) ReleaseUser;
            public function ISteamUser*(ISteamClient* this, HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion) GetISteamUser;
            public function ISteamGameServer*(ISteamClient* this, HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion) GetISteamGameServer;
            public function void(ISteamClient* this, u32 unIP, u16 usPort) SetLocalIPBinding;
            public function ISteamFriends*(ISteamClient* this, HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion) GetISteamFriends;
            public function ISteamUtils*(ISteamClient* this, HSteamPipe hSteamPipe, char8* pchVersion) GetISteamUtils;
            public function ISteamMatchmaking*(ISteamClient* this, HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion) GetISteamMatchmaking;
            public function ISteamMatchmakingServers*(ISteamClient* this, HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion) GetISteamMatchmakingServers;
            public function void*(ISteamClient* this, HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion) GetISteamGenericInterface;
            public function ISteamUserStats*(ISteamClient* this, HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion) GetISteamUserStats;
            public function ISteamGameServerStats*(ISteamClient* this, HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion) GetISteamGameServerStats;
            public function ISteamApps*(ISteamClient* this, HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion) GetISteamApps;
            public function ISteamNetworking*(ISteamClient* this, HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion) GetISteamNetworking;
            public function ISteamRemoteStorage*(ISteamClient* this, HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion) GetISteamRemoteStorage;
            public function ISteamScreenshots*(ISteamClient* this, HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion) GetISteamScreenshots;
            public function void(ISteamClient* this) RunFrame;
            public function u32(ISteamClient* this) GetIPCCallCount;
            public function void(ISteamClient* this, function void(i32 severity, char8* pchDebugText) pFunction) SetWarningMessageHook;
            public function bool(ISteamClient* this) BShutdownIfAllPipesClosed;
            public function ISteamHTTP*(ISteamClient* this, HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion) GetISteamHTTP;
            public function ISteamUnifiedMessages*(ISteamClient* this, HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion) DEPRECATED_GetISteamUnifiedMessages;
            public function ISteamController*(ISteamClient* this, HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion) GetISteamController;
            public function ISteamUGC*(ISteamClient* this, HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion) GetISteamUGC;
            public function ISteamAppList*(ISteamClient* this, HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion) GetISteamAppList;
            public function ISteamMusic*(ISteamClient* this, HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion) GetISteamMusic;
            public function ISteamMusicRemote*(ISteamClient* this, HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion) GetISteamMusicRemote;
            public function ISteamHTMLSurface*(ISteamClient* this, HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion) GetISteamHTMLSurface;
            public function void(ISteamClient* this, function void() pFunc) DEPRECATED_Set_SteamAPI_CPostAPIResultInProcess;
            public function void(ISteamClient* this, function void() pFunc) DEPRECATED_Remove_SteamAPI_CPostAPIResultInProcess;
            public function void(ISteamClient* this, function u32(i32 arg00) pFunc) Set_SteamAPI_CCheckCallbackRegisteredInProcess;
            public function ISteamInventory*(ISteamClient* this, HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion) GetISteamInventory;
            public function ISteamVideo*(ISteamClient* this, HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion) GetISteamVideo;
            public function ISteamParentalSettings*(ISteamClient* this, HSteamUser hSteamUser, HSteamPipe hSteamPipe, char8* pchVersion) GetISteamParentalSettings;
        }
    }

    [CRepr]
    public struct ISteamUser
    {
        public ISteamUser.VTable* Vtable;

        //Todo: Define remaining functions

        [CRepr]
        public struct VTable
        {
            public function HSteamUser(ISteamUser* this) SW_CCSys_GetU;
            public function bool(ISteamUser* this) BLoggedOn;
            public function CSteamID*(ISteamUser* this, CSteamID* __return) GetSteamID;
            public function i32(ISteamUser* this, void* pAuthBlob, i32 cbMaxAuthBlob, CSteamID steamIDGameServer, u32 unIPServer, u16 usPortServer, bool bSecure) InitiateGameConnection;
            public function void(ISteamUser* this, u32 unIPServer, u16 usPortServer) TerminateGameConnection;
            public function void(ISteamUser* this, CGameID gameID, i32 eAppUsageEvent, char8* pchExtraInfo) TrackAppUsageEvent;
            public function bool(ISteamUser* this, char8* pchBuffer, i32 cubBuffer) GetUserDataFolder;
            public function void(ISteamUser* this) StartVoiceRecording;
            public function void(ISteamUser* this) StopVoiceRecording;
            public function EVoiceResult(ISteamUser* this, u32* pcbCompressed, u32* pcbUncompressed_Deprecated, u32 nUncompressedVoiceDesiredSampleRate_Deprecated) GetAvailableVoice;
            public function EVoiceResult(ISteamUser* this, bool bWantCompressed, void* pDestBuffer, u32 cbDestBufferSize, uint32* nBytesWritten, bool bWantUncompressed_Deprecated, void* pUncompressedDestBuffer_Deprecated, u32 cbUncompressedDestBufferSize_Deprecated, u32* nUncompressBytesWritten_Deprecated, u32 nUncompressedVoiceDesiredSampleRate_Deprecated) GetVoice;
            public function EVoiceResult(ISteamUser* this, void* pCompressed, u32 cbCompressed, void* pDestBuffer, u32 cbDestBufferSize, u32* nBytesWritten, u32 nDesiredSampleRate) DecompressVoice;
            public function u32(ISteamUser* this) GetVoiceOptimalSampleRate;
            public function HAuthTicket(ISteamUser* this, void* pTicket, i32 cbMaxTicket, u32* pcbTicket) GetAuthSessionTicket;
            public function EBeginAuthSessionResult(ISteamUser* this, void* pAuthTicket, i32 cbAuthTicket, CSteamID steamID) BeginAuthSession;
            public function void(ISteamUser* this, CSteamID steamID) EndAuthSession;
            public function void(ISteamUser* this, HAuthTicket hAuthTicket) CancelAuthTicket;
            public function EUserHasLicenseForAppResult(ISteamUser* this, CSteamID steamID, AppId_t appId) UserHasLicenseForApp;
            public function bool(ISteamUser* this) BIsBehindNAT;
            public function void(ISteamUser* this, CSteamID steamIDGameServer, u32 unIPServer, u16 usPortServer) AdvertiseGame;
            public function SteamAPICall_t(ISteamUser* this, void* pDataToInclude, i32 cbDataToInclude) RequestEncryptedAppTicket;
            public function bool(ISteamUser* this, void* pTicket, i32 cbMaxTicket, u32* pcbTicket) GetEncryptedAppTicket;
            public function int(ISteamUser* this, i32 nSeries, bool bFoil) GetGameBadgeLevel;
            public function int(ISteamUser* this) GetPlayerSteamLevel;
            public function SteamAPICall_t(ISteamUser* this, char8* pchRedirectURL) RequestStoreAuthURL;
            public function bool(ISteamUser* this) BIsPhoneVerified;
            public function bool(ISteamUser* this) BIsTwoFactorEnabled;
            public function bool(ISteamUser* this) BIsPhoneIdentifying;
            public function bool(ISteamUser* this) BIsPhoneRequiringVerification;
        }
    }

    [CRepr]
    public struct ISteamFriends
    {
        public ISteamFriends.VTable* Vtable;

        //Todo: Define remaining functions

        [CRepr]
        public struct VTable
        {
            //Todo: Define remaining vtable funcs
        }
    }

    [CRepr]
    public struct ISteamUtils
    {
        public ISteamUtils.VTable* Vtable;

        //Todo: Define remaining functions

        [CRepr]
        public struct VTable
        {
            //Todo: Define remaining vtable funcs
        }
    }

    [CRepr]
    public struct ISteamMatchmaking
    {
        public ISteamMatchmaking.VTable* Vtable;

        //Todo: Define remaining functions

        [CRepr]
        public struct VTable
        {
            //Todo: Define remaining vtable funcs
        }
    }

    [CRepr]
    public struct ISteamUserStats
    {
        public ISteamUserStats.VTable* Vtable;

        //Todo: Define remaining functions

        [CRepr]
        public struct VTable
        {
            //Todo: Define remaining vtable funcs
        }
    }

    [CRepr]
    public struct ISteamApps
    {
        public ISteamApps.VTable* Vtable;

        //Todo: Define remaining functions

        [CRepr]
        public struct VTable
        {
            //Todo: Define remaining vtable funcs
        }
    }

    [CRepr]
    public struct ISteamNetworking
    {
        public ISteamNetworking.VTable* Vtable;

        [CRepr]
        public struct VTable
        {
            //TODO: Fix return types, arg types + arg names. So far only defined func names
            public function bool(ISteamNetworking* self, CSteamID steamIDRemote, void* pubData, u32 cubData, EP2PSend eP2PSendType, i32 nChannel) SendP2PPacket;
            public function void(ISteamNetworking* self) IsP2PPacketAvailable;
            public function void(ISteamNetworking* self) ReadP2PPacket;
            public function void(ISteamNetworking* self) AcceptP2PSessionWithUser;
            public function void(ISteamNetworking* self) CloseP2PSessionWithUser;
            public function void(ISteamNetworking* self) CloseP2PChannelWithUser;
            public function void(ISteamNetworking* self) GetP2PSessionState;
            public function void(ISteamNetworking* self) AllowP2PPacketRelay;
            public function void(ISteamNetworking* self) CreateListenSocket;
            public function void(ISteamNetworking* self) CreateP2PConnectionSocket;
            public function void(ISteamNetworking* self) CreateConnectionSocket;
            public function void(ISteamNetworking* self) DestroySocket;
            public function void(ISteamNetworking* self) DestroyListenSocket;
            public function void(ISteamNetworking* self) SendDataOnSocket;
            public function void(ISteamNetworking* self) IsDataAvailableOnSocket;
            public function void(ISteamNetworking* self) RetrieveDataFromSocket;
            public function void(ISteamNetworking* self) IsDataAvailable;
            public function void(ISteamNetworking* self) RetrieveData;
            public function void(ISteamNetworking* self) GetSocketInfo;
            public function void(ISteamNetworking* self) GetListenSocketInfo;
            public function void(ISteamNetworking* self) GetSocketConnectionType;
            public function void(ISteamNetworking* self) GetMaxPacketSize;
        }
    }

    [CRepr]
    public struct ISteamRemoteStorage
    {
        public ISteamRemoteStorage.VTable* Vtable;

        //Todo: Define remaining functions

        [CRepr]
        public struct VTable
        {
            //Todo: Define remaining vtable funcs
        }
    }

    [CRepr]
    public struct ISteamController
    {
        public ISteamController.VTable* Vtable;

        //Todo: Define remaining functions

        [CRepr]
        public struct VTable
        {
            //Todo: Define remaining vtable funcs
        }
    }

    [CRepr]
    public struct ISteamMatchmakingServers
    {
        public void* Vtable; //Not implemented by the GOG version of sw_api.dll
    }

    [CRepr]
    public struct ISteamScreenshots
    {
        public void* Vtable; //Not implemented by the GOG version of sw_api.dll
    }

    [CRepr]
    public struct ISteamHTTP
    {
        public void* Vtable; //Not implemented by the GOG version of sw_api.dll
    }

    [CRepr]
    public struct ISteamUGC
    {
        public void* Vtable; //Not implemented by the GOG version of sw_api.dll
    }

    [CRepr]
    public struct ISteamAppList
    {
        public void* Vtable; //Not implemented by the GOG version of sw_api.dll
    }

    [CRepr]
    public struct ISteamMusic
    {
        public void* Vtable; //Not implemented by the GOG version of sw_api.dll
    }

    [CRepr]
    public struct ISteamMusicRemote
    {
        public void* Vtable; //Not implemented by the GOG version of sw_api.dll
    }

    [CRepr]
    public struct ISteamHTMLSurface
    {
        public void* Vtable; //Not implemented by the GOG version of sw_api.dll
    }

    [CRepr]
    public struct ISteamInventory
    {
        public void* Vtable; //Not implemented by the GOG version of sw_api.dll
    }

    [CRepr]
    public struct ISteamVideo
    {
        public void* Vtable; //Not implemented by the GOG version of sw_api.dll
    }

    [CRepr]
    public struct ISteamParentalSettings
    {
        public void* Vtable; //Not implemented by the GOG version of sw_api.dll
    }

    [CRepr]
    public struct ISteamGameServer
    {
        public void* Vtable; //Not implemented by the GOG version of sw_api.dll
    }

    [CRepr]
    public struct ISteamGameServerStats
    {
        public void* Vtable; //Not implemented by the GOG version of sw_api.dll
    }

    [CRepr]
    public struct ISteamUnifiedMessages
    {
        public void* Vtable; //Not implemented by the GOG version of sw_api.dll
    }

    [CRepr]
    public struct CCallbackBase
    {
    	CCallbackBase.VTable* vfptr;
    	u8 m_nCallbackFlags;
    	i32 m_iCallback;

        public static void Run(CCallbackBase* self, void* param0, bool param1, u64 param2)
        {

        }

        public static void Run2(CCallbackBase* self, void* param0)
        {

        }

        public static i32 GetCallbackSizeBytes(CCallbackBase* self)
        {
            return 0;
        }

        [CRepr]
        public struct VTable
        {
            public function void(CCallbackBase* self, void* param0, bool param1, u64 param2) Run = => CCallbackBase.Run;
            public function void(CCallbackBase* self, void* param0) Run2 = => CCallbackBase.Run2;
            public function i32(CCallbackBase* self) GetCallbackSizeBytes = => CCallbackBase.GetCallbackSizeBytes;
        }
    }

    [CRepr]
    public struct CCallResult<T, U> : CCallbackBase
    {

    }

    typealias CSteamID = u64;
    /*[CRepr]
    public struct CSteamID
    {

    }*/

    typealias CGameID = u64;
    /*[CRepr]
    public struct CGameID
    {

    }*/

    typealias HAuthTicket = u32;
    /*[CRepr]
    public struct HAuthTicket
    {

    }*/

    public enum EAccountType
    {
    	k_EAccountTypeInvalid = 0,
    	k_EAccountTypeIndividual = 1,
    	k_EAccountTypeMultiseat = 2,
    	k_EAccountTypeGameServer = 3,
    	k_EAccountTypeAnonGameServer = 4,
    	k_EAccountTypePending = 5,
    	k_EAccountTypeContentServer = 6,
    	k_EAccountTypeClan = 7,
    	k_EAccountTypeChat = 8,
    	k_EAccountTypeConsoleUser = 9,
    	k_EAccountTypeAnonUser = 10,
    	k_EAccountTypeMax = 11
    }

    public enum EVoiceResult
    {
        k_EVoiceResultOK = 0,
        k_EVoiceResultNotInitialized = 1,
        k_EVoiceResultNotRecording = 2,
        k_EVoiceResultNoData = 3,
        k_EVoiceResultBufferTooSmall = 4,
        k_EVoiceResultDataCorrupted = 5,
        k_EVoiceResultRestricted = 6,
        k_EVoiceResultUnsupportedCodec = 7,
        k_EVoiceResultReceiverOutOfDate = 8,
        k_EVoiceResultReceiverDidNotAnswer = 9
    }

    public enum EBeginAuthSessionResult
    {
        k_EBeginAuthSessionResultOK = 0,
        k_EBeginAuthSessionResultInvalidTicket = 1,
        k_EBeginAuthSessionResultDuplicateRequest = 2,
        k_EBeginAuthSessionResultInvalidVersion = 3,
        k_EBeginAuthSessionResultGameMismatch = 4,
        k_EBeginAuthSessionResultExpiredTicket = 5
    }

    public enum EUserHasLicenseForAppResult
    {
        k_EUserHasLicenseResultHasLicense = 0,
        k_EUserHasLicenseResultDoesNotHaveLicense = 1,
        k_EUserHasLicenseResultNoAuth = 2,
    }

    public enum EP2PSend
    {
        k_EP2PSendUnreliable = 0,
        k_EP2PSendUnreliableNoDelay = 1,
        k_EP2PSendReliable = 2,
        k_EP2PSendReliableWithBuffering = 3
    }
}