using System.Interop;
using System;
using RfgNetworking.Misc;

namespace RfgNetworking.API
{
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
        public function [CallingConvention(.Cdecl)] void(CSteamAPIContext* context) InitCallback;
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
            public function HSteamUser(ISteamClient* this, HSteamPipe hSteamPipe, AccountType eAccountType) CreateLocalUser;
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
            public function VoiceResult(ISteamUser* this, u32* pcbCompressed, u32* pcbUncompressed_Deprecated, u32 nUncompressedVoiceDesiredSampleRate_Deprecated) GetAvailableVoice;
            public function VoiceResult(ISteamUser* this, bool bWantCompressed, void* pDestBuffer, u32 cbDestBufferSize, uint32* nBytesWritten, bool bWantUncompressed_Deprecated, void* pUncompressedDestBuffer_Deprecated, u32 cbUncompressedDestBufferSize_Deprecated, u32* nUncompressBytesWritten_Deprecated, u32 nUncompressedVoiceDesiredSampleRate_Deprecated) GetVoice;
            public function VoiceResult(ISteamUser* this, void* pCompressed, u32 cbCompressed, void* pDestBuffer, u32 cbDestBufferSize, u32* nBytesWritten, u32 nDesiredSampleRate) DecompressVoice;
            public function u32(ISteamUser* this) GetVoiceOptimalSampleRate;
            public function HAuthTicket(ISteamUser* this, void* pTicket, i32 cbMaxTicket, u32* pcbTicket) GetAuthSessionTicket;
            public function BeginAuthSessionResult(ISteamUser* this, void* pAuthTicket, i32 cbAuthTicket, CSteamID steamID) BeginAuthSession;
            public function void(ISteamUser* this, CSteamID steamID) EndAuthSession;
            public function void(ISteamUser* this, HAuthTicket hAuthTicket) CancelAuthTicket;
            public function UserHasLicenseForAppResult(ISteamUser* this, CSteamID steamID, AppId appId) UserHasLicenseForApp;
            public function bool(ISteamUser* this) BIsBehindNAT;
            public function void(ISteamUser* this, CSteamID steamIDGameServer, u32 unIPServer, u16 usPortServer) AdvertiseGame;
            public function SteamAPICall(ISteamUser* this, void* pDataToInclude, i32 cbDataToInclude) RequestEncryptedAppTicket;
            public function bool(ISteamUser* this, void* pTicket, i32 cbMaxTicket, u32* pcbTicket) GetEncryptedAppTicket;
            public function int(ISteamUser* this, i32 nSeries, bool bFoil) GetGameBadgeLevel;
            public function int(ISteamUser* this) GetPlayerSteamLevel;
            public function SteamAPICall(ISteamUser* this, char8* pchRedirectURL) RequestStoreAuthURL;
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
            public function SteamAPICall(ISteamFriends* this, char8* pchPersonaName) SetPersonaName;
            public function PersonaState(ISteamFriends* this) GetPersonaState;
            public function int(ISteamFriends* this, int iFriendFlags) GetFriendCount;
            public function CSteamID(ISteamFriends* this, int iFriend, int iFriendFlags) GetFriendByIndex;
            public function FriendRelationship(ISteamFriends* this, CSteamID steamIDFriend) GetFriendRelationship;
            public function PersonaState(ISteamFriends* this, CSteamID steamIDFriend) GetFriendPersonaState;
            public function char8*(ISteamFriends* this, CSteamID steamIDFriend) GetFriendPersonaName;
            public function bool(ISteamFriends* this, CSteamID steamIDFriend, FriendGameInfo *pFriendGameInfo) GetFriendGamePlayed;
            public function char8*(ISteamFriends* this, CSteamID steamIDFriend, int iPersonaName) GetFriendPersonaNameHistory;
            public function i32(ISteamFriends* this, CSteamID steamIDFriend) GetFriendSteamLevel;
            public function char8*(ISteamFriends* this, CSteamID steamIDPlayer) GetPlayerNickname;
            public function i32(ISteamFriends* this) GetFriendsGroupCount;
            public function FriendsGroupID(ISteamFriends* this, i32 iFG) GetFriendsGroupIDByIndex;
            public function char8*(ISteamFriends* this, FriendsGroupID friendsGroupID) GetFriendsGroupName;
            public function i32(ISteamFriends* this, FriendsGroupID friendsGroupID) GetFriendsGroupMembersCount;
            public function void(ISteamFriends* this, FriendsGroupID friendsGroupID, CSteamID* pOutSteamIDMembers, i32 nMembersCount) GetFriendsGroupMembersList;
            public function bool(ISteamFriends* this, CSteamID steamIDFriend, int iFriendFlags) HasFriend;
            public function i32(ISteamFriends* this) GetClanCount;
            public function CSteamID(ISteamFriends* this, CSteamID* __return, i32 iClan) GetClanByIndex;
            public function char8*(ISteamFriends* this, CSteamID steamIDClan) GetClanName;
            public function char8*(ISteamFriends* this, CSteamID steamIDClan) GetClanTag;
            public function bool(ISteamFriends* this, CSteamID steamIDClan, i32* pnOnline, i32* pnInGame, i32* pnChatting) GetClanActivityCounts;
            public function SteamAPICall(ISteamFriends* this, CSteamID *psteamIDClans, i32 cClansToRequest) DownloadClanActivityCounts;
            public function i32(ISteamFriends* this, CSteamID steamIDSource) GetFriendCountFromSource;
            public function CSteamID(ISteamFriends* this, CSteamID* __return, CSteamID steamIDSource, i32 iFriend) GetFriendFromSourceByIndex;
            public function bool(ISteamFriends* this, CSteamID steamIDUser, CSteamID steamIDSource) IsUserInSource;
            public function void(ISteamFriends* this, CSteamID steamIDUser, bool bSpeaking) SetInGameVoiceSpeaking;
            public function void(ISteamFriends* this, char8* pchDialog) ActivateGameOverlay;
            public function void(ISteamFriends* this, char8* pchDialog, CSteamID steamID) ActivateGameOverlayToUser;
            public function void(ISteamFriends* this, char8* pchURL) ActivateGameOverlayToWebPage;
            public function void(ISteamFriends* this, AppId nAppID, OverlayToStoreFlag eFlag) ActivateGameOverlayToStore;
            public function void(ISteamFriends* this, CSteamID steamIDUserPlayedWith) SetPlayedWith;
            public function void(ISteamFriends* this, CSteamID steamIDLobby) ActivateGameOverlayInviteDialog;
            public function int(ISteamFriends* this, CSteamID steamIDFriend) GetSmallFriendAvatar;
            public function int(ISteamFriends* this, CSteamID steamIDFriend) GetMediumFriendAvatar;
            public function int(ISteamFriends* this, CSteamID steamIDFriend) GetLargeFriendAvatar;
            public function bool(ISteamFriends* this, CSteamID steamIDUser, bool bRequireNameOnly) RequestUserInformation;
            public function SteamAPICall(ISteamFriends* this, CSteamID steamIDClan) RequestClanOfficerList;
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
            public function AppId(ISteamFriends* this, CSteamID steamIDFriend) GetFriendCoplayGame;
            public function SteamAPICall(ISteamFriends* this, CSteamID steamIDClan) JoinClanChatRoom;
            public function bool(ISteamFriends* this, CSteamID steamIDClan) LeaveClanChatRoom;
            public function int(ISteamFriends* this, CSteamID steamIDClan) GetClanChatMemberCount;
            public function CSteamID(ISteamFriends* this, CSteamID* __return, CSteamID steamIDClan, int iUser) GetChatMemberByIndex;
            public function bool(ISteamFriends* this, CSteamID steamIDClanChat, char8* pchText) SendClanChatMessage;
            public function int(ISteamFriends* this, CSteamID steamIDClanChat, int iMessage, void* prgchText, int cchTextMax, ChatEntryType* peChatEntryType, CSteamID* psteamidChatter) GetClanChatMessage;
            public function bool(ISteamFriends* this, CSteamID steamIDClanChat, CSteamID steamIDUser) IsClanChatAdmin;
            public function bool(ISteamFriends* this, CSteamID steamIDClanChat) IsClanChatWindowOpenInSteam;
            public function bool(ISteamFriends* this, CSteamID steamIDClanChat) OpenClanChatWindowInSteam;
            public function bool(ISteamFriends* this, CSteamID steamIDClanChat) CloseClanChatWindowInSteam;
            public function bool(ISteamFriends* this, bool bInterceptEnabled) SetListenForFriendsMessages;
            public function bool(ISteamFriends* this, CSteamID steamIDFriend, char8* pchMsgToSend) ReplyToFriendMessage;
            public function int(ISteamFriends* this, CSteamID steamIDFriend, int iMessageID, void *pvData, int cubData, ChatEntryType* peChatEntryType) GetFriendMessage;
            public function SteamAPICall(ISteamFriends* this, CSteamID steamID) GetFollowerCount;
            public function SteamAPICall(ISteamFriends* this, CSteamID steamID) IsFollowing;
            public function SteamAPICall(ISteamFriends* this, u32 unStartIndex) EnumerateFollowingList;
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
            public function Universe(ISteamUtils* this) GetConnectedUniverse;
            public function u32(ISteamUtils* this) GetServerRealTime;
            public function char8*(ISteamUtils* this) GetIPCountry;
            public function u8(ISteamUtils* this, i32 iImage, u32* pnWidth, u32* pnHeight) GetImageSize;
            public function u8(ISteamUtils* this, i32 iImage, u8* pubDest, i32 nDestBufferSize) GetImageRGBA;
            public function u8(ISteamUtils* this, u32* unIP, u16* usPort) GetCSERIPPort;
            public function u8(ISteamUtils* this) GetCurrentBatteryPower;
            public function u32(ISteamUtils* this) GetAppID;
            public function void(ISteamUtils* this, NotificationPosition eNotificationPosition) SetOverlayNotificationPosition;
            public function bool(ISteamUtils* this, SteamAPICall hSteamAPICall, bool* pbFailed) IsAPICallCompleted;
            public function SteamAPICallFailure(ISteamUtils* this, SteamAPICall hSteamAPICall) GetAPICallFailureReason;
            public function bool(ISteamUtils* this, SteamAPICall hSteamAPICall, void* pCallback, int cubCallback, int iCallbackExpected, bool* pbFailed) GetAPICallResult;
            public function void(ISteamUtils* this) RunFrame;
            public function u32(ISteamUtils* this) GetIPCCallCount;
            public function void(ISteamUtils* this, function void(i32 nSeverity, char8* pchDebugText) pFunc) SetWarningMessageHook;
            public function bool(ISteamUtils* this) IsOverlayEnabled;
            public function bool(ISteamUtils* this) BOverlayNeedsPresent;
            public function SteamAPICall(ISteamUtils* this, char8* szFileName) CheckFileSignature;
            public function bool(ISteamUtils* this, GamepadTextInputMode eInputMode, GamepadTextInputLineMode eLineInputMode, char8* pchDescription, uint32 unCharMax, char8* pchExistingText) ShowGamepadTextInput;
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
            public function bool(ISteamMatchmaking* this, int iGame, AppId* pnAppID, uint32* pnIP, uint16* pnConnPort, uint16* pnQueryPort, uint32* punFlags, uint32* pRTime32LastPlayedOnServer) GetFavoriteGame;
            public function int(ISteamMatchmaking* this, AppId nAppID, uint32 nIP, uint16 nConnPort, uint16 nQueryPort, uint32 unFlags, uint32 rTime32LastPlayedOnServer) AddFavoriteGame;
            public function bool(ISteamMatchmaking* this, AppId nAppID, uint32 nIP, uint16 nConnPort, uint16 nQueryPort, uint32 unFlags) RemoveFavoriteGame;
            public function SteamAPICall(ISteamMatchmaking* this) RequestLobbyList;
            public function void(ISteamMatchmaking* this, char8* pchKeyToMatch, char8* pchValueToMatch, LobbyComparison eComparisonType) AddRequestLobbyListStringFilter;
            public function void(ISteamMatchmaking* this, char8* pchKeyToMatch, int nValueToMatch, LobbyComparison eComparisonType) AddRequestLobbyListNumericalFilter;
            public function void(ISteamMatchmaking* this, char8* pchKeyToMatch, int nValueToBeCloseTo) AddRequestLobbyListNearValueFilter;
            public function void(ISteamMatchmaking* this, int nSlotsAvailable) AddRequestLobbyListFilterSlotsAvailable;
            public function void(ISteamMatchmaking* this, LobbyDistanceFilter eLobbyDistanceFilter) AddRequestLobbyListDistanceFilter;
            public function void(ISteamMatchmaking* this, int cMaxResults) AddRequestLobbyListResultCountFilter;
            public function void(ISteamMatchmaking* this, CSteamID steamIDLobby) AddRequestLobbyListCompatibleMembersFilter;
            public function CSteamID*(ISteamMatchmaking* this, CSteamID* __return, int nLobby) GetLobbyByIndex;
            public function SteamAPICall(ISteamMatchmaking* this, LobbyType eLobbyType, int cMaxMembers) CreateLobby;
            public function SteamAPICall(ISteamMatchmaking* this, CSteamID steamIDLobby) JoinLobby;
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
            public function int(ISteamMatchmaking* this, CSteamID steamIDLobby, int iChatID, CSteamID* pSteamIDUser, void* pvData, int cubData, ChatEntryType* peChatEntryType) GetLobbyChatEntry;
            public function bool(ISteamMatchmaking* this, CSteamID steamIDLobby) RequestLobbyData;
            public function void(ISteamMatchmaking* this, CSteamID steamIDLobby, uint32 unGameServerIP, uint16 unGameServerPort, CSteamID steamIDGameServer) SetLobbyGameServer;
            public function bool(ISteamMatchmaking* this, CSteamID steamIDLobby, uint32 *punGameServerIP, uint16 *punGameServerPort, CSteamID *psteamIDGameServer) GetLobbyGameServer;
            public function bool(ISteamMatchmaking* this, CSteamID steamIDLobby, int cMaxMembers) SetLobbyMemberLimit;
            public function int(ISteamMatchmaking* this, CSteamID steamIDLobby) GetLobbyMemberLimit;
            public function bool(ISteamMatchmaking* this, CSteamID steamIDLobby, LobbyType eLobbyType) SetLobbyType;
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
            public function SteamAPICall(ISteamUserStats* this, CSteamID steamIDUser) RequestUserStats;
            public function bool(ISteamUserStats* this, CSteamID steamIDUser, char8* pchName, float* pData) GetUserStat_1;
            public function bool(ISteamUserStats* this, CSteamID steamIDUser, char8* pchName, i32* pData) GetUserStat_2;
            public function bool(ISteamUserStats* this, CSteamID steamIDUser, char8* pchName, u8* pbAchieved) GetUserAchievement;
            public function bool(ISteamUserStats* this, CSteamID steamIDUser, char8* pchName, u8* pbAchieved, u32* punUnlockTime) GetUserAchievementAndUnlockTime;
            public function bool(ISteamUserStats* this, u8 bAchievementsToo) ResetAllStats;
            public function SteamAPICall(ISteamUserStats* this, char8* pchLeaderboardName, LeaderboardSortMethod eLeaderboardSortMethod, LeaderboardDisplayType eLeaderboardDisplayType) FindOrCreateLeaderboard;
            public function SteamAPICall(ISteamUserStats* this, char8* pchLeaderboardName) FindLeaderboard;
            public function char8*(ISteamUserStats* this, SteamLeaderboard hSteamLeaderboard) GetLeaderboardName;
            public function int(ISteamUserStats* this, SteamLeaderboard hSteamLeaderboard) GetLeaderboardEntryCount;
            public function LeaderboardSortMethod(ISteamUserStats* this, SteamLeaderboard hSteamLeaderboard) GetLeaderboardSortMethod;
            public function LeaderboardDisplayType(ISteamUserStats* this, SteamLeaderboard hSteamLeaderboard) GetLeaderboardDisplayType;
            public function SteamAPICall(ISteamUserStats* this, SteamLeaderboard hSteamLeaderboard, LeaderboardDataRequest eLeaderboardDataRequest, int nRangeStart, int nRangeEnd) DownloadLeaderboardEntries;
            public function SteamAPICall(ISteamUserStats* this, SteamLeaderboard hSteamLeaderboard, CSteamID* prgUsers, int cUsers) DownloadLeaderboardEntriesForUsers;
            public function bool(ISteamUserStats* this, SteamLeaderboardEntries hSteamLeaderboardEntries, int index, LeaderboardEntry *pLeaderboardEntry, int32 *pDetails, int cDetailsMax) GetDownloadedLeaderboardEntry;
            public function SteamAPICall(ISteamUserStats* this, SteamLeaderboard hSteamLeaderboard, LeaderboardUploadScoreMethod eLeaderboardUploadScoreMethod, int32 nScore, int32* pScoreDetails, int cScoreDetailsCount) UploadLeaderboardScore;
            public function SteamAPICall(ISteamUserStats* this, SteamLeaderboard hSteamLeaderboard, UGCHandle hUGC) AttachLeaderboardUGC;
            public function SteamAPICall(ISteamUserStats* this) GetNumberOfCurrentPlayers;
            public function SteamAPICall(ISteamUserStats* this) RequestGlobalAchievementPercentages;
            public function int(ISteamUserStats* this, char8* pchName, uint32 unNameBufLen, float* pflPercent, bool *pbAchieved) GetMostAchievedAchievementInfo;
            public function int(ISteamUserStats* this, int iIteratorPrevious, char8* pchName, uint32 unNameBufLen, float* pflPercent, bool* pbAchieved) GetNextMostAchievedAchievementInfo;
            public function bool(ISteamUserStats* this, char8* pchName, float* pflPercent) GetAchievementAchievedPercent;
            public function SteamAPICall(ISteamUserStats* this, int nHistoryDays) RequestGlobalStats;
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
            public function bool(ISteamApps* this, AppId appID) BIsSubscribedApp;
            public function bool(ISteamApps* this, AppId appID) BIsDlcInstalled;
            public function u32(ISteamApps* this, AppId appID) GetEarliestPurchaseUnixTime;
            public function bool(ISteamApps* this) BIsSubscribedFromFreeWeekend;
            public function int(ISteamApps* this) GetDLCCount;
            public function bool(ISteamApps* this, int iDLC, AppId* pAppID, bool* pbAvailable, char8* pchName, int cchNameBufferSize) BGetDLCDataByIndex;
            public function void(ISteamApps* this, AppId nAppID) InstallDLC;
            public function void(ISteamApps* this, AppId nAppID) UninstallDLC;
            public function void(ISteamApps* this, AppId nAppID) RequestAppProofOfPurchaseKey;
            public function bool(ISteamApps* this, char8* pchName, int cchNameBufferSize) GetCurrentBetaName;
            public function bool(ISteamApps* this, bool bMissingFilesOnly) MarkContentCorrupt;
            public function u32(ISteamApps* this, AppId appID, DepotId* pvecDepots, uint32 cMaxDepots) GetInstalledDepots;
            public function u32(ISteamApps* this, AppId appID, char8* pchFolder, uint32 cchFolderBufferSize) GetAppInstallDir;
            public function bool(ISteamApps* this, AppId appID) BIsAppInstalled;
            public function CSteamID(ISteamApps* this, CSteamID* __return) GetAppOwner;
            public function char8*(ISteamApps* this, char8* pchKey) GetLaunchQueryParam;
            public function bool(ISteamApps* this, AppId nAppID, uint64* punBytesDownloaded, uint64* punBytesTotal) GetDlcDownloadProgress;
            public function int(ISteamApps* this) GetAppBuildId;
            public function void(ISteamApps* this) RequestAllProofOfPurchaseKeys;
            public function SteamAPICall(ISteamApps* this, char8* pszFileName) GetFileDetails;
        }
    }

    [CRepr]
    public struct ISteamNetworking
    {
        public ISteamNetworking.VTable* Vtable;

        [CRepr]
        public struct VTable
        {
            public function bool(ISteamNetworking* this, CSteamID steamIDRemote, void* pubData, u32 cubData, P2PSend eP2PSendType, i32 nChannel) SendP2PPacket;
            public function bool(ISteamNetworking* this, u32* pcubMsgSize, i32 nChannel) IsP2PPacketAvailable;;
            public function bool(ISteamNetworking* this, void* pubDest, u32 cubDest, u32* pcubMsgSize, CSteamID* psteamIDRemote, i32 nChannel) ReadP2PPacket;
            public function bool(ISteamNetworking* this, CSteamID steamIDRemote) AcceptP2PSessionWithUser;
            public function bool(ISteamNetworking* this, CSteamID steamIDRemote) CloseP2PSessionWithUser;
            public function bool(ISteamNetworking* this, CSteamID steamIDRemote, i32 nChannel) CloseP2PChannelWithUser;
            public function bool(ISteamNetworking* this, CSteamID steamIDRemote, P2PSessionState* pConnectionState) GetP2PSessionState;
            public function bool(ISteamNetworking* this, bool bAllow) AllowP2PPacketRelay;
            public function SNetListenSocket(ISteamNetworking* this, int nVirtualP2PPort, uint32 nIP, uint16 nPort, bool bAllowUseOfPacketRelay) CreateListenSocket;
            public function SNetSocket(ISteamNetworking* this, CSteamID steamIDTarget, int nVirtualPort, int nTimeoutSec, bool bAllowUseOfPacketRelay) CreateP2PConnectionSocket;
            public function SNetSocket(ISteamNetworking* this, uint32 nIP, uint16 nPort, int nTimeoutSec) CreateConnectionSocket;
            public function bool(ISteamNetworking* this, SNetSocket hSocket, bool bNotifyRemoteEnd) DestroySocket;
            public function bool(ISteamNetworking* this, SNetListenSocket hSocket, bool bNotifyRemoteEnd) DestroyListenSocket;
            public function bool(ISteamNetworking* this, SNetSocket hSocket, void* pubData, uint32 cubData, bool bReliable) SendDataOnSocket;
            public function bool(ISteamNetworking* this, SNetSocket hSocket, uint32* pcubMsgSize) IsDataAvailableOnSocket;
            public function bool(ISteamNetworking* this, SNetSocket hSocket, void* pubDest, uint32 cubDest, uint32* pcubMsgSize) RetrieveDataFromSocket;
            public function bool(ISteamNetworking* this, SNetListenSocket hListenSocket, uint32* pcubMsgSize, SNetSocket* phSocket) IsDataAvailable;
            public function bool(ISteamNetworking* this, SNetListenSocket hListenSocket, void* pubDest, uint32 cubDest, uint32* pcubMsgSize, SNetSocket* phSocket) RetrieveData;
            public function bool(ISteamNetworking* this, SNetSocket hSocket, CSteamID* pSteamIDRemote, int* peSocketStatus, uint32* punIPRemote, uint16* punPortRemote) GetSocketInfo;
            public function bool(ISteamNetworking* this, SNetListenSocket hListenSocket, uint32* pnIP, uint16* pnPort) GetListenSocketInfo;
            public function SNetSocketConnectionType(ISteamNetworking* this, SNetSocket hSocket) GetSocketConnectionType;
            public function int(ISteamNetworking* this, SNetSocket hSocket) GetMaxPacketSize;
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
            public function SteamAPICall(ISteamRemoteStorage* this, char8* pchFile, void* pvData, u32 cubData) FileWriteAsync;
            public function SteamAPICall(ISteamRemoteStorage* this, char8* pchFile, u32 nOffset, u32 cubToRead) FileReadAsync;
            public function bool(ISteamRemoteStorage* this, SteamAPICall hReadCall, void* pvBuffer, u32 cubToRead) FileReadAsyncComplete;
            public function bool(ISteamRemoteStorage* this, char8* pchFile) FileForget;
            public function bool(ISteamRemoteStorage* this, char8* pchFile) FileDelete;
            public function SteamAPICall(ISteamRemoteStorage* this, char8* pchFile) FileShare;
            public function bool(ISteamRemoteStorage* this, char8* pchFile, RemoteStoragePlatform eRemoteStoragePlatform) SetSyncPlatforms;
            public function UGCFileWriteStreamHandle(ISteamRemoteStorage* this, char8* pchFile) FileWriteStreamOpen;
            public function bool(ISteamRemoteStorage* this, UGCFileWriteStreamHandle writeHandle, void* pvData, int32 cubData) FileWriteStreamWriteChunk;
            public function bool(ISteamRemoteStorage* this, UGCFileWriteStreamHandle writeHandle) FileWriteStreamClose;
            public function bool(ISteamRemoteStorage* this, UGCFileWriteStreamHandle writeHandle) FileWriteStreamCancel;
            public function bool(ISteamRemoteStorage* this, char8* pchFile) FileExists;
            public function bool(ISteamRemoteStorage* this, char8* pchFile) FilePersisted;
            public function i32(ISteamRemoteStorage* this, char8* pchFile) GetFileSize;
            public function i64(ISteamRemoteStorage* this, char8* pchFile) GetFileTimestamp;
            public function RemoteStoragePlatform(ISteamRemoteStorage* this, char8* pchFile) GetSyncPlatforms;
            public function i32(ISteamRemoteStorage* this) GetFileCount;
            public function char8*(ISteamRemoteStorage* this, i32 iFile, i32* pnFileSizeInBytes) GetFileNameAndSize;
            public function bool(ISteamRemoteStorage* this, u64* pnTotalBytes, u64* puAvailableBytes) GetQuota;
            public function bool(ISteamRemoteStorage* this) IsCloudEnabledForAccount;
            public function bool(ISteamRemoteStorage* this) IsCloudEnabledForApp;
            public function void(ISteamRemoteStorage* this, bool bEnabled) SetCloudEnabledForApp;
            public function SteamAPICall(ISteamRemoteStorage* this, UGCHandle hContent, uint32 unPriority) UGCDownload;
            public function bool(ISteamRemoteStorage* this, UGCHandle hContent, int32* pnBytesDownloaded, int32* pnBytesExpected) GetUGCDownloadProgress;
            public function bool(ISteamRemoteStorage* this, UGCHandle hContent, AppId* pnAppID, char8** ppchName, int32* pnFileSizeInBytes, CSteamID* pSteamIDOwner) GetUGCDetails;
            public function i32(ISteamRemoteStorage* this, UGCHandle hContent, void *pvData, int32 cubDataToRead, uint32 cOffset, UGCReadAction eAction) UGCRead;
            public function i32(ISteamRemoteStorage* this) GetCachedUGCCount;
            public function UGCHandle(ISteamRemoteStorage* this, i32 iCachedContent) GetCachedUGCHandle;
            public function SteamAPICall(ISteamRemoteStorage* this, char8* pchFile, char8* pchPreviewFile, AppId nConsumerAppId, char8* pchTitle, char8* pchDescription, RemoteStoragePublishedFileVisibility eVisibility, SteamParamStringArray* pTags, WorkshopFileType eWorkshopFileType) PublishWorkshopFile;
            public function PublishedFileUpdateHandle(ISteamRemoteStorage* this, PublishedFileId unPublishedFileId) CreatePublishedFileUpdateRequest;
            public function bool(ISteamRemoteStorage* this, PublishedFileUpdateHandle updateHandle, char8* pchFile) UpdatePublishedFileFile;
            public function bool(ISteamRemoteStorage* this, PublishedFileUpdateHandle updateHandle, char8* pchPreviewFile) UpdatePublishedFilePreviewFile;
            public function bool(ISteamRemoteStorage* this, PublishedFileUpdateHandle updateHandle, char8* pchTitle) UpdatePublishedFileTitle;
            public function bool(ISteamRemoteStorage* this, PublishedFileUpdateHandle updateHandle, char8* pchDescription) UpdatePublishedFileDescription;
            public function bool(ISteamRemoteStorage* this, PublishedFileUpdateHandle updateHandle, RemoteStoragePublishedFileVisibility eVisibility) UpdatePublishedFileVisibility;
            public function bool(ISteamRemoteStorage* this, PublishedFileUpdateHandle updateHandle, SteamParamStringArray *pTags) UpdatePublishedFileTags;
            public function SteamAPICall(ISteamRemoteStorage* this, PublishedFileUpdateHandle updateHandle) CommitPublishedFileUpdate;
            public function SteamAPICall(ISteamRemoteStorage* this, PublishedFileId unPublishedFileId, uint32 unMaxSecondsOld) GetPublishedFileDetails;
            public function SteamAPICall(ISteamRemoteStorage* this, PublishedFileId unPublishedFileId) DeletePublishedFile;
            public function SteamAPICall(ISteamRemoteStorage* this, u32 unStartIndex) EnumerateUserPublishedFiles;
            public function SteamAPICall(ISteamRemoteStorage* this, PublishedFileId unPublishedFileId) SubscribePublishedFile;
            public function SteamAPICall(ISteamRemoteStorage* this, u32 unStartIndex) EnumerateUserSubscribedFiles;
            public function SteamAPICall(ISteamRemoteStorage* this, PublishedFileId unPublishedFileId) UnsubscribePublishedFile;
            public function bool(ISteamRemoteStorage* this, PublishedFileUpdateHandle updateHandle, char8* pchChangeDescription) UpdatePublishedFileSetChangeDescription;
            public function SteamAPICall(ISteamRemoteStorage* this, PublishedFileId unPublishedFileId) GetPublishedItemVoteDetails;
            public function SteamAPICall(ISteamRemoteStorage* this, PublishedFileId unPublishedFileId, bool bVoteUp) UpdateUserPublishedItemVote;
            public function SteamAPICall(ISteamRemoteStorage* this, PublishedFileId unPublishedFileId) GetUserPublishedItemVoteDetails;
            public function SteamAPICall(ISteamRemoteStorage* this, CSteamID steamId, uint32 unStartIndex, SteamParamStringArray* pRequiredTags, SteamParamStringArray* pExcludedTags) EnumerateUserSharedWorkshopFiles;
            public function SteamAPICall(ISteamRemoteStorage* this, WorkshopVideoProvider eVideoProvider, char8* pchVideoAccount, char8* pchVideoIdentifier, char8* pchPreviewFile, AppId nConsumerAppId, char8* pchTitle, char8* pchDescription, RemoteStoragePublishedFileVisibility eVisibility, SteamParamStringArray* pTags) PublishVideo;
            public function SteamAPICall(ISteamRemoteStorage* this, PublishedFileId unPublishedFileId, WorkshopFileAction eAction) SetUserPublishedFileAction;
            public function SteamAPICall(ISteamRemoteStorage* this, WorkshopFileAction eAction, uint32 unStartIndex) EnumeratePublishedFilesByUserAction;
            public function SteamAPICall(ISteamRemoteStorage* this, WorkshopEnumerationType eEnumerationType, uint32 unStartIndex, uint32 unCount, uint32 unDays, SteamParamStringArray* pTags, SteamParamStringArray* pUserTags) EnumeratePublishedWorkshopFiles;
            public function SteamAPICall(ISteamRemoteStorage* this, UGCHandle hContent, char8* pchLocation, uint32 unPriority) UGCDownloadToLocation;
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
            public function int(ISteamController* this, ControllerHandle* handlesOut) GetConnectedControllers;
            public function bool(ISteamController* this, ControllerHandle controllerHandle) ShowBindingPanel;
            public function ControllerActionSetHandle(ISteamController* this, char8* pszActionSetName) GetActionSetHandle;
            public function void(ISteamController* this, ControllerHandle controllerHandle, ControllerActionSetHandle actionSetHandle) ActivateActionSet;
            public function ControllerActionSetHandle(ISteamController* this, ControllerHandle controllerHandle) GetCurrentActionSet;
            public function void(ISteamController* this, ControllerHandle controllerHandle, ControllerActionSetHandle actionSetLayerHandle) ActivateActionSetLayer;
            public function void(ISteamController* this, ControllerHandle controllerHandle, ControllerActionSetHandle actionSetLayerHandle) DeactivateActionSetLayer;
            public function void(ISteamController* this, ControllerHandle controllerHandle) DeactivateAllActionSetLayers;
            public function int(ISteamController* this, ControllerHandle controllerHandle, ControllerActionSetHandle *handlesOut) GetActiveActionSetLayers;
            public function ControllerDigitalActionHandle(ISteamController* this, char8* pszActionName) GetDigitalActionHandle;
            public function ControllerDigitalActionData(ISteamController* this, ControllerDigitalActionData* __return, ControllerHandle controllerHandle, ControllerDigitalActionHandle digitalActionHandle) GetDigitalActionData;
            public function int(ISteamController* this, ControllerHandle controllerHandle, ControllerActionSetHandle actionSetHandle, ControllerDigitalActionHandle digitalActionHandle, ControllerActionOrigin* originsOut) GetDigitalActionOrigins;
            public function ControllerAnalogActionHandle(ISteamController* this, char8* pszActionName) GetAnalogActionHandle;
            public function ControllerAnalogActionData(ISteamController* this, ControllerAnalogActionData* __return, ControllerHandle controllerHandle, ControllerAnalogActionHandle analogActionHandle) GetAnalogActionData;
            public function int(ISteamController* this, ControllerHandle controllerHandle, ControllerActionSetHandle actionSetHandle, ControllerAnalogActionHandle analogActionHandle, ControllerActionOrigin* originsOut) GetAnalogActionOrigins;
            public function void(ISteamController* this, ControllerHandle controllerHandle, ControllerAnalogActionHandle eAction) StopAnalogActionMomentum;
            public function void(ISteamController* this, ControllerHandle controllerHandle, SteamControllerPad eTargetPad, c_ushort usDurationMicroSec) TriggerHapticPulse;
            public function void(ISteamController* this, ControllerHandle controllerHandle, SteamControllerPad eTargetPad, c_ushort usDurationMicroSec, c_ushort usOffMicroSec, c_ushort unRepeat, c_uint nFlags) TriggerRepeatedHapticPulse;
            public function void(ISteamController* this, ControllerHandle controllerHandle, c_ushort usLeftSpeed, c_ushort usRightSpeed) TriggerVibration;
            public function void(ISteamController* this, ControllerHandle controllerHandle, uint8 nColorR, uint8 nColorG, uint8 nColorB, c_uint nFlags) SetLEDColor;
            public function int(ISteamController* this, ControllerHandle ulControllerHandle) GetGamepadIndexForController;
            public function ControllerHandle(ISteamController* this, int nIndex) GetControllerForGamepadIndex;
            public function ControllerMotionData(ISteamController* this, ControllerMotionData* __return, ControllerHandle controllerHandle) GetMotionData;
            public function bool(ISteamController* this, ControllerHandle controllerHandle, ControllerDigitalActionHandle digitalActionHandle, float flScale, float flXPosition, float flYPosition) ShowDigitalActionOrigins;
            public function bool(ISteamController* this, ControllerHandle controllerHandle, ControllerAnalogActionHandle analogActionHandle, float flScale, float flXPosition, float flYPosition) ShowAnalogActionOrigins;
            public function char8*(ISteamController* this, ControllerActionOrigin eOrigin) GetStringForActionOrigin;
            public function char8*(ISteamController* this, ControllerActionOrigin eOrigin) GetGlyphForActionOrigin;
            public function SteamInputType(ISteamController* this, ControllerHandle controllerHandle) GetInputTypeForHandle;
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

    //Note: Some of these types aren't really structs. Structs are used so we can easy add helper functions and so the log functions show the correct type name. With typealias it shows the base type instead of the alias.
    [CRepr]
    public struct HSteamPipe : i32, IFormattable
    {
        [Comptime]
        private static void ComptimeSizeCheck()
        {
            Runtime.Assert(sizeof(HSteamPipe) == sizeof(i32));
        }

        public void ToString(String outString, String format, IFormatProvider formatProvider)
        {
            outString.Set(scope $"{(i32)this}");
        }
    }

    [CRepr]
    public struct HSteamUser : i32, IFormattable
    {
        public void ToString(String outString, String format, IFormatProvider formatProvider)
        {
            outString.Set(scope $"{(i32)this}");
        }
    }

    [CRepr]
    public struct AppId : u32, IFormattable
    {
        public void ToString(String outString, String format, IFormatProvider formatProvider)
        {
            outString.Set(scope $"{(u32)this}");
        }
    }

    [CRepr]
    public struct SteamAPICall : u64, IFormattable
    {
        public void ToString(String outString, String format, IFormatProvider formatProvider)
        {
            outString.Set(scope $"{(u64)this}");
        }
    }

    [CRepr, ReflectAll]
    public struct CSteamID : u64, IFormattable
    {
        public void ToString(String outString, String format, IFormatProvider formatProvider)
        {
            outString.Set(scope $"{(u64)this}");
        }
    }

    [CRepr]
    public struct CGameID : u64, IFormattable
    {
        public void ToString(String outString, String format, IFormatProvider formatProvider)
        {
            outString.Set(scope $"{(u64)this}");
        }
    }

    [CRepr]
    public struct HAuthTicket : u32, IFormattable
    {
        public void ToString(String outString, String format, IFormatProvider formatProvider)
        {
            outString.Set(scope $"{(u32)this}");
        }
    }

    [CRepr]
    public struct FriendsGroupID : i16, IFormattable
    {
        public void ToString(String outString, String format, IFormatProvider formatProvider)
        {
            outString.Set(scope $"{(i16)this}");
        }
    }

    [CRepr]
    public struct UGCHandle : u64, IFormattable
    {
        public void ToString(String outString, String format, IFormatProvider formatProvider)
        {
            outString.Set(scope $"{(u64)this}");
        }
    }

    [CRepr]
    public struct SteamLeaderboard : u64, IFormattable
    {
        public void ToString(String outString, String format, IFormatProvider formatProvider)
        {
            outString.Set(scope $"{(u64)this}");
        }
    }

    [CRepr]
    public struct SteamLeaderboardEntries : u64, IFormattable
    {
        public void ToString(String outString, String format, IFormatProvider formatProvider)
        {
            outString.Set(scope $"{(u64)this}");
        }
    }

    [CRepr]
    public struct DepotId : u32, IFormattable
    {
        public void ToString(String outString, String format, IFormatProvider formatProvider)
        {
            outString.Set(scope $"{(u32)this}");
        }
    }

    [CRepr]
    public struct SNetListenSocket : u32, IFormattable
    {
        public void ToString(String outString, String format, IFormatProvider formatProvider)
        {
            outString.Set(scope $"{(u32)this}");
        }
    }

    [CRepr]
    public struct SNetSocket : u32, IFormattable
    {
        public void ToString(String outString, String format, IFormatProvider formatProvider)
        {
            outString.Set(scope $"{(u32)this}");
        }
    }

    [CRepr]
    public struct UGCFileWriteStreamHandle : u64, IFormattable
    {
        public void ToString(String outString, String format, IFormatProvider formatProvider)
        {
            outString.Set(scope $"{(u64)this}");
        }
    }

    [CRepr]
    public struct PublishedFileUpdateHandle : u64, IFormattable
    {
        public void ToString(String outString, String format, IFormatProvider formatProvider)
        {
            outString.Set(scope $"{(u64)this}");
        }
    }

    [CRepr]
    public struct PublishedFileId : u64, IFormattable
    {
        public void ToString(String outString, String format, IFormatProvider formatProvider)
        {
            outString.Set(scope $"{(u64)this}");
        }
    }

    [CRepr]
    public struct ControllerActionSetHandle : u64, IFormattable
    {
        public void ToString(String outString, String format, IFormatProvider formatProvider)
        {
            outString.Set(scope $"{(u64)this}");
        }
    }

    [CRepr]
    public struct ControllerAnalogActionHandle : u64, IFormattable
    {
        public void ToString(String outString, String format, IFormatProvider formatProvider)
        {
            outString.Set(scope $"{(u64)this}");
        }
    }

    [CRepr]
    public struct ControllerDigitalActionHandle : u64, IFormattable
    {
        public void ToString(String outString, String format, IFormatProvider formatProvider)
        {
            outString.Set(scope $"{(u64)this}");
        }
    }

    [CRepr]
    public struct ControllerHandle : u64, IFormattable
    {
        public void ToString(String outString, String format, IFormatProvider formatProvider)
        {
            outString.Set(scope $"{(u64)this}");
        }
    }

    [CRepr]
    public struct FriendGameInfo
    {
        public CGameID m_gameID;
        public u32 m_unGameIP;
        public u16 m_usGamePort;
        public u16 m_usQueryPort;
        public CSteamID m_steamIDLobby;
    }

    [CRepr]
    public struct LeaderboardEntry
    {
        public CSteamID m_steamIDUser;
        public i32 m_nGlobalRank;
        public i32 m_nScore;
        public i32 m_cDetails;
        public UGCHandle m_hUGC;
    }

    [CRepr]
    public struct P2PSessionState
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
	public struct SteamParamStringArray
	{
	    public char8** m_ppStrings;
        public i32 m_nNumStrings;
	}

	[CRepr]
	public struct ControllerDigitalActionData
	{
	    public bool bState;
        public bool bActive;
	}
	
	[CRepr]
	public struct ControllerAnalogActionData
	{
	    public ControllerSourceMode eMode;
        public f32 x;
        public f32 y;
        public bool bActive;
	}
	
	[CRepr]
	public struct ControllerMotionData
	{
	    public f32 rotQuatX;
        public f32 rotQuatY;
        public f32 rotQuatZ;
        public f32 rotQuatW;
        public f32 postAccelX;
        public f32 postAccelY;
        public f32 postAccelZ;
        public f32 rotVelX;
        public f32 rotVelY;
        public f32 rotVelZ;
	}

    public enum AccountType
    {
    	Invalid = 0,
    	Individual = 1,
    	Multiseat = 2,
    	GameServer = 3,
    	AnonGameServer = 4,
    	Pending = 5,
    	ContentServer = 6,
    	Clan = 7,
    	Chat = 8,
    	ConsoleUser = 9,
    	AnonUser = 10,
    	Max = 11
    }

    public enum VoiceResult
    {
        OK = 0,
        NotInitialized = 1,
        NotRecording = 2,
        NoData = 3,
        BufferTooSmall = 4,
        DataCorrupted = 5,
        Restricted = 6,
        UnsupportedCodec = 7,
        ReceiverOutOfDate = 8,
        ReceiverDidNotAnswer = 9
    }

    public enum BeginAuthSessionResult
    {
        OK = 0,
        InvalidTicket = 1,
        DuplicateRequest = 2,
        InvalidVersion = 3,
        GameMismatch = 4,
        ExpiredTicket = 5
    }

    public enum UserHasLicenseForAppResult
    {
        HasLicense = 0,
        DoesNotHaveLicense = 1,
        NoAuth = 2,
    }

    public enum P2PSend
    {
        Unreliable = 0,
        UnreliableNoDelay = 1,
        Reliable = 2,
        ReliableWithBuffering = 3
    }

    public enum OverlayToStoreFlag
    {
        None = 0,
        AddToCart = 1,
        AddToCartAndShow = 2,
    }

    public enum ChatEntryType
    {
        Invalid = 0,
	    ChatMsg = 1,
	    Typing = 2,
	    InviteGame = 3,
	    Emote = 4,
	    LeftConversation = 6,
	    Entered = 7,
	    WasKicked = 8,
	    WasBanned = 9,
	    Disconnected = 10,
	    HistoricalChat = 11,
	    LinkBlocked	= 14
    }

    public enum PersonaState
    {
        Offline = 0,
	    Online = 1,
	    Busy = 2,
	    Away = 3,
	    Snooze = 4,
	    LookingToTrade = 5,
	    LookingToPlay = 6,
	    Max = 7
    }

    public enum FriendRelationship
    {
        None = 0,
	    Blocked = 1,
	    RequestRecipient = 2,
	    Friend	= 3,
	    RequestInitiator = 4,
	    Ignored = 5,
	    IgnoredFriend = 6,
	    Suggested_DEPRECATED = 7,
	    Max = 8,
    }

    public enum SteamAPICallFailure
    {
		None = -1,
        SteamGone = 0,
        NetworkFailure = 1,
        InvalidHandle = 2,
        MismatchedCallback = 3
    }

    [CRepr]
    public enum Universe : u32
    {
        Invalid = 0,
	    Public = 1,
	    Beta = 2,
	    Internal = 3,
	    Dev = 4,
	    Max = 5
    }

    public enum NotificationPosition
    {
        TopLeft = 0,
        TopRight = 1,
        BottomLeft = 2,
        BottomRight = 3
    }
	
	public enum LobbyComparison
	{
	    EqualToOrLessThan = -2,
        LessThan = -1,
        Equal = 0,
        GreaterThan = 1,
        EqualToOrGreaterThan = 2,
        NotEqual = 3
	}
	
	public enum LobbyDistanceFilter
	{
	    Close = 0,
        Default = 1,
        Far = 2,
        Worldwide = 3
	}
	
	public enum LobbyType
	{
	    Private = 0,
        FriendsOnly = 1,
        Public = 2,
        Invisible = 3
	}
	
	public enum LeaderboardSortMethod
	{
	    None = 0,
        Ascending = 1,
        Descending = 2
	}
	
	public enum LeaderboardDisplayType
	{
	    None = 0,
        Numeric = 1,
        TimeSeconds = 2,
        TimeMilliSeconds = 3
	}
	
	public enum LeaderboardDataRequest
	{
	    Global = 0,
        GlobalAroundUser = 1,
        Friends = 2,
        Users = 3
	}
	
	public enum LeaderboardUploadScoreMethod
	{
	    None = 0,
        KeepBest = 1,
        ForceUpdate = 2
	}

    public enum GamepadTextInputMode
	{
        Normal = 0,
        Password = 1
	}

	public enum GamepadTextInputLineMode
    {
        SingleLine = 0,
        MultipleLines = 1
    }

    public enum SNetSocketConnectionType
    {
        NotConnected = 0,
        UDP = 1,
        UDPRelay = 2
    }
	
	public enum RemoteStoragePlatform
	{
	    None = 0,
        Windows = 1 << 0,
        OSX = 1 << 1,
        PS3 = 1 << 2,
        Linux = 1 << 3,
        Reserved2 = 1 << 4,
        All = 0xFFFFFFFF
	}
	
	public enum UGCReadAction
	{
	    ContinueReadingUntilFinished = 0,
        ContinueReading = 1,
        Close = 2
	}
	
	public enum RemoteStoragePublishedFileVisibility
	{
	    Public = 0,
        FriendsOnly = 1,
        Private = 2,
        Unlisted = 3
	}

    [AllowDuplicates]
	public enum WorkshopFileType
	{
	    First = 0,
        Community = 0,
        Microtransaction = 1,
        Collection = 2,
        Art = 3,
        Video = 4,
        Screenshot = 5,
        Game = 6,
        Software = 7,
        Concept = 8,
        WebGuide = 9,
        IntegratedGuide = 10,
        Merch = 11,
        ControllerBinding = 12,
        SteamworksAccessInvite = 13,
        SteamVideo = 14,
        GameManagedItem = 15,
        Max = 16
	}
	
	public enum WorkshopVideoProvider
	{
	    None = 0,
        YouTube = 1
	}
	
	public enum WorkshopFileAction
	{
	    Played = 0,
        Completed = 1
	}
	
	public enum WorkshopEnumerationType
	{
	    RankedByVote = 0,
        Recent = 1,
        Trending = 2,
        FavoritesOfFriends = 3,
        VotedByFriends = 4,
        ContentByFriends = 5,
        RecentFromFollowedUsers = 6
	}
	
	public enum ControllerActionOrigin
	{
	    None = 0,
        A = 1,
        B = 2,
        X = 3,
        Y = 4,
        LeftBumper = 5,
        RightBumper = 6,
        LeftGrip = 7,
        RightGrip = 8,
        Start = 9,
        Back = 10,
        LeftPad_Touch = 11,
        LeftPad_Swipe = 12,
        LeftPad_Click = 13,
        LeftPad_DPadNorth = 14,
        LeftPad_DPadSouth = 15,
        LeftPad_DPadWest = 16,
        LeftPad_DPadEast = 17,
        RightPad_Touch = 18,
        RightPad_Swipe = 19,
        RightPad_Click = 20,
        RightPad_DPadNorth = 21,
        RightPad_DPadSouth = 22,
        RightPad_DPadWest = 23,
        RightPad_DPadEast = 24,
        LeftTrigger_Pull = 25,
        LeftTrigger_Click = 26,
        RightTrigger_Pull = 27,
        RightTrigger_Click = 28,
        LeftStick_Move = 29,
        LeftStick_Click = 30,
        LeftStick_DPadNorth = 31,
        LeftStick_DPadSouth = 32,
        LeftStick_DPadWest = 33,
        LeftStick_DPadEast = 34,
        Gyro_Move = 35,
        Gyro_Pitch = 36,
        Gyro_Yaw = 37,
        Gyro_Roll = 38,
        PS4_X = 39,
        PS4_Circle = 40,
        PS4_Triangle = 41,
        PS4_Square = 42,
        PS4_LeftBumper = 43,
        PS4_RightBumper = 44,
        PS4_Options = 45,
        PS4_Share = 46,
        PS4_LeftPad_Touch = 47,
        PS4_LeftPad_Swipe = 48,
        PS4_LeftPad_Click = 49,
        PS4_LeftPad_DPadNorth = 50,
        PS4_LeftPad_DPadSouth = 51,
        PS4_LeftPad_DPadWest = 52,
        PS4_LeftPad_DPadEast = 53,
        PS4_RightPad_Touch = 54,
        PS4_RightPad_Swipe = 55,
        PS4_RightPad_Click = 56,
        PS4_RightPad_DPadNorth = 57,
        PS4_RightPad_DPadSouth = 58,
        PS4_RightPad_DPadWest = 59,
        PS4_RightPad_DPadEast = 60,
        PS4_CenterPad_Touch = 61,
        PS4_CenterPad_Swipe = 62,
        PS4_CenterPad_Click = 63,
        PS4_CenterPad_DPadNorth = 64,
        PS4_CenterPad_DPadSouth = 65,
        PS4_CenterPad_DPadWest = 66,
        PS4_CenterPad_DPadEast = 67,
        PS4_LeftTrigger_Pull = 68,
        PS4_LeftTrigger_Click = 69,
        PS4_RightTrigger_Pull = 70,
        PS4_RightTrigger_Click = 71,
        PS4_LeftStick_Move = 72,
        PS4_LeftStick_Click = 73,
        PS4_LeftStick_DPadNorth = 74,
        PS4_LeftStick_DPadSouth = 75,
        PS4_LeftStick_DPadWest = 76,
        PS4_LeftStick_DPadEast = 77,
        PS4_RightStick_Move = 78,
        PS4_RightStick_Click = 79,
        PS4_RightStick_DPadNorth = 80,
        PS4_RightStick_DPadSouth = 81,
        PS4_RightStick_DPadWest = 82,
        PS4_RightStick_DPadEast = 83,
        PS4_DPad_North = 84,
        PS4_DPad_South = 85,
        PS4_DPad_West = 86,
        PS4_DPad_East = 87,
        PS4_Gyro_Move = 88,
        PS4_Gyro_Pitch = 89,
        PS4_Gyro_Yaw = 90,
        PS4_Gyro_Roll = 91,
        XBoxOne_A = 92,
        XBoxOne_B = 93,
        XBoxOne_X = 94,
        XBoxOne_Y = 95,
        XBoxOne_LeftBumper = 96,
        XBoxOne_RightBumper = 97,
        XBoxOne_Menu = 98,
        XBoxOne_View = 99,
        XBoxOne_LeftTrigger_Pull= 100,
        XBoxOne_LeftTrigger_Click = 101,
        XBoxOne_RightTrigger_Pull = 102,
        XBoxOne_RightTrigger_Click = 103,
        XBoxOne_LeftStick_Move = 104,
        XBoxOne_LeftStick_Click = 105,
        XBoxOne_LeftStick_DPadNorth = 106,
        XBoxOne_LeftStick_DPadSouth = 107,
        XBoxOne_LeftStick_DPadWest = 108,
        XBoxOne_LeftStick_DPadEast = 109,
        XBoxOne_RightStick_Move = 110,
        XBoxOne_RightStick_Click = 111,
        XBoxOne_RightStick_DPadNorth = 112,
        XBoxOne_RightStick_DPadSouth = 113,
        XBoxOne_RightStick_DPadWest = 114,
        XBoxOne_RightStick_DPadEast = 115,
        XBoxOne_DPad_North = 116,
        XBoxOne_DPad_South = 117,
        XBoxOne_DPad_West = 118,
        XBoxOne_DPad_East = 119,
        XBox360_A = 120,
        XBox360_B = 121,
        XBox360_X = 122,
        XBox360_Y = 123,
        XBox360_LeftBumper = 124,
        XBox360_RightBumper = 125,
        XBox360_Start = 126,
        XBox360_Back = 127,
        XBox360_LeftTrigger_Pull = 128,
        XBox360_LeftTrigger_Click = 129,
        XBox360_RightTrigger_Pull	= 130,
        XBox360_RightTrigger_Click = 131,
        XBox360_LeftStick_Move = 132,
        XBox360_LeftStick_Click = 133,
        XBox360_LeftStick_DPadNorth = 134,
        XBox360_LeftStick_DPadSouth = 135,
        XBox360_LeftStick_DPadWest = 136,
        XBox360_LeftStick_DPadEast = 137,
        XBox360_RightStick_Move = 138,
        XBox360_RightStick_Click = 139,
        XBox360_RightStick_DPadNorth = 140,
        XBox360_RightStick_DPadSouth = 141,
        XBox360_RightStick_DPadWest = 142,
        XBox360_RightStick_DPadEast = 143,
        XBox360_DPad_North = 144,
        XBox360_DPad_South = 145,
        XBox360_DPad_West = 146,
        XBox360_DPad_East = 147,
        Count = 196

	}
	
	public enum SteamControllerPad
	{
	    Left = 0,
        Right = 1
	}
	
	public enum SteamInputType
	{
	    Unknown = 0,
        SteamController = 1,
        XBox360Controller = 2,
        XBoxOneController = 3,
        GenericXInput = 4,
        PS4Controller = 5,
        AppleMFiController = 6,
        AndroidController = 7,
        SwitchJoyConPair = 8,
        SwitchJoyConSingle = 9,
        SwitchProController = 10,
        MobileTouch = 11,
        PS3Controller = 12,
        Count = 13,
        MaximumPossibleValue = 255
	}

    public enum ControllerSourceMode
    {
        None = 0,
        Dpad = 1,
        Buttons = 2,
        FourButtons = 3,
        AbsoluteMouse = 4,
        RelativeMouse = 5,
        JoystickMove = 6,
        JoystickMouse = 7,
        JoystickCamera = 8,
        ScrollWheel = 9,
        Trigger = 10,
        TouchMenu = 11,
        MouseJoystick = 12,
        MouseRegion = 13,
        RadialMenu = 14,
        SingleButton = 15,
        Switches = 16
    }
}