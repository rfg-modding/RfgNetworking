using System.Interop;
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

        [CRepr]
        public struct VTable
        {
            public function char8*(ISteamFriends* this) GetPersonaName;
            public function SteamAPICall_t(ISteamFriends* this, char8* pchPersonaName) SetPersonaName;
            public function EPersonaState(ISteamFriends* this) GetPersonaState;
            public function int(ISteamFriends* this, int iFriendFlags) GetFriendCount;
            public function CSteamID(ISteamFriends* this, int iFriend, int iFriendFlags) GetFriendByIndex;
            public function EFriendRelationship(ISteamFriends* this, CSteamID steamIDFriend) GetFriendRelationship;
            public function EPersonaState(ISteamFriends* this, CSteamID steamIDFriend) GetFriendPersonaState;
            public function char8*(ISteamFriends* this, CSteamID steamIDFriend) GetFriendPersonaName;
            public function bool(ISteamFriends* this, CSteamID steamIDFriend, FriendGameInfo_t *pFriendGameInfo) GetFriendGamePlayed;
            public function char8*(ISteamFriends* this, CSteamID steamIDFriend, int iPersonaName) GetFriendPersonaNameHistory;
            public function i32(ISteamFriends* this, CSteamID steamIDFriend) GetFriendSteamLevel;
            public function char8*(ISteamFriends* this, CSteamID steamIDPlayer) GetPlayerNickname;
            public function i32(ISteamFriends* this) GetFriendsGroupCount;
            public function FriendsGroupID_t(ISteamFriends* this, i32 iFG) GetFriendsGroupIDByIndex;
            public function char8*(ISteamFriends* this, FriendsGroupID_t friendsGroupID) GetFriendsGroupName;
            public function i32(ISteamFriends* this, FriendsGroupID_t friendsGroupID) GetFriendsGroupMembersCount;
            public function void(ISteamFriends* this, FriendsGroupID_t friendsGroupID, CSteamID* pOutSteamIDMembers, i32 nMembersCount) GetFriendsGroupMembersList;
            public function bool(ISteamFriends* this, CSteamID steamIDFriend, int iFriendFlags) HasFriend;
            public function i32(ISteamFriends* this) GetClanCount;
            public function CSteamID(ISteamFriends* this, CSteamID* __return, i32 iClan) GetClanByIndex;
            public function char8*(ISteamFriends* this, CSteamID steamIDClan) GetClanName;
            public function char8*(ISteamFriends* this, CSteamID steamIDClan) GetClanTag;
            public function bool(ISteamFriends* this, CSteamID steamIDClan, i32* pnOnline, i32* pnInGame, i32* pnChatting) GetClanActivityCounts;
            public function SteamAPICall_t(ISteamFriends* this, CSteamID *psteamIDClans, i32 cClansToRequest) DownloadClanActivityCounts;
            public function i32(ISteamFriends* this, CSteamID steamIDSource) GetFriendCountFromSource;
            public function CSteamID(ISteamFriends* this, CSteamID* __return, CSteamID steamIDSource, i32 iFriend) GetFriendFromSourceByIndex;
            public function bool(ISteamFriends* this, CSteamID steamIDUser, CSteamID steamIDSource) IsUserInSource;
            public function void(ISteamFriends* this, CSteamID steamIDUser, bool bSpeaking) SetInGameVoiceSpeaking;
            public function void(ISteamFriends* this, char8* pchDialog) ActivateGameOverlay;
            public function void(ISteamFriends* this, char8* pchDialog, CSteamID steamID) ActivateGameOverlayToUser;
            public function void(ISteamFriends* this, char8* pchURL) ActivateGameOverlayToWebPage;
            public function void(ISteamFriends* this, AppId_t nAppID, EOverlayToStoreFlag eFlag) ActivateGameOverlayToStore;
            public function void(ISteamFriends* this, CSteamID steamIDUserPlayedWith) SetPlayedWith;
            public function void(ISteamFriends* this, CSteamID steamIDLobby) ActivateGameOverlayInviteDialog;
            public function int(ISteamFriends* this, CSteamID steamIDFriend) GetSmallFriendAvatar;
            public function int(ISteamFriends* this, CSteamID steamIDFriend) GetMediumFriendAvatar;
            public function int(ISteamFriends* this, CSteamID steamIDFriend) GetLargeFriendAvatar;
            public function bool(ISteamFriends* this, CSteamID steamIDUser, bool bRequireNameOnly) RequestUserInformation;
            public function SteamAPICall_t(ISteamFriends* this, CSteamID steamIDClan) RequestClanOfficerList;
            public function CSteamID(ISteamFriends* this, CSteamID* __return, CSteamID steamIDClan) GetClanOwner;
            public function int(ISteamFriends* this, CSteamID steamIDClan) GetClanOfficerCount;
            public function CSteamID(ISteamFriends* this, CSteamID* __return, CSteamID steamIDClan, int iOfficer) GetClanOfficerByIndex;
            public function u32(ISteamFriends* this) GetUserRestrictions;
            public function bool(ISteamFriends* this, char8* pchKey, char8* pchValue) SetRichPresence;
            public function void(ISteamFriends* this) ClearRichPresence;
            public function char8*(ISteamFriends* this, CSteamID steamIDFriend, char8* pchKey) GetFriendRichPresence;
            public function int(ISteamFriends* this, CSteamID steamIDFriend) GetFriendRichPresenceKeyCount;
            public function char8*(ISteamFriends* this, CSteamID steamIDFriend, int iKey) GetFriendRichPresenceKeyByIndex;
            public function void(ISteamFriends* this, CSteamID steamIDFriend) RequestFriendRichPresence;
            public function bool(ISteamFriends* this, CSteamID steamIDFriend, char8* pchConnectString) InviteUserToGame;
            public function int(ISteamFriends* this) GetCoplayFriendCount;
            public function CSteamID(ISteamFriends* this, CSteamID* __return, int iCoplayFriend) GetCoplayFriend;
            public function int(ISteamFriends* this, CSteamID steamIDFriend) GetFriendCoplayTime;
            public function AppId_t(ISteamFriends* this, CSteamID steamIDFriend) GetFriendCoplayGame;
            public function SteamAPICall_t(ISteamFriends* this, CSteamID steamIDClan) JoinClanChatRoom;
            public function bool(ISteamFriends* this, CSteamID steamIDClan) LeaveClanChatRoom;
            public function int(ISteamFriends* this, CSteamID steamIDClan) GetClanChatMemberCount;
            public function CSteamID(ISteamFriends* this, CSteamID* __return, CSteamID steamIDClan, int iUser) GetChatMemberByIndex;
            public function bool(ISteamFriends* this, CSteamID steamIDClanChat, char8* pchText) SendClanChatMessage;
            public function int(ISteamFriends* this, CSteamID steamIDClanChat, int iMessage, void* prgchText, int cchTextMax, EChatEntryType* peChatEntryType, CSteamID* psteamidChatter) GetClanChatMessage;
            public function bool(ISteamFriends* this, CSteamID steamIDClanChat, CSteamID steamIDUser) IsClanChatAdmin;
            public function bool(ISteamFriends* this, CSteamID steamIDClanChat) IsClanChatWindowOpenInSteam;
            public function bool(ISteamFriends* this, CSteamID steamIDClanChat) OpenClanChatWindowInSteam;
            public function bool(ISteamFriends* this, CSteamID steamIDClanChat) CloseClanChatWindowInSteam;
            public function bool(ISteamFriends* this, bool bInterceptEnabled) SetListenForFriendsMessages;
            public function bool(ISteamFriends* this, CSteamID steamIDFriend, char8* pchMsgToSend) ReplyToFriendMessage;
            public function int(ISteamFriends* this, CSteamID steamIDFriend, int iMessageID, void *pvData, int cubData, EChatEntryType* peChatEntryType) GetFriendMessage;
            public function SteamAPICall_t(ISteamFriends* this, CSteamID steamID) GetFollowerCount;
            public function SteamAPICall_t(ISteamFriends* this, CSteamID steamID) IsFollowing;
            public function SteamAPICall_t(ISteamFriends* this, u32 unStartIndex) EnumerateFollowingList;
            public function bool(ISteamFriends* this, CSteamID steamIDClan) IsClanPublic;
            public function bool(ISteamFriends* this, CSteamID steamIDClan) IsClanOfficialGameGroup;
        }
    }

    [CRepr]
    public struct ISteamUtils
    {
        public ISteamUtils.VTable* Vtable;

        [CRepr]
        public struct VTable
        {
            public function u32(ISteamUtils* this) GetSecondsSinceAppActive;
            public function u32(ISteamUtils* this) GetSecondsSinceComputerActive;
            public function EUniverse(ISteamUtils* this) GetConnectedUniverse;
            public function u32(ISteamUtils* this) GetServerRealTime;
            public function char8*(ISteamUtils* this) GetIPCountry;
            public function u8(ISteamUtils* this, i32 iImage, u32* pnWidth, u32* pnHeight) GetImageSize;
            public function u8(ISteamUtils* this, i32 iImage, u8* pubDest, i32 nDestBufferSize) GetImageRGBA;
            public function u8(ISteamUtils* this, u32* unIP, u16* usPort) GetCSERIPPort;
            public function u8(ISteamUtils* this) GetCurrentBatteryPower;
            public function u32(ISteamUtils* this) GetAppID;
            public function void(ISteamUtils* this, ENotificationPosition eNotificationPosition) SetOverlayNotificationPosition;
            public function bool(ISteamUtils* this, SteamAPICall_t hSteamAPICall, bool* pbFailed) IsAPICallCompleted;
            public function ESteamAPICallFailure(ISteamUtils* this, SteamAPICall_t hSteamAPICall) GetAPICallFailureReason;
            public function bool(ISteamUtils* this, SteamAPICall_t hSteamAPICall, void* pCallback, int cubCallback, int iCallbackExpected, bool* pbFailed) GetAPICallResult;
            public function void(ISteamUtils* this) RunFrame;
            public function u32(ISteamUtils* this) GetIPCCallCount;
            public function void(ISteamUtils* this, function void(i32 nSeverity, char8* pchDebugText) pFunc) SetWarningMessageHook;
            public function bool(ISteamUtils* this) IsOverlayEnabled;
            public function bool(ISteamUtils* this) BOverlayNeedsPresent;
            public function SteamAPICall_t(ISteamUtils* this, char8* szFileName) CheckFileSignature;
            public function bool(ISteamUtils* this, EGamepadTextInputMode eInputMode, EGamepadTextInputLineMode eLineInputMode, char8* pchDescription, uint32 unCharMax, char8* pchExistingText) ShowGamepadTextInput;
            public function u32(ISteamUtils* this) GetEnteredGamepadTextLength;
            public function bool(ISteamUtils* this, char8* pchText, u32 cchText) GetEnteredGamepadTextInput;
            public function char8*(ISteamUtils* this) GetSteamUILanguage;
            public function bool(ISteamUtils* this) IsSteamRunningInVR;
            public function void(ISteamUtils* this, int nHorizontalInset, int nVerticalInset) SetOverlayNotificationInset;
            public function bool(ISteamUtils* this) IsSteamInBigPictureMode;
            public function void(ISteamUtils* this) StartVRDashboard;
            public function bool(ISteamUtils* this) IsVRHeadsetStreamingEnabled;
            public function void(ISteamUtils* this, bool bEnabled) SetVRHeadsetStreamingEnabled;
        }
    }

    [CRepr]
    public struct ISteamMatchmaking
    {
        public ISteamMatchmaking.VTable* Vtable;

        [CRepr]
        public struct VTable
        {
            public function int(ISteamMatchmaking* this) GetFavoriteGameCount;
            public function bool(ISteamMatchmaking* this, int iGame, AppId_t* pnAppID, uint32* pnIP, uint16* pnConnPort, uint16* pnQueryPort, uint32* punFlags, uint32* pRTime32LastPlayedOnServer) GetFavoriteGame;
            public function int(ISteamMatchmaking* this, AppId_t nAppID, uint32 nIP, uint16 nConnPort, uint16 nQueryPort, uint32 unFlags, uint32 rTime32LastPlayedOnServer) AddFavoriteGame;
            public function bool(ISteamMatchmaking* this, AppId_t nAppID, uint32 nIP, uint16 nConnPort, uint16 nQueryPort, uint32 unFlags) RemoveFavoriteGame;
            public function SteamAPICall_t(ISteamMatchmaking* this) RequestLobbyList;
            public function void(ISteamMatchmaking* this, char8* pchKeyToMatch, char8* pchValueToMatch, ELobbyComparison eComparisonType) AddRequestLobbyListStringFilter;
            public function void(ISteamMatchmaking* this, char8* pchKeyToMatch, int nValueToMatch, ELobbyComparison eComparisonType) AddRequestLobbyListNumericalFilter;
            public function void(ISteamMatchmaking* this, char8* pchKeyToMatch, int nValueToBeCloseTo) AddRequestLobbyListNearValueFilter;
            public function void(ISteamMatchmaking* this, int nSlotsAvailable) AddRequestLobbyListFilterSlotsAvailable;
            public function void(ISteamMatchmaking* this, ELobbyDistanceFilter eLobbyDistanceFilter) AddRequestLobbyListDistanceFilter;
            public function void(ISteamMatchmaking* this, int cMaxResults) AddRequestLobbyListResultCountFilter;
            public function void(ISteamMatchmaking* this, CSteamID steamIDLobby) AddRequestLobbyListCompatibleMembersFilter;
            public function CSteamID*(ISteamMatchmaking* this, CSteamID* __return, int nLobby) GetLobbyByIndex;
            public function SteamAPICall_t(ISteamMatchmaking* this, ELobbyType eLobbyType, int cMaxMembers) CreateLobby;
            public function SteamAPICall_t(ISteamMatchmaking* this, CSteamID steamIDLobby) JoinLobby;
            public function void(ISteamMatchmaking* this, CSteamID steamIDLobby) LeaveLobby;
            public function bool(ISteamMatchmaking* this, CSteamID steamIDLobby, CSteamID steamIDInvitee) InviteUserToLobby;
            public function int(ISteamMatchmaking* this, CSteamID steamIDLobby) GetNumLobbyMembers;
            public function CSteamID(ISteamMatchmaking* this, CSteamID* __return, CSteamID steamIDLobby, int iMember) GetLobbyMemberByIndex;
            public function char8*(ISteamMatchmaking* this, CSteamID steamIDLobby, char8* pchKey) GetLobbyData;
            public function bool(ISteamMatchmaking* this, CSteamID steamIDLobby, char8* pchKey, char8* pchValue) SetLobbyData;
            public function int(ISteamMatchmaking* this, CSteamID steamIDLobby) GetLobbyDataCount;
            public function bool(ISteamMatchmaking* this, CSteamID steamIDLobby, int iLobbyData, char8* pchKey, int cchKeyBufferSize, char8* pchValue, int cchValueBufferSize) GetLobbyDataByIndex;
            public function bool(ISteamMatchmaking* this, CSteamID steamIDLobby, char8* pchKey) DeleteLobbyData;
            public function char8*(ISteamMatchmaking* this, CSteamID steamIDLobby, CSteamID steamIDUser, char8* pchKey) GetLobbyMemberData;
            public function void(ISteamMatchmaking* this, CSteamID steamIDLobby, char8* pchKey, char8* pchValue) SetLobbyMemberData;
            public function bool(ISteamMatchmaking* this, CSteamID steamIDLobby, void* pvMsgBody, int cubMsgBody) SendLobbyChatMsg;
            public function int(ISteamMatchmaking* this, CSteamID steamIDLobby, int iChatID, CSteamID* pSteamIDUser, void* pvData, int cubData, EChatEntryType* peChatEntryType) GetLobbyChatEntry;
            public function bool(ISteamMatchmaking* this, CSteamID steamIDLobby) RequestLobbyData;
            public function void(ISteamMatchmaking* this, CSteamID steamIDLobby, uint32 unGameServerIP, uint16 unGameServerPort, CSteamID steamIDGameServer) SetLobbyGameServer;
            public function bool(ISteamMatchmaking* this, CSteamID steamIDLobby, uint32 *punGameServerIP, uint16 *punGameServerPort, CSteamID *psteamIDGameServer) GetLobbyGameServer;
            public function bool(ISteamMatchmaking* this, CSteamID steamIDLobby, int cMaxMembers) SetLobbyMemberLimit;
            public function int(ISteamMatchmaking* this, CSteamID steamIDLobby) GetLobbyMemberLimit;
            public function bool(ISteamMatchmaking* this, CSteamID steamIDLobby, ELobbyType eLobbyType) SetLobbyType;
            public function bool(ISteamMatchmaking* this, CSteamID steamIDLobby, bool bLobbyJoinable) SetLobbyJoinable;
            public function CSteamID(ISteamMatchmaking* this, CSteamID* __return, CSteamID steamIDLobby) GetLobbyOwner;
            public function bool(ISteamMatchmaking* this, CSteamID steamIDLobby, CSteamID steamIDNewOwner) SetLobbyOwner;
            public function bool(ISteamMatchmaking* this, CSteamID steamIDLobby, CSteamID steamIDLobbyDependent) SetLinkedLobby;
        }
    }

    [CRepr]
    public struct ISteamUserStats
    {
        public ISteamUserStats.VTable* Vtable;

        [CRepr]
        public struct VTable
        {
            public function bool(ISteamUserStats* this) RequestCurrentStats;
            public function bool(ISteamUserStats* this, char8* pchName, float* pData) GetStat_1;
            public function bool(ISteamUserStats* this, char8* pchName, i32* pData) GetStat_2;
            public function bool(ISteamUserStats* this, char8* pchName, float nData) SetStat_1;
            public function bool(ISteamUserStats* this, char8* pchName, i32 nData) SetStat_2;
            public function bool(ISteamUserStats* this, char8* pchName, float flCountThisSession, double dSessionLength) UpdateAvgRateStat;
            public function bool(ISteamUserStats* this, char8* pchName, bool* pbAchieved) GetAchievement;
            public function bool(ISteamUserStats* this, char8* pchName) SetAchievement;
            public function bool(ISteamUserStats* this, char8* pchName) ClearAchievement;
            public function bool(ISteamUserStats* this, char8* pchName, bool* pbAchieved, uint32* punUnlockTime) GetAchievementAndUnlockTime;
            public function bool(ISteamUserStats* this) StoreStats;
            public function int(ISteamUserStats* this, char8* pchName) GetAchievementIcon;
            public function char8*(ISteamUserStats* this, char8* pchName, char8* pchKey) GetAchievementDisplayAttribute;
            public function bool(ISteamUserStats* this, char8* pchName, u32 nCurProgress, u32 nMaxProgress) IndicateAchievementProgress;
            public function u32(ISteamUserStats* this) GetNumAchievements;
            public function char8*(ISteamUserStats* this, u32 iAchievement) GetAchievementName;
            public function SteamAPICall_t(ISteamUserStats* this, CSteamID steamIDUser) RequestUserStats;
            public function bool(ISteamUserStats* this, CSteamID steamIDUser, char8* pchName, float* pData) GetUserStat_1;
            public function bool(ISteamUserStats* this, CSteamID steamIDUser, char8* pchName, i32* pData) GetUserStat_2;
            public function bool(ISteamUserStats* this, CSteamID steamIDUser, char8* pchName, u8* pbAchieved) GetUserAchievement;
            public function bool(ISteamUserStats* this, CSteamID steamIDUser, char8* pchName, u8* pbAchieved, u32* punUnlockTime) GetUserAchievementAndUnlockTime;
            public function bool(ISteamUserStats* this, u8 bAchievementsToo) ResetAllStats;
            public function SteamAPICall_t(ISteamUserStats* this, char8* pchLeaderboardName, ELeaderboardSortMethod eLeaderboardSortMethod, ELeaderboardDisplayType eLeaderboardDisplayType) FindOrCreateLeaderboard;
            public function SteamAPICall_t(ISteamUserStats* this, char8* pchLeaderboardName) FindLeaderboard;
            public function char8*(ISteamUserStats* this, SteamLeaderboard_t hSteamLeaderboard) GetLeaderboardName;
            public function int(ISteamUserStats* this, SteamLeaderboard_t hSteamLeaderboard) GetLeaderboardEntryCount;
            public function ELeaderboardSortMethod(ISteamUserStats* this, SteamLeaderboard_t hSteamLeaderboard) GetLeaderboardSortMethod;
            public function ELeaderboardDisplayType(ISteamUserStats* this, SteamLeaderboard_t hSteamLeaderboard) GetLeaderboardDisplayType;
            public function SteamAPICall_t(ISteamUserStats* this, SteamLeaderboard_t hSteamLeaderboard, ELeaderboardDataRequest eLeaderboardDataRequest, int nRangeStart, int nRangeEnd) DownloadLeaderboardEntries;
            public function SteamAPICall_t(ISteamUserStats* this, SteamLeaderboard_t hSteamLeaderboard, CSteamID* prgUsers, int cUsers) DownloadLeaderboardEntriesForUsers;
            public function bool(ISteamUserStats* this, SteamLeaderboardEntries_t hSteamLeaderboardEntries, int index, LeaderboardEntry_t *pLeaderboardEntry, int32 *pDetails, int cDetailsMax) GetDownloadedLeaderboardEntry;
            public function SteamAPICall_t(ISteamUserStats* this, SteamLeaderboard_t hSteamLeaderboard, ELeaderboardUploadScoreMethod eLeaderboardUploadScoreMethod, int32 nScore, int32* pScoreDetails, int cScoreDetailsCount) UploadLeaderboardScore;
            public function SteamAPICall_t(ISteamUserStats* this, SteamLeaderboard_t hSteamLeaderboard, UGCHandle_t hUGC) AttachLeaderboardUGC;
            public function SteamAPICall_t(ISteamUserStats* this) GetNumberOfCurrentPlayers;
            public function SteamAPICall_t(ISteamUserStats* this) RequestGlobalAchievementPercentages;
            public function int(ISteamUserStats* this, char8* pchName, uint32 unNameBufLen, float* pflPercent, bool *pbAchieved) GetMostAchievedAchievementInfo;
            public function int(ISteamUserStats* this, int iIteratorPrevious, char8* pchName, uint32 unNameBufLen, float* pflPercent, bool* pbAchieved) GetNextMostAchievedAchievementInfo;
            public function bool(ISteamUserStats* this, char8* pchName, float* pflPercent) GetAchievementAchievedPercent;
            public function SteamAPICall_t(ISteamUserStats* this, int nHistoryDays) RequestGlobalStats;
            public function bool(ISteamUserStats* this, char8* pchStatName, double* pData) GetGlobalStat_1;
            public function bool(ISteamUserStats* this, char8* pchStatName, i64* pData) GetGlobalStat_2;
            public function i32(ISteamUserStats* this, char8* pchStateName, double* pData, u32 cubData) GetGlobalStatHistory_1;
            public function i32(ISteamUserStats* this, char8* pchStatName, i64* pData, u32 cubData) GetGlobalStatHistory_2;
        }
    }

    [CRepr]
    public struct ISteamApps
    {
        public ISteamApps.VTable* Vtable;

        [CRepr]
        public struct VTable
        {
            public function bool(ISteamApps* this) BIsSubscribed;
            public function bool(ISteamApps* this) BIsLowViolence;
            public function bool(ISteamApps* this) BIsCybercafe;
            public function bool(ISteamApps* this) BIsVACBanned;
            public function char8*(ISteamApps* this) GetCurrentGameLanguage;
            public function char8*(ISteamApps* this) GetAvailableGameLanguages;
            public function bool(ISteamApps* this, AppId_t appID) BIsSubscribedApp;
            public function bool(ISteamApps* this, AppId_t appID) BIsDlcInstalled;
            public function u32(ISteamApps* this, AppId_t appID) GetEarliestPurchaseUnixTime;
            public function bool(ISteamApps* this) BIsSubscribedFromFreeWeekend;
            public function int(ISteamApps* this) GetDLCCount;
            public function bool(ISteamApps* this, int iDLC, AppId_t* pAppID, bool* pbAvailable, char8* pchName, int cchNameBufferSize) BGetDLCDataByIndex;
            public function void(ISteamApps* this, AppId_t nAppID) InstallDLC;
            public function void(ISteamApps* this, AppId_t nAppID) UninstallDLC;
            public function void(ISteamApps* this, AppId_t nAppID) RequestAppProofOfPurchaseKey;
            public function bool(ISteamApps* this, char8* pchName, int cchNameBufferSize) GetCurrentBetaName;
            public function bool(ISteamApps* this, bool bMissingFilesOnly) MarkContentCorrupt;
            public function u32(ISteamApps* this, AppId_t appID, DepotId_t* pvecDepots, uint32 cMaxDepots) GetInstalledDepots;
            public function u32(ISteamApps* this, AppId_t appID, char8* pchFolder, uint32 cchFolderBufferSize) GetAppInstallDir;
            public function bool(ISteamApps* this, AppId_t appID) BIsAppInstalled;
            public function CSteamID(ISteamApps* this, CSteamID* __return) GetAppOwner;
            public function char8*(ISteamApps* this, char8* pchKey) GetLaunchQueryParam;
            public function bool(ISteamApps* this, AppId_t nAppID, uint64* punBytesDownloaded, uint64* punBytesTotal) GetDlcDownloadProgress;
            public function int(ISteamApps* this) GetAppBuildId;
            public function void(ISteamApps* this) RequestAllProofOfPurchaseKeys;
            public function SteamAPICall_t(ISteamApps* this, char8* pszFileName) GetFileDetails;
        }
    }

    [CRepr]
    public struct ISteamNetworking
    {
        public ISteamNetworking.VTable* Vtable;

        [CRepr]
        public struct VTable
        {
            public function bool(ISteamNetworking* this, CSteamID steamIDRemote, void* pubData, u32 cubData, EP2PSend eP2PSendType, i32 nChannel) SendP2PPacket;
            public function bool(ISteamNetworking* this, u32* pcubMsgSize, i32 nChannel) IsP2PPacketAvailable;;
            public function bool(ISteamNetworking* this, void* pubDest, u32 cubDest, u32* pcubMsgSize, CSteamID* psteamIDRemote, i32 nChannel) ReadP2PPacket;
            public function bool(ISteamNetworking* this, CSteamID steamIDRemote) AcceptP2PSessionWithUser;
            public function bool(ISteamNetworking* this, CSteamID steamIDRemote) CloseP2PSessionWithUser;
            public function bool(ISteamNetworking* this, CSteamID steamIDRemote, i32 nChannel) CloseP2PChannelWithUser;
            public function bool(ISteamNetworking* this, CSteamID steamIDRemote, P2PSessionState_t* pConnectionState) GetP2PSessionState;
            public function bool(ISteamNetworking* this, bool bAllow) AllowP2PPacketRelay;
            public function SNetListenSocket_t(ISteamNetworking* this, int nVirtualP2PPort, uint32 nIP, uint16 nPort, bool bAllowUseOfPacketRelay) CreateListenSocket;
            public function SNetSocket_t(ISteamNetworking* this, CSteamID steamIDTarget, int nVirtualPort, int nTimeoutSec, bool bAllowUseOfPacketRelay) CreateP2PConnectionSocket;
            public function SNetSocket_t(ISteamNetworking* this, uint32 nIP, uint16 nPort, int nTimeoutSec) CreateConnectionSocket;
            public function bool(ISteamNetworking* this, SNetSocket_t hSocket, bool bNotifyRemoteEnd) DestroySocket;
            public function bool(ISteamNetworking* this, SNetListenSocket_t hSocket, bool bNotifyRemoteEnd) DestroyListenSocket;
            public function bool(ISteamNetworking* this, SNetSocket_t hSocket, void* pubData, uint32 cubData, bool bReliable) SendDataOnSocket;
            public function bool(ISteamNetworking* this, SNetSocket_t hSocket, uint32* pcubMsgSize) IsDataAvailableOnSocket;
            public function bool(ISteamNetworking* this, SNetSocket_t hSocket, void* pubDest, uint32 cubDest, uint32* pcubMsgSize) RetrieveDataFromSocket;
            public function bool(ISteamNetworking* this, SNetListenSocket_t hListenSocket, uint32* pcubMsgSize, SNetSocket_t* phSocket) IsDataAvailable;
            public function bool(ISteamNetworking* this, SNetListenSocket_t hListenSocket, void* pubDest, uint32 cubDest, uint32* pcubMsgSize, SNetSocket_t* phSocket) RetrieveData;
            public function bool(ISteamNetworking* this, SNetSocket_t hSocket, CSteamID* pSteamIDRemote, int* peSocketStatus, uint32* punIPRemote, uint16* punPortRemote) GetSocketInfo;
            public function bool(ISteamNetworking* this, SNetListenSocket_t hListenSocket, uint32* pnIP, uint16* pnPort) GetListenSocketInfo;
            public function ESNetSocketConnectionType(ISteamNetworking* this, SNetSocket_t hSocket) GetSocketConnectionType;
            public function int(ISteamNetworking* this, SNetSocket_t hSocket) GetMaxPacketSize;
        }
    }

    [CRepr]
    public struct ISteamRemoteStorage
    {
        public ISteamRemoteStorage.VTable* Vtable;

        [CRepr]
        public struct VTable
        {
            public function bool(ISteamRemoteStorage* this, char8* pchFile, void* pvData, i32 cubData) FileWrite;
            public function i32(ISteamRemoteStorage* this, char8* pchFile, void* pvData, i32 cubDataToRead) FileRead;
            public function SteamAPICall_t(ISteamRemoteStorage* this, char8* pchFile, void* pvData, u32 cubData) FileWriteAsync;
            public function SteamAPICall_t(ISteamRemoteStorage* this, char8* pchFile, u32 nOffset, u32 cubToRead) FileReadAsync;
            public function bool(ISteamRemoteStorage* this, SteamAPICall_t hReadCall, void* pvBuffer, u32 cubToRead) FileReadAsyncComplete;
            public function bool(ISteamRemoteStorage* this, char8* pchFile) FileForget;
            public function bool(ISteamRemoteStorage* this, char8* pchFile) FileDelete;
            public function SteamAPICall_t(ISteamRemoteStorage* this, char8* pchFile) FileShare;
            public function bool(ISteamRemoteStorage* this, char8* pchFile, ERemoteStoragePlatform eRemoteStoragePlatform) SetSyncPlatforms;
            public function UGCFileWriteStreamHandle_t(ISteamRemoteStorage* this, char8* pchFile) FileWriteStreamOpen;
            public function bool(ISteamRemoteStorage* this, UGCFileWriteStreamHandle_t writeHandle, void* pvData, int32 cubData) FileWriteStreamWriteChunk;
            public function bool(ISteamRemoteStorage* this, UGCFileWriteStreamHandle_t writeHandle) FileWriteStreamClose;
            public function bool(ISteamRemoteStorage* this, UGCFileWriteStreamHandle_t writeHandle) FileWriteStreamCancel;
            public function bool(ISteamRemoteStorage* this, char8* pchFile) FileExists;
            public function bool(ISteamRemoteStorage* this, char8* pchFile) FilePersisted;
            public function i32(ISteamRemoteStorage* this, char8* pchFile) GetFileSize;
            public function i64(ISteamRemoteStorage* this, char8* pchFile) GetFileTimestamp;
            public function ERemoteStoragePlatform(ISteamRemoteStorage* this, char8* pchFile) GetSyncPlatforms;
            public function i32(ISteamRemoteStorage* this) GetFileCount;
            public function char8*(ISteamRemoteStorage* this, i32 iFile, i32* pnFileSizeInBytes) GetFileNameAndSize;
            public function bool(ISteamRemoteStorage* this, u64* pnTotalBytes, u64* puAvailableBytes) GetQuota;
            public function bool(ISteamRemoteStorage* this) IsCloudEnabledForAccount;
            public function bool(ISteamRemoteStorage* this) IsCloudEnabledForApp;
            public function void(ISteamRemoteStorage* this, bool bEnabled) SetCloudEnabledForApp;
            public function SteamAPICall_t(ISteamRemoteStorage* this, UGCHandle_t hContent, uint32 unPriority) UGCDownload;
            public function bool(ISteamRemoteStorage* this, UGCHandle_t hContent, int32* pnBytesDownloaded, int32* pnBytesExpected) GetUGCDownloadProgress;
            public function bool(ISteamRemoteStorage* this, UGCHandle_t hContent, AppId_t* pnAppID, char8** ppchName, int32* pnFileSizeInBytes, CSteamID* pSteamIDOwner) GetUGCDetails;
            public function i32(ISteamRemoteStorage* this, UGCHandle_t hContent, void *pvData, int32 cubDataToRead, uint32 cOffset, EUGCReadAction eAction) UGCRead;
            public function i32(ISteamRemoteStorage* this) GetCachedUGCCount;
            public function UGCHandle_t(ISteamRemoteStorage* this, i32 iCachedContent) GetCachedUGCHandle;
            public function SteamAPICall_t(ISteamRemoteStorage* this, char8* pchFile, char8* pchPreviewFile, AppId_t nConsumerAppId, char8* pchTitle, char8* pchDescription, ERemoteStoragePublishedFileVisibility eVisibility, SteamParamStringArray_t* pTags, EWorkshopFileType eWorkshopFileType) PublishWorkshopFile;
            public function PublishedFileUpdateHandle_t(ISteamRemoteStorage* this, PublishedFileId_t unPublishedFileId) CreatePublishedFileUpdateRequest;
            public function u8(ISteamRemoteStorage* this, PublishedFileUpdateHandle_t updateHandle, char8* pchFile) UpdatePublishedFileFile;
            public function u8(ISteamRemoteStorage* this, PublishedFileUpdateHandle_t updateHandle, char8* pchPreviewFile) UpdatePublishedFilePreviewFile;
            public function u8(ISteamRemoteStorage* this, PublishedFileUpdateHandle_t updateHandle, char8* pchTitle) UpdatePublishedFileTitle;
            public function u8(ISteamRemoteStorage* this, PublishedFileUpdateHandle_t updateHandle, char8* pchDescription) UpdatePublishedFileDescription;
            public function u8(ISteamRemoteStorage* this, PublishedFileUpdateHandle_t updateHandle, ERemoteStoragePublishedFileVisibility eVisibility) UpdatePublishedFileVisibility;
            public function u8(ISteamRemoteStorage* this, PublishedFileUpdateHandle_t updateHandle, SteamParamStringArray_t *pTags) UpdatePublishedFileTags;
            public function SteamAPICall_t(ISteamRemoteStorage* this, PublishedFileUpdateHandle_t updateHandle) CommitPublishedFileUpdate;
            public function SteamAPICall_t(ISteamRemoteStorage* this, PublishedFileId_t unPublishedFileId, uint32 unMaxSecondsOld) GetPublishedFileDetails;
            public function SteamAPICall_t(ISteamRemoteStorage* this, PublishedFileId_t unPublishedFileId) DeletePublishedFile;
            public function SteamAPICall_t(ISteamRemoteStorage* this, u32 unStartIndex) EnumerateUserPublishedFiles;
            public function SteamAPICall_t(ISteamRemoteStorage* this, PublishedFileId_t unPublishedFileId) SubscribePublishedFile;
            public function SteamAPICall_t(ISteamRemoteStorage* this, u32 unStartIndex) EnumerateUserSubscribedFiles;
            public function SteamAPICall_t(ISteamRemoteStorage* this, PublishedFileId_t unPublishedFileId) UnsubscribePublishedFile;
            public function bool(ISteamRemoteStorage* this, PublishedFileUpdateHandle_t updateHandle, char8* pchChangeDescription) UpdatePublishedFileSetChangeDescription;
            public function SteamAPICall_t(ISteamRemoteStorage* this, PublishedFileId_t unPublishedFileId) GetPublishedItemVoteDetails;
            public function SteamAPICall_t(ISteamRemoteStorage* this, PublishedFileId_t unPublishedFileId, bool bVoteUp) UpdateUserPublishedItemVote;
            public function SteamAPICall_t(ISteamRemoteStorage* this, PublishedFileId_t unPublishedFileId) GetUserPublishedItemVoteDetails;
            public function SteamAPICall_t(ISteamRemoteStorage* this, CSteamID steamId, uint32 unStartIndex, SteamParamStringArray_t* pRequiredTags, SteamParamStringArray_t* pExcludedTags) EnumerateUserSharedWorkshopFiles;
            public function SteamAPICall_t(ISteamRemoteStorage* this, EWorkshopVideoProvider eVideoProvider, char8* pchVideoAccount, char8* pchVideoIdentifier, char8* pchPreviewFile, AppId_t nConsumerAppId, char8* pchTitle, char8* pchDescription, ERemoteStoragePublishedFileVisibility eVisibility, SteamParamStringArray_t* pTags) PublishVideo;
            public function SteamAPICall_t(ISteamRemoteStorage* this, PublishedFileId_t unPublishedFileId, EWorkshopFileAction eAction) SetUserPublishedFileAction;
            public function SteamAPICall_t(ISteamRemoteStorage* this, EWorkshopFileAction eAction, uint32 unStartIndex) EnumeratePublishedFilesByUserAction;
            public function SteamAPICall_t(ISteamRemoteStorage* this, EWorkshopEnumerationType eEnumerationType, uint32 unStartIndex, uint32 unCount, uint32 unDays, SteamParamStringArray_t* pTags, SteamParamStringArray_t* pUserTags) EnumeratePublishedWorkshopFiles;
            public function SteamAPICall_t(ISteamRemoteStorage* this, UGCHandle_t hContent, char8* pchLocation, uint32 unPriority) UGCDownloadToLocation;
        }
    }

    [CRepr]
    public struct ISteamController
    {
        public ISteamController.VTable* Vtable;

        [CRepr]
        public struct VTable
        {
            public function bool(ISteamController* this) Init;
            public function bool(ISteamController* this) Shutdown;
            public function void(ISteamController* this) RunFrame;
            public function int(ISteamController* this, ControllerHandle_t* handlesOut) GetConnectedControllers;
            public function bool(ISteamController* this, ControllerHandle_t controllerHandle) ShowBindingPanel;
            public function ControllerActionSetHandle_t(ISteamController* this, char8* pszActionSetName) GetActionSetHandle;
            public function void(ISteamController* this, ControllerHandle_t controllerHandle, ControllerActionSetHandle_t actionSetHandle) ActivateActionSet;
            public function ControllerActionSetHandle_t(ISteamController* this, ControllerHandle_t controllerHandle) GetCurrentActionSet;
            public function void(ISteamController* this, ControllerHandle_t controllerHandle, ControllerActionSetHandle_t actionSetLayerHandle) ActivateActionSetLayer;
            public function void(ISteamController* this, ControllerHandle_t controllerHandle, ControllerActionSetHandle_t actionSetLayerHandle) DeactivateActionSetLayer;
            public function void(ISteamController* this, ControllerHandle_t controllerHandle) DeactivateAllActionSetLayers;
            public function int(ISteamController* this, ControllerHandle_t controllerHandle, ControllerActionSetHandle_t *handlesOut) GetActiveActionSetLayers;
            public function ControllerDigitalActionHandle_t(ISteamController* this, char8* pszActionName) GetDigitalActionHandle;
            public function ControllerDigitalActionData_t(ISteamController* this, ControllerDigitalActionData_t* __return, ControllerHandle_t controllerHandle, ControllerDigitalActionHandle_t digitalActionHandle) GetDigitalActionData;
            public function int(ISteamController* this, ControllerHandle_t controllerHandle, ControllerActionSetHandle_t actionSetHandle, ControllerDigitalActionHandle_t digitalActionHandle, EControllerActionOrigin* originsOut) GetDigitalActionOrigins;
            public function ControllerAnalogActionHandle_t(ISteamController* this, char8* pszActionName) GetAnalogActionHandle;
            public function ControllerAnalogActionData_t(ISteamController* this, ControllerAnalogActionData_t* __return, ControllerHandle_t controllerHandle, ControllerAnalogActionHandle_t analogActionHandle) GetAnalogActionData;
            public function int(ISteamController* this, ControllerHandle_t controllerHandle, ControllerActionSetHandle_t actionSetHandle, ControllerAnalogActionHandle_t analogActionHandle, EControllerActionOrigin* originsOut) GetAnalogActionOrigins;
            public function void(ISteamController* this, ControllerHandle_t controllerHandle, ControllerAnalogActionHandle_t eAction) StopAnalogActionMomentum;
            public function void(ISteamController* this, ControllerHandle_t controllerHandle, ESteamControllerPad eTargetPad, c_ushort usDurationMicroSec) TriggerHapticPulse;
            public function void(ISteamController* this, ControllerHandle_t controllerHandle, ESteamControllerPad eTargetPad, c_ushort usDurationMicroSec, c_ushort usOffMicroSec, c_ushort unRepeat, c_uint nFlags) TriggerRepeatedHapticPulse;
            public function void(ISteamController* this, ControllerHandle_t controllerHandle, c_ushort usLeftSpeed, c_ushort usRightSpeed) TriggerVibration;
            public function void(ISteamController* this, ControllerHandle_t controllerHandle, uint8 nColorR, uint8 nColorG, uint8 nColorB, c_uint nFlags) SetLEDColor;
            public function int(ISteamController* this, ControllerHandle_t ulControllerHandle) GetGamepadIndexForController;
            public function ControllerHandle_t(ISteamController* this, int nIndex) GetControllerForGamepadIndex;
            public function ControllerMotionData_t(ISteamController* this, ControllerMotionData_t* __return, ControllerHandle_t controllerHandle) GetMotionData;
            public function bool(ISteamController* this, ControllerHandle_t controllerHandle, ControllerDigitalActionHandle_t digitalActionHandle, float flScale, float flXPosition, float flYPosition) ShowDigitalActionOrigins;
            public function bool(ISteamController* this, ControllerHandle_t controllerHandle, ControllerAnalogActionHandle_t analogActionHandle, float flScale, float flXPosition, float flYPosition) ShowAnalogActionOrigins;
            public function char8*(ISteamController* this, EControllerActionOrigin eOrigin) GetStringForActionOrigin;
            public function char8*(ISteamController* this, EControllerActionOrigin eOrigin) GetGlyphForActionOrigin;
            public function ESteamInputType(ISteamController* this, ControllerHandle_t controllerHandle) GetInputTypeForHandle;
        }
    }

#region Not implemented by vanilla GOG sw_api.dll
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
#endregion

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

    typealias FriendsGroupID_t = i16;
    typealias UGCHandle_t = u64;
    typealias SteamLeaderboard_t = u64;
    typealias SteamLeaderboardEntries_t = u64;
    typealias DepotId_t = u32;
	typealias SNetListenSocket_t = u32;
	typealias SNetSocket_t = u32;
    typealias UGCFileWriteStreamHandle_t = u64;
    typealias PublishedFileUpdateHandle_t = u64;
    typealias PublishedFileId_t = u64;
    typealias ControllerActionSetHandle_t = u64;
    typealias ControllerAnalogActionHandle_t = u64;
    typealias ControllerDigitalActionHandle_t = u64;
    typealias ControllerHandle_t = u64;

    [CRepr]
    public struct FriendGameInfo_t
    {
        public CGameID m_gameID;
        public u32 m_unGameIP;
        public u16 m_usGamePort;
        public u16 m_usQueryPort;
        public CSteamID m_steamIDLobby;
    }

    [CRepr]
    public struct LeaderboardEntry_t
    {
        public CSteamID m_steamIDUser;
        public i32 m_nGlobalRank;
        public i32 m_nScore;
        public i32 m_cDetails;
        public UGCHandle_t m_hUGC;
    }

    [CRepr]
    public struct P2PSessionState_t
    {
        public u8 m_bConnectionActive;
        public u8 m_bConnecting;
        public u8 m_eP2PSessionError;
        public u8 m_bUsingRelay;
        public i32 m_nBytesQueuedForSend;
        public i32 m_nPacketsQueuedForSend;
        public u32 m_nRemoteIP;
        public u16 m_nRemotePort;
    }
	
	[CRepr]
	public struct SteamParamStringArray_t
	{
	    public char8** m_ppStrings;
        public i32 m_nNumStrings;
	}

	[CRepr]
	public struct ControllerDigitalActionData_t
	{
	
	}
	
	[CRepr]
	public struct ControllerAnalogActionData_t
	{
	
	}
	
	[CRepr]
	public struct ControllerMotionData_t
	{
	
	}

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

    public enum EOverlayToStoreFlag
    {
        k_EOverlayToStoreFlag_None = 0,
        k_EOverlayToStoreFlag_AddToCart = 1,
        k_EOverlayToStoreFlag_AddToCartAndShow = 2,
    }

    public enum EChatEntryType
    {
        k_EChatEntryTypeInvalid = 0,
	    k_EChatEntryTypeChatMsg = 1,
	    k_EChatEntryTypeTyping = 2,
	    k_EChatEntryTypeInviteGame = 3,
	    k_EChatEntryTypeEmote = 4,
	    k_EChatEntryTypeLeftConversation = 6,
	    k_EChatEntryTypeEntered = 7,
	    k_EChatEntryTypeWasKicked = 8,
	    k_EChatEntryTypeWasBanned = 9,
	    k_EChatEntryTypeDisconnected = 10,
	    k_EChatEntryTypeHistoricalChat = 11,
	    k_EChatEntryTypeLinkBlocked	= 14
    }

    public enum EPersonaState
    {
        k_EPersonaStateOffline = 0,
	    k_EPersonaStateOnline = 1,
	    k_EPersonaStateBusy = 2,
	    k_EPersonaStateAway = 3,
	    k_EPersonaStateSnooze = 4,
	    k_EPersonaStateLookingToTrade = 5,
	    k_EPersonaStateLookingToPlay = 6,
	    k_EPersonaStateMax = 7
    }

    public enum EFriendRelationship
    {
        k_EFriendRelationshipNone = 0,
	    k_EFriendRelationshipBlocked = 1,
	    k_EFriendRelationshipRequestRecipient = 2,
	    k_EFriendRelationshipFriend	= 3,
	    k_EFriendRelationshipRequestInitiator = 4,
	    k_EFriendRelationshipIgnored = 5,
	    k_EFriendRelationshipIgnoredFriend = 6,
	    k_EFriendRelationshipSuggested_DEPRECATED = 7,
	    k_EFriendRelationshipMax = 8,
    }

    public enum ESteamAPICallFailure
    {
		k_ESteamAPICallFailureNone = -1,
        k_ESteamAPICallFailureSteamGone = 0,
        k_ESteamAPICallFailureNetworkFailure = 1,
        k_ESteamAPICallFailureInvalidHandle = 2,
        k_ESteamAPICallFailureMismatchedCallback = 3
    }

    public enum EUniverse
    {
        k_EUniverseInvalid = 0,
	    k_EUniversePublic = 1,
	    k_EUniverseBeta = 2,
	    k_EUniverseInternal = 3,
	    k_EUniverseDev = 4,
	    k_EUniverseMax = 5
    }

    public enum ENotificationPosition
    {

    }
	
	public enum ELobbyComparison
	{
	
	}
	
	public enum ELobbyDistanceFilter
	{
	
	}
	
	public enum ELobbyType
	{
	
	}
	
	public enum ELeaderboardSortMethod
	{
	
	}
	
	public enum ELeaderboardDisplayType
	{
	
	}
	
	public enum ELeaderboardDataRequest
	{
	
	}
	
	public enum ELeaderboardUploadScoreMethod
	{
	
	}

    public enum EGamepadTextInputMode
	{

	}

	public enum EGamepadTextInputLineMode
    {

    }

    public enum ESNetSocketConnectionType
    {
        k_ESNetSocketConnectionTypeNotConnected = 0,
        k_ESNetSocketConnectionTypeUDP = 1,
        k_ESNetSocketConnectionTypeUDPRelay = 2
    }
	
	public enum ERemoteStoragePlatform
	{
	
	}
	
	public enum EUGCReadAction
	{
	
	}
	
	public enum ERemoteStoragePublishedFileVisibility
	{
	
	}
	
	public enum EWorkshopFileType
	{
	
	}
	
	public enum EWorkshopVideoProvider
	{
	
	}
	
	public enum EWorkshopFileAction
	{
	
	}
	
	public enum EWorkshopEnumerationType
	{
	
	}
	
	public enum EControllerActionOrigin
	{
	
	}
	
	public enum ESteamControllerPad
	{
	
	}
	
	public enum ESteamInputType
	{
	
	}
}