#pragma once
#include "Typedefs.h"

using HSteamPipe = i32;
using HSteamUser = i32;
using AppId = u32;
using SteamAPICall = u64;
using CSteamID = u64;
using CGameID = u64;
using HAuthTicket = u32;
using FriendsGroupID = i16;
using UGCHandle = u64;
using SteamLeaderboard = u64;
using SteamLeaderboardEntries = u64;
using DepotId = u32;
using SNetListenSocket = u32;
using SNetSocket = u32;
using UGCFileWriteStreamHandle = u64;
using PublishedFileUpdateHandle = u64;
using PublishedFileId = u64;
using ControllerActionSetHandle = u64;
using ControllerAnalogActionHandle = u64;
using ControllerDigitalActionHandle = u64;
using ControllerHandle = u64;

struct ISteamClient;
struct ISteamUser;
struct ISteamFriends;
struct ISteamUtils;
struct ISteamMatchmaking;
struct ISteamUserStats;
struct ISteamApps;
struct ISteamMatchmakingServers;
struct ISteamNetworking;
struct ISteamRemoteStorage;
struct ISteamScreenshots;
struct ISteamHTTP;
struct ISteamController;
struct ISteamUG;
struct ISteamAppList;
struct ISteamMusic;
struct ISteamMusicRemote;
struct ISteamHTMLSurface;
struct ISteamInventory;
struct ISteamVideo;
struct ISteamParentalSettings;
struct ISteamUGC;
struct ISteamGameServer;
struct ISteamGameServerStats;
struct ISteamUnifiedMessages;
struct FriendGameInfo;
struct LeaderboardEntry;
struct P2PSessionState;
struct SteamParamStringArray;
struct ControllerDigitalActionData;
struct ControllerAnalogActionData;
struct ControllerMotionData;

enum class AccountType
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
};

enum class VoiceResult
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
};

enum class BeginAuthSessionResult
{
    OK = 0,
    InvalidTicket = 1,
    DuplicateRequest = 2,
    InvalidVersion = 3,
    GameMismatch = 4,
    ExpiredTicket = 5
};

enum class UserHasLicenseForAppResult
{
    HasLicense = 0,
    DoesNotHaveLicense = 1,
    NoAuth = 2,
};

enum class P2PSend
{
    Unreliable = 0,
    UnreliableNoDelay = 1,
    Reliable = 2,
    ReliableWithBuffering = 3
};

enum class OverlayToStoreFlag
{
    None = 0,
    AddToCart = 1,
    AddToCartAndShow = 2,
};

enum class ChatEntryType
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
    LinkBlocked = 14
};

enum class PersonaState
{
    Offline = 0,
    Online = 1,
    Busy = 2,
    Away = 3,
    Snooze = 4,
    LookingToTrade = 5,
    LookingToPlay = 6,
    Max = 7
};

enum class FriendRelationship
{
    None = 0,
    Blocked = 1,
    RequestRecipient = 2,
    Friend = 3,
    RequestInitiator = 4,
    Ignored = 5,
    IgnoredFriend = 6,
    Suggested_DEPRECATED = 7,
    Max = 8,
};

enum class SteamAPICallFailure
{
    None = -1,
    SteamGone = 0,
    NetworkFailure = 1,
    InvalidHandle = 2,
    MismatchedCallback = 3
};

enum class Universe : u32
{
    Invalid = 0,
    Public = 1,
    Beta = 2,
    Internal = 3,
    Dev = 4,
    Max = 5
};

enum class NotificationPosition
{
    TopLeft = 0,
    TopRight = 1,
    BottomLeft = 2,
    BottomRight = 3
};

enum class LobbyComparison
{
    EqualToOrLessThan = -2,
    LessThan = -1,
    Equal = 0,
    GreaterThan = 1,
    EqualToOrGreaterThan = 2,
    NotEqual = 3
};

enum class LobbyDistanceFilter
{
    Close = 0,
    Default = 1,
    Far = 2,
    Worldwide = 3
};

enum class LobbyType
{
    Private = 0,
    FriendsOnly = 1,
    Public = 2,
    Invisible = 3
};

enum class LeaderboardSortMethod
{
    None = 0,
    Ascending = 1,
    Descending = 2
};

enum class LeaderboardDisplayType
{
    None = 0,
    Numeric = 1,
    TimeSeconds = 2,
    TimeMilliSeconds = 3
};

enum class LeaderboardDataRequest
{
    Global = 0,
    GlobalAroundUser = 1,
    Friends = 2,
    Users = 3
};

enum class LeaderboardUploadScoreMethod
{
    None = 0,
    KeepBest = 1,
    ForceUpdate = 2
};

enum class GamepadTextInputMode
{
    Normal = 0,
    Password = 1
};

enum class GamepadTextInputLineMode
{
    SingleLine = 0,
    MultipleLines = 1
};

enum class SNetSocketConnectionType
{
    NotConnected = 0,
    UDP = 1,
    UDPRelay = 2
};

enum class RemoteStoragePlatform
{
    None = 0,
    Windows = 1 << 0,
    OSX = 1 << 1,
    PS3 = 1 << 2,
    Linux = 1 << 3,
    Reserved2 = 1 << 4,
    All = 0xFFFFFFFF
};

enum class UGCReadAction
{
    ContinueReadingUntilFinished = 0,
    ContinueReading = 1,
    Close = 2
};

enum class RemoteStoragePublishedFileVisibility
{
    Public = 0,
    FriendsOnly = 1,
    Private = 2,
    Unlisted = 3
};

enum class WorkshopFileType
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
};

enum class WorkshopVideoProvider
{
    None = 0,
    YouTube = 1
};

enum class WorkshopFileAction
{
    Played = 0,
    Completed = 1
};

enum class WorkshopEnumerationType
{
    RankedByVote = 0,
    Recent = 1,
    Trending = 2,
    FavoritesOfFriends = 3,
    VotedByFriends = 4,
    ContentByFriends = 5,
    RecentFromFollowedUsers = 6
};

enum class ControllerActionOrigin
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
    XBoxOne_LeftTrigger_Pull = 100,
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
    XBox360_RightTrigger_Pull = 130,
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
};

enum class SteamControllerPad
{
    Left = 0,
    Right = 1
};

enum class SteamInputType
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
};

enum class ControllerSourceMode
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
};

enum class CallbackType : i32
{
    ValidateAuthTicketResponse = 143,
    GetAuthSessionTicketResponse = 163,
    GameLobbyJoinRequested = 333,
    LobbyEnter = 504, //RFG uses this with CCallResult and CCallback
    LobbyDataUpdate = 505,
    LobbyChatUpdate = 506,
    LobbyMatchList = 510, //RFG only uses this with CCallResult
    LobbyCreated = 513, //RFG only uses this with CCallResult
    SteamUserStatsReceived = 1101,
    SteamUserStatsStored = 1102,
    SteamUserAchievementStored = 1103,
    P2PSessionRequest = 1202,
};

enum class AuthSessionResponse : u32
{
    OK = 0,
    UserNotConnectedToSteam = 1,
    NoLicenseOrExpired = 2,
    VACBanned = 3,
    LoggedInElseWhere = 4,
    VACCheckTimedOut = 5,
    AuthTicketCanceled = 6,
    AuthTicketInvalidAlreadyUsed = 7,
    AuthTicketInvalid = 8,
    PublisherIssuedBan = 9
};

enum class BackendResult : u32
{
    OK = 0x1,
    Fail = 0x2,
    NoConnection = 0x3,
    InvalidPassword = 0x5,
    LoggedInElsewhere = 0x6,
    InvalidProtocolVer = 0x7,
    InvalidParam = 0x8,
    FileNotFound = 0x9,
    Busy = 0xa,
    InvalidState = 0xb,
    InvalidName = 0xc,
    InvalidEmail = 0xd,
    DuplicateName = 0xe,
    AccessDenied = 0xf,
    Timeout = 0x10,
    Banned = 0x11,
    AccountNotFound = 0x12,
    InvalidSteamID = 0x13,
    ServiceUnavailable = 0x14,
    NotLoggedOn = 0x15,
    Pending = 0x16,
    EncryptionFailure = 0x17,
    InsufficientPrivilege = 0x18,
    LimitExceeded = 0x19,
    Revoked = 0x1a,
    Expired = 0x1b,
    AlreadyRedeemed = 0x1c,
    DuplicateRequest = 0x1d,
    AlreadyOwned = 0x1e,
    IPNotFound = 0x1f,
    PersistFailed = 0x20,
    LockingFailed = 0x21,
    LogonSessionReplaced = 0x22,
    ConnectFailed = 0x23,
    HandshakeFailed = 0x24,
    IOFailure = 0x25,
    RemoteDisconnect = 0x26,
    ShoppingCartNotFound = 0x27,
    Blocked = 0x28,
    Ignored = 0x29,
    NoMatch = 0x2a,
    AccountDisabled = 0x2b,
    ServiceReadOnly = 0x2c,
    AccountNotFeatured = 0x2d,
    AdministratorOK = 0x2e,
    ContentVersion = 0x2f,
    TryAnotherCM = 0x30,
    PasswordRequiredToKickSession = 0x31,
    AlreadyLoggedInElsewhere = 0x32,
    Suspended = 0x33,
    Cancelled = 0x34,
    DataCorruption = 0x35,
    DiskFull = 0x36,
    RemoteCallFailed = 0x37,
    PasswordUnset = 0x38,
    ExternalAccountUnlinked = 0x39,
    PSNTicketInvalid = 0x3a,
    ExternalAccountAlreadyLinked = 0x3b,
    RemoteFileConflict = 0x3c,
    IllegalPassword = 0x3d,
    SameAsPreviousValue = 0x3e,
    AccountLogonDenied = 0x3f,
    CannotUseOldPassword = 0x40,
    InvalidLoginAuthCode = 0x41,
    AccountLogonDeniedNoMail = 0x42,
    HardwareNotCapableOfIPT = 0x43,
    IPTInitError = 0x44,
    ParentalControlRestricted = 0x45,
    FacebookQueryError = 0x46,
    ExpiredLoginAuthCode = 0x47,
    IPLoginRestrictionFailed = 0x48,
    AccountLockedDown = 0x49,
    AccountLogonDeniedVerifiedEmailRequired = 0x4a,
    NoMatchingURL = 0x4b,
    BadResponse = 0x4c,
    RequirePasswordReEntry = 0x4d,
    ValueOutOfRange = 0x4e,
    UnexpectedError = 0x4f,
    Disabled = 0x50,
    InvalidCEGSubmission = 0x51,
    RestrictedDevice = 0x52,
    RegionLocked = 0x53,
    RateLimitExceeded = 0x54,
    AccountLoginDeniedNeedTwoFactor = 0x55,
    ItemDeleted = 0x56,
    AccountLoginDeniedThrottle = 0x57,
    TwoFactorCodeMismatch = 0x58,
    TwoFactorActivationCodeMismatch = 0x59,
    AccountAssociatedToMultiplePartners = 0x5a,
    NotModified = 0x5b,
    NoMobileDevice = 0x5c,
    TimeNotSynced = 0x5d,
    SmsCodeFailed = 0x5e,
    AccountLimitExceeded = 0x5f,
    AccountActivityLimitExceeded = 0x60,
    PhoneActivityLimitExceeded = 0x61,
    RefundToWallet = 0x62,
    EmailSendFailure = 0x63,
    NotSettled = 0x64,
    NeedCaptcha = 0x65,
    GSLTDenied = 0x66,
    GSOwnerDenied = 0x67,
    InvalidItemType = 0x68,
    IPBanned = 0x69,
    GSLTExpired = 0x6a,
    InsufficientFunds = 0x6b,
    TooManyPending = 0x6c,
    NoSiteLicensesFound = 0x6d,
    WGNetworkSendExceeded = 0x6e,
    AccountNotFriends = 0x6f,
    LimitedUserAccount = 0x70
};

struct ValidateAuthTicketResponse
{
    CSteamID SteamID;
    AuthSessionResponse AuthSessionResponse;
    CSteamID OwnerSteamID;
};

struct GetAuthSessionTicketResponse
{
    u32 AuthTicket;
    BackendResult Result;
};

struct GameLobbyJoinRequested
{
    CSteamID SteamIDLobby;
    CSteamID SteamIDFriend;
};

struct LobbyEnter
{
    u64 SteamIDLobby; //TODO: Should this be a CSteamID?
    u32 ChatPermissions;
    bool Blocked; //TODO: Is this really a bool, or a u8? Naming scheme in rfg.exe indicates its a bool, but the debugger shows it being set to some strange values like 13 (would've expected 255 for true and 0 for false)
    u32 ChatRoomEnterResponse; //Likely an enum
};

struct LobbyMatchList
{
    u32 NumLobbiesMatching;
};

struct LobbyCreated
{
    BackendResult Result;
    u64 SteamIDLobby; //TODO: Should this be a CSteamID?
};

struct LobbyDataUpdate
{
    u64 SteamIDLobby;
    u64 SteamIDMember;
    bool Success;
};

struct LobbyChatUpdate
{
    u64 SteamIDLobby;
    u64 SteamIDUserChanged;
    u64 SteamIDMakingChange;
    u64 ChatMemberStateChange;
};

struct UserStatsReceived
{
    u64 GameID;
    BackendResult Result;
    CSteamID SteamIDUser;
};

struct UserStatsStored
{
    u64 GameID;
    BackendResult Result;
};

struct UserAchievementStored
{
    u64 GameID;
    bool GroupAchievement;
    char AchievementName[128];
    u32 CurProgress;
    u32 MaxProgress;
};

struct P2PSessionRequest
{
    CSteamID SteamIDRemote;
};

//Base class for callbacks and call results. Used by the DLL to communicate events/data to the game asynchronously.
//Callbacks can send data to multiple listeners
//Call results only send them to one listener
struct CCallbackBase
{
    //So far I've only seen these two fields use with CCallResult<>
    u8 CallbackFlags;
    CallbackType CallResultType;

    virtual void Run(void* param, u8 param1, u64 param2) = 0;
    virtual void Run(void* param) = 0;
    virtual i32 GetCallbackSizeBytes() = 0;
};

enum GameLinkState
{

};

enum GameLinkError
{

};

struct GameLinkInternet
{
    void* vtable;
    GameLinkState State;
    GameLinkError Error;
    i32 PlatformErrorCode;
    bool GameplayRunning;
    f32 VoicechatVolume;
    //TODO: Define the rest of the members + the vtable funcs
};

struct CSteamAPIContext
{
    ISteamClient* Client;
    ISteamUser* User;
    ISteamFriends* Friends;
    ISteamUtils* Utils;
    ISteamMatchmaking* Matchmaking;
    ISteamUserStats* UserStats;
    ISteamApps* Apps;
    ISteamMatchmakingServers* MatchmakingServers;
    ISteamNetworking* Networking;
    ISteamRemoteStorage* RemoteStorage;
    ISteamScreenshots* Screenshots;
    ISteamHTTP* HTTP;
    ISteamController* Controller;
    ISteamUGC* UGC;
    ISteamAppList* AppList;
    ISteamMusic* Music;
    ISteamMusicRemote* MusicRemote;
    ISteamHTMLSurface* HTMLSurface;
    ISteamInventory* Inventory;
    ISteamVideo* Video;
    ISteamParentalSettings* ParentalSettings;
};

//Structure the game passes to sw_api.dll to ensure its initialized before use
struct CallbackCounterAndContext
{
    //The game sets this to SteamInternal_OnContextInit prior to calling SW_CCSysDynamicInit. The game uses this callback to set the pointers in Context
    void(__cdecl* InitCallback)(CSteamAPIContext* context);
    i32 Counter; //The number of times SW_CCSys_DynamicInit has been called
    CSteamAPIContext* Context;
};

//Meant to imitate the real ISteamClient interface that the real sw_api.dll provides. The GOG version of sw_api.dll seems to something similar.
struct ISteamClient
{
    virtual HSteamPipe CreateSteamPipe() = 0;
    virtual bool BReleaseSteamPipe(HSteamPipe hSteamPipe) = 0;
    virtual HSteamUser ConnectToGlobalUser(HSteamPipe hSteamPipe) = 0;
    virtual HSteamUser CreateLocalUser(HSteamPipe hSteamPipe, AccountType eAccountType) = 0;
    virtual void ReleaseUser(HSteamPipe hSteamPipe, HSteamUser hUser) = 0;
    virtual ISteamUser* GetISteamUser(HSteamUser hSteamUser, HSteamPipe hSteamPipe, const char* pchVersion) = 0;
    virtual ISteamGameServer* GetISteamGameServer(HSteamUser hSteamUser, HSteamPipe hSteamPipe, const char* pchVersion) = 0;
    virtual void SetLocalIPBinding(u32 unIP, u16 usPort) = 0;
    virtual ISteamFriends* GetISteamFriends(HSteamUser hSteamUser, HSteamPipe hSteamPipe, const char* pchVersion) = 0;
    virtual ISteamUtils* GetISteamUtils(HSteamPipe hSteamPipe, const char* pchVersion) = 0;
    virtual ISteamMatchmaking* GetISteamMatchmaking(HSteamUser hSteamUser, HSteamPipe hSteamPipe, const char* pchVersion) = 0;
    virtual ISteamMatchmakingServers* GetISteamMatchmakingServers(HSteamUser hSteamUser, HSteamPipe hSteamPipe, const char* pchVersion) = 0;
    virtual void* GetISteamGenericInterface(HSteamUser hSteamUser, HSteamPipe hSteamPipe, const char* pchVersion) = 0;
    virtual ISteamUserStats* GetISteamUserStats(HSteamUser hSteamUser, HSteamPipe hSteamPipe, const char* pchVersion) = 0;
    virtual ISteamGameServerStats* GetISteamGameServerStats(HSteamUser hSteamUser, HSteamPipe hSteamPipe, const char* pchVersion) = 0;
    virtual ISteamApps* GetISteamApps(HSteamUser hSteamUser, HSteamPipe hSteamPipe, const char* pchVersion) = 0;
    virtual ISteamNetworking* GetISteamNetworking(HSteamUser hSteamUser, HSteamPipe hSteamPipe, const char* pchVersion) = 0;
    virtual ISteamRemoteStorage* GetISteamRemoteStorage(HSteamUser hSteamUser, HSteamPipe hSteamPipe, const char* pchVersion) = 0;
    virtual ISteamScreenshots* GetISteamScreenshots(HSteamUser hSteamUser, HSteamPipe hSteamPipe, const char* pchVersion) = 0;
    virtual void RunFrame() = 0;
    virtual u32 GetIPCCallCount() = 0;
    virtual void SetWarningMessageHook(void(*pFunction)(i32 severity, const char* pchDebugText)) = 0;
    virtual bool BShutdownIfAllPipesClosed() = 0;
    virtual ISteamHTTP* GetISteamHTTP(HSteamUser hSteamUser, HSteamPipe hSteamPipe, const char* pchVersion) = 0;
    virtual ISteamUnifiedMessages* DEPRECATED_GetISteamUnifiedMessages(HSteamUser hSteamUser, HSteamPipe hSteamPipe, const char* pchVersion) = 0;
    virtual ISteamController* GetISteamController(HSteamUser hSteamUser, HSteamPipe hSteamPipe, const char* pchVersion) = 0;
    virtual ISteamUGC* GetISteamUGC(HSteamUser hSteamUser, HSteamPipe hSteamPipe, const char* pchVersion) = 0;
    virtual ISteamAppList* GetISteamAppList(HSteamUser hSteamUser, HSteamPipe hSteamPipe, const char* pchVersion) = 0;
    virtual ISteamMusic* GetISteamMusic(HSteamUser hSteamUser, HSteamPipe hSteamPipe, const char* pchVersion) = 0;
    virtual ISteamMusicRemote* GetISteamMusicRemote(HSteamUser hSteamUser, HSteamPipe hSteamPipe, const char* pchVersion) = 0;
    virtual ISteamHTMLSurface* GetISteamHTMLSurface(HSteamUser hSteamUser, HSteamPipe hSteamPipe, const char* pchVersion) = 0;
    virtual void DEPRECATED_Set_SteamAPI_CPostAPIResultInProcess(void(*pFunc)()) = 0;
    virtual void DEPRECATED_Remove_SteamAPI_CPostAPIResultInProcess(void(*pFunc)()) = 0;
    virtual void Set_SteamAPI_CCheckCallbackRegisteredInProcess(void(*pFunc)()) = 0;
    virtual ISteamInventory* GetISteamInventory(HSteamUser hSteamUser, HSteamPipe hSteamPipe, const char* pchVersion) = 0;
    virtual ISteamVideo* GetISteamVideo(HSteamUser hSteamUser, HSteamPipe hSteamPipe, const char* pchVersion) = 0;
    virtual ISteamParentalSettings* GetISteamParentalSettings(HSteamUser hSteamUser, HSteamPipe hSteamPipe, const char* pchVersion) = 0;
};

struct ISteamUser
{
    virtual HSteamUser SW_CCSys_GetU() = 0;
    virtual bool BLoggedOn() = 0;
    virtual void* GetSteamID(void* __return) = 0;
    virtual i32 InitiateGameConnection(void* pAuthBlob, i32 cbMaxAuthBlob, CSteamID steamIDGameServer, u32 unIPServer, u16 usPortServer, bool bSecure) = 0;
    virtual void TerminateGameConnection(u32 unIPServer, u16 usPortServer) = 0;
    virtual void TrackAppUsageEvent(CGameID gameID, i32 eAppUsageEvent, void* pchExtraInfo) = 0;
    virtual bool GetUserDataFolder(void* pchBuffer, i32 cubBuffer) = 0;
    virtual void StartVoiceRecording() = 0;
    virtual void StopVoiceRecording() = 0;
    virtual VoiceResult GetAvailableVoice(void* pcbCompressed, void* pcbUncompressed_Deprecated, u32 nUncompressedVoiceDesiredSampleRate_Deprecated) = 0;
    virtual VoiceResult GetVoice(bool bWantCompressed, void* pDestBuffer, u32 cbDestBufferSize, void* nBytesWritten, bool bWantUncompressed_Deprecated, void* pUncompressedDestBuffer_Deprecated, u32 cbUncompressedDestBufferSize_Deprecated, void* nUncompressBytesWritten_Deprecated, u32 nUncompressedVoiceDesiredSampleRate_Deprecated) = 0;
    virtual VoiceResult DecompressVoice(void* pCompressed, u32 cbCompressed, void* pDestBuffer, u32 cbDestBufferSize, void* nBytesWritten, u32 nDesiredSampleRate) = 0;
    virtual u32 GetVoiceOptimalSampleRate() = 0;
    virtual HAuthTicket GetAuthSessionTicket(void* pTicket, i32 cbMaxTicket, void* pcbTicket) = 0;
    virtual BeginAuthSessionResult BeginAuthSession(void* pAuthTicket, i32 cbAuthTicket, CSteamID steamID) = 0;
    virtual void EndAuthSession(CSteamID steamID) = 0;
    virtual void CancelAuthTicket(HAuthTicket hAuthTicket) = 0;
    virtual UserHasLicenseForAppResult UserHasLicenseForApp(CSteamID steamID, AppId appId) = 0;
    virtual bool BIsBehindNAT() = 0;
    virtual void AdvertiseGame(CSteamID steamIDGameServer, u32 unIPServer, u16 usPortServer) = 0;
    virtual SteamAPICall RequestEncryptedAppTicket(void* pDataToInclude, i32 cbDataToInclude) = 0;
    virtual bool GetEncryptedAppTicket(void* pTicket, i32 cbMaxTicket, void* pcbTicket) = 0;
    virtual int GetGameBadgeLevel(i32 nSeries, bool bFoil) = 0;
    virtual int GetPlayerSteamLevel() = 0;
    virtual SteamAPICall RequestStoreAuthURL(void* pchRedirectURL) = 0;
    virtual bool BIsPhoneVerified() = 0;
    virtual bool BIsTwoFactorEnabled() = 0;
    virtual bool BIsPhoneIdentifying() = 0;
    virtual bool BIsPhoneRequiringVerification() = 0;
};

struct ISteamFriends
{
    virtual void* GetPersonaName() = 0;
    virtual SteamAPICall SetPersonaName(void* pchPersonaName) = 0;
    virtual PersonaState GetPersonaState() = 0;
    virtual int GetFriendCount(int iFriendFlags) = 0;
    virtual CSteamID GetFriendByIndex(int iFriend, int iFriendFlags) = 0;
    virtual FriendRelationship GetFriendRelationship(CSteamID steamIDFriend) = 0;
    virtual PersonaState GetFriendPersonaState(CSteamID steamIDFriend) = 0;
    virtual void* GetFriendPersonaName(CSteamID steamIDFriend) = 0;
    virtual bool GetFriendGamePlayed(CSteamID steamIDFriend, void* pFriendGameInfo) = 0;
    virtual void* GetFriendPersonaNameHistory(CSteamID steamIDFriend, int iPersonaName) = 0;
    virtual i32 GetFriendSteamLevel(CSteamID steamIDFriend) = 0;
    virtual void* GetPlayerNickname(CSteamID steamIDPlayer) = 0;
    virtual i32 GetFriendsGroupCount() = 0;
    virtual FriendsGroupID GetFriendsGroupIDByIndex(i32 iFG) = 0;
    virtual void* GetFriendsGroupName(FriendsGroupID friendsGroupID) = 0;
    virtual i32 GetFriendsGroupMembersCount(FriendsGroupID friendsGroupID) = 0;
    virtual void GetFriendsGroupMembersList(FriendsGroupID friendsGroupID, void* pOutSteamIDMembers, i32 nMembersCount) = 0;
    virtual bool HasFriend(CSteamID steamIDFriend, int iFriendFlags) = 0;
    virtual i32 GetClanCount() = 0;
    virtual CSteamID GetClanByIndex(void* __return, i32 iClan) = 0;
    virtual void* GetClanName(CSteamID steamIDClan) = 0;
    virtual void* GetClanTag(CSteamID steamIDClan) = 0;
    virtual bool GetClanActivityCounts(CSteamID steamIDClan, void* pnOnline, void* pnInGame, void* pnChatting) = 0;
    virtual SteamAPICall DownloadClanActivityCounts(void* psteamIDClans, i32 cClansToRequest) = 0;
    virtual i32 GetFriendCountFromSource(CSteamID steamIDSource) = 0;
    virtual CSteamID GetFriendFromSourceByIndex(void* __return, CSteamID steamIDSource, i32 iFriend) = 0;
    virtual bool IsUserInSource(CSteamID steamIDUser, CSteamID steamIDSource) = 0;
    virtual void SetInGameVoiceSpeaking(CSteamID steamIDUser, bool bSpeaking) = 0;
    virtual void ActivateGameOverlay(void* pchDialog) = 0;
    virtual void ActivateGameOverlayToUser(void* pchDialog, CSteamID steamID) = 0;
    virtual void ActivateGameOverlayToWebPage(void* pchURL) = 0;
    virtual void ActivateGameOverlayToStore(AppId nAppID, OverlayToStoreFlag eFlag) = 0;
    virtual void SetPlayedWith(CSteamID steamIDUserPlayedWith) = 0;
    virtual void ActivateGameOverlayInviteDialog(CSteamID steamIDLobby) = 0;
    virtual int GetSmallFriendAvatar(CSteamID steamIDFriend) = 0;
    virtual int GetMediumFriendAvatar(CSteamID steamIDFriend) = 0;
    virtual int GetLargeFriendAvatar(CSteamID steamIDFriend) = 0;
    virtual bool RequestUserInformation(CSteamID steamIDUser, bool bRequireNameOnly) = 0;
    virtual SteamAPICall RequestClanOfficerList(CSteamID steamIDClan) = 0;
    virtual CSteamID GetClanOwner(void* __return, CSteamID steamIDClan) = 0;
    virtual int GetClanOfficerCount(CSteamID steamIDClan) = 0;
    virtual CSteamID GetClanOfficerByIndex(void* __return, CSteamID steamIDClan, int iOfficer) = 0;
    virtual u32 GetUserRestrictions() = 0;
    virtual bool SetRichPresence(void* pchKey, void* pchValue) = 0;
    virtual void ClearRichPresence() = 0;
    virtual void* GetFriendRichPresence(CSteamID steamIDFriend, void* pchKey) = 0;
    virtual int GetFriendRichPresenceKeyCount(CSteamID steamIDFriend) = 0;
    virtual void* GetFriendRichPresenceKeyByIndex(CSteamID steamIDFriend, int iKey) = 0;
    virtual void RequestFriendRichPresence(CSteamID steamIDFriend) = 0;
    virtual bool InviteUserToGame(CSteamID steamIDFriend, void* pchConnectString) = 0;
    virtual int GetCoplayFriendCount() = 0;
    virtual CSteamID GetCoplayFriend(void* __return, int iCoplayFriend) = 0;
    virtual int GetFriendCoplayTime(CSteamID steamIDFriend) = 0;
    virtual AppId GetFriendCoplayGame(CSteamID steamIDFriend) = 0;
    virtual SteamAPICall JoinClanChatRoom(CSteamID steamIDClan) = 0;
    virtual bool LeaveClanChatRoom(CSteamID steamIDClan) = 0;
    virtual int GetClanChatMemberCount(CSteamID steamIDClan) = 0;
    virtual CSteamID GetChatMemberByIndex(void* __return, CSteamID steamIDClan, int iUser) = 0;
    virtual bool SendClanChatMessage(CSteamID steamIDClanChat, void* pchText) = 0;
    virtual int GetClanChatMessage(CSteamID steamIDClanChat, int iMessage, void* prgchText, int cchTextMax, void* peChatEntryType, void* psteamidChatter) = 0;
    virtual bool IsClanChatAdmin(CSteamID steamIDClanChat, CSteamID steamIDUser) = 0;
    virtual bool IsClanChatWindowOpenInSteam(CSteamID steamIDClanChat) = 0;
    virtual bool OpenClanChatWindowInSteam(CSteamID steamIDClanChat) = 0;
    virtual bool CloseClanChatWindowInSteam(CSteamID steamIDClanChat) = 0;
    virtual bool SetListenForFriendsMessages(bool bInterceptEnabled) = 0;
    virtual bool ReplyToFriendMessage(CSteamID steamIDFriend, void* pchMsgToSend) = 0;
    virtual int GetFriendMessage(CSteamID steamIDFriend, int iMessageID, void* pvData, int cubData, void* peChatEntryType) = 0;
    virtual SteamAPICall GetFollowerCount(CSteamID steamID) = 0;
    virtual SteamAPICall IsFollowing(CSteamID steamID) = 0;
    virtual SteamAPICall EnumerateFollowingList(u32 unStartIndex) = 0;
    virtual bool IsClanPublic(CSteamID steamIDClan) = 0;
    virtual bool IsClanOfficialGameGroup(CSteamID steamIDClan) = 0;
};

struct ISteamUtils
{
    virtual u32 GetSecondsSinceAppActive() = 0;
    virtual u32 GetSecondsSinceComputerActive() = 0;
    virtual Universe GetConnectedUniverse() = 0;
    virtual u32 GetServerRealTime() = 0;
    virtual void* GetIPCountry() = 0;
    virtual u8 GetImageSize(i32 iImage, void* pnWidth, void* pnHeight) = 0;
    virtual u8 GetImageRGBA(i32 iImage, void* pubDest, i32 nDestBufferSize) = 0;
    virtual u8 GetCSERIPPort(void* unIP, void* usPort) = 0;
    virtual u8 GetCurrentBatteryPower() = 0;
    virtual u32 GetAppID() = 0;
    virtual void SetOverlayNotificationPosition(NotificationPosition eNotificationPosition) = 0;
    virtual bool IsAPICallCompleted(SteamAPICall hSteamAPICall, void* pbFailed) = 0;
    virtual SteamAPICallFailure GetAPICallFailureReason(SteamAPICall hSteamAPICall) = 0;
    virtual bool GetAPICallResult(SteamAPICall hSteamAPICall, void* pCallback, int cubCallback, int iCallbackExpected, void* pbFailed) = 0;
    virtual void RunFrame() = 0;
    virtual u32 GetIPCCallCount() = 0;
    virtual void SetWarningMessageHook(void(*pFunc)(i32 nSeverity, void* pchDebugText)) = 0;
    virtual bool IsOverlayEnabled() = 0;
    virtual bool BOverlayNeedsPresent() = 0;
    virtual SteamAPICall CheckFileSignature(void* szFileName) = 0;
    virtual bool ShowGamepadTextInput(GamepadTextInputMode eInputMode, GamepadTextInputLineMode eLineInputMode, void* pchDescription, u32 unCharMax, void* pchExistingText) = 0;
    virtual u32 GetEnteredGamepadTextLength() = 0;
    virtual bool GetEnteredGamepadTextInput(void* pchText, u32 cchText) = 0;
    virtual void* GetSteamUILanguage() = 0;
    virtual bool IsSteamRunningInVR() = 0;
    virtual void SetOverlayNotificationInset(int nHorizontalInset, int nVerticalInset) = 0;
    virtual bool IsSteamInBigPictureMode() = 0;
    virtual void StartVRDashboard() = 0;
    virtual bool IsVRHeadsetStreamingEnabled() = 0;
    virtual void SetVRHeadsetStreamingEnabled(bool bEnabled) = 0;
};

struct ISteamMatchmaking
{
    virtual int GetFavoriteGameCount() = 0;
    virtual bool GetFavoriteGame(int iGame, void* pnAppID, void* pnIP, void* pnConnPort, void* pnQueryPort, void* punFlags, void* pRTime32LastPlayedOnServer) = 0;
    virtual int AddFavoriteGame(AppId nAppID, u32 nIP, u16 nConnPort, u16 nQueryPort, u32 unFlags, u32 rTime32LastPlayedOnServer) = 0;
    virtual bool RemoveFavoriteGame(AppId nAppID, u32 nIP, u16 nConnPort, u16 nQueryPort, u32 unFlags) = 0;
    virtual SteamAPICall RequestLobbyList() = 0;
    virtual void AddRequestLobbyListStringFilter(void* pchKeyToMatch, void* pchValueToMatch, LobbyComparison eComparisonType) = 0;
    virtual void AddRequestLobbyListNumericalFilter(void* pchKeyToMatch, int nValueToMatch, LobbyComparison eComparisonType) = 0;
    virtual void AddRequestLobbyListNearValueFilter(void* pchKeyToMatch, int nValueToBeCloseTo) = 0;
    virtual void AddRequestLobbyListFilterSlotsAvailable(int nSlotsAvailable) = 0;
    virtual void AddRequestLobbyListDistanceFilter(LobbyDistanceFilter eLobbyDistanceFilter) = 0;
    virtual void AddRequestLobbyListResultCountFilter(int cMaxResults) = 0;
    virtual void AddRequestLobbyListCompatibleMembersFilter(CSteamID steamIDLobby) = 0;
    virtual void* GetLobbyByIndex(void* __return, int nLobby) = 0;
    virtual SteamAPICall CreateLobby(LobbyType eLobbyType, int cMaxMembers) = 0;
    virtual SteamAPICall JoinLobby(CSteamID steamIDLobby) = 0;
    virtual void LeaveLobby(CSteamID steamIDLobby) = 0;
    virtual bool InviteUserToLobby(CSteamID steamIDLobby, CSteamID steamIDInvitee) = 0;
    virtual int GetNumLobbyMembers(CSteamID steamIDLobby) = 0;
    virtual CSteamID GetLobbyMemberByIndex(void* __return, CSteamID steamIDLobby, int iMember) = 0;
    virtual void* GetLobbyData(CSteamID steamIDLobby, void* pchKey) = 0;
    virtual bool SetLobbyData(CSteamID steamIDLobby, void* pchKey, void* pchValue) = 0;
    virtual int GetLobbyDataCount(CSteamID steamIDLobby) = 0;
    virtual bool GetLobbyDataByIndex(CSteamID steamIDLobby, int iLobbyData, void* pchKey, int cchKeyBufferSize, void* pchValue, int cchValueBufferSize) = 0;
    virtual bool DeleteLobbyData(CSteamID steamIDLobby, void* pchKey) = 0;
    virtual void* GetLobbyMemberData(CSteamID steamIDLobby, CSteamID steamIDUser, void* pchKey) = 0;
    virtual void SetLobbyMemberData(CSteamID steamIDLobby, void* pchKey, void* pchValue) = 0;
    virtual bool SendLobbyChatMsg(CSteamID steamIDLobby, void* pvMsgBody, int cubMsgBody) = 0;
    virtual int GetLobbyChatEntry(CSteamID steamIDLobby, int iChatID, void* pSteamIDUser, void* pvData, int cubData, void* peChatEntryType) = 0;
    virtual bool RequestLobbyData(CSteamID steamIDLobby) = 0;
    virtual void SetLobbyGameServer(CSteamID steamIDLobby, u32 unGameServerIP, u16 unGameServerPort, CSteamID steamIDGameServer) = 0;
    virtual bool GetLobbyGameServer(CSteamID steamIDLobby, void* punGameServerIP, void* punGameServerPort, void* psteamIDGameServer) = 0;
    virtual bool SetLobbyMemberLimit(CSteamID steamIDLobby, int cMaxMembers) = 0;
    virtual int GetLobbyMemberLimit(CSteamID steamIDLobby) = 0;
    virtual bool SetLobbyType(CSteamID steamIDLobby, LobbyType eLobbyType) = 0;
    virtual bool SetLobbyJoinable(CSteamID steamIDLobby, bool bLobbyJoinable) = 0;
    virtual CSteamID GetLobbyOwner(void* __return, CSteamID steamIDLobby) = 0;
    virtual bool SetLobbyOwner(CSteamID steamIDLobby, CSteamID steamIDNewOwner) = 0;
    virtual bool SetLinkedLobby(CSteamID steamIDLobby, CSteamID steamIDLobbyDependent) = 0;
};

struct ISteamUserStats
{
    virtual bool RequestCurrentStats() = 0;
    virtual bool GetStat_1(void* pchName, void* pData) = 0;
    virtual bool GetStat_2(void* pchName, void* pData) = 0;
    virtual bool SetStat_1(void* pchName, float nData) = 0;
    virtual bool SetStat_2(void* pchName, i32 nData) = 0;
    virtual bool UpdateAvgRateStat(void* pchName, float flCountThisSession, double dSessionLength) = 0;
    virtual bool GetAchievement(void* pchName, void* pbAchieved) = 0;
    virtual bool SetAchievement(void* pchName) = 0;
    virtual bool ClearAchievement(void* pchName) = 0;
    virtual bool GetAchievementAndUnlockTime(void* pchName, void* pbAchieved, void* punUnlockTime) = 0;
    virtual bool StoreStats() = 0;
    virtual int GetAchievementIcon(void* pchName) = 0;
    virtual void* GetAchievementDisplayAttribute(void* pchName, void* pchKey) = 0;
    virtual bool IndicateAchievementProgress(void* pchName, u32 nCurProgress, u32 nMaxProgress) = 0;
    virtual u32 GetNumAchievements() = 0;
    virtual void* GetAchievementName(u32 iAchievement) = 0;
    virtual SteamAPICall RequestUserStats(CSteamID steamIDUser) = 0;
    virtual bool GetUserStat_1(CSteamID steamIDUser, void* pchName, void* pData) = 0;
    virtual bool GetUserStat_2(CSteamID steamIDUser, void* pchName, void* pData) = 0;
    virtual bool GetUserAchievement(CSteamID steamIDUser, void* pchName, void* pbAchieved) = 0;
    virtual bool GetUserAchievementAndUnlockTime(CSteamID steamIDUser, void* pchName, void* pbAchieved, void* punUnlockTime) = 0;
    virtual bool ResetAllStats(u8 bAchievementsToo) = 0;
    virtual SteamAPICall FindOrCreateLeaderboard(void* pchLeaderboardName, LeaderboardSortMethod eLeaderboardSortMethod, LeaderboardDisplayType eLeaderboardDisplayType) = 0;
    virtual SteamAPICall FindLeaderboard(void* pchLeaderboardName) = 0;
    virtual void* GetLeaderboardName(SteamLeaderboard hSteamLeaderboard) = 0;
    virtual int GetLeaderboardEntryCount(SteamLeaderboard hSteamLeaderboard) = 0;
    virtual LeaderboardSortMethod GetLeaderboardSortMethod(SteamLeaderboard hSteamLeaderboard) = 0;
    virtual LeaderboardDisplayType GetLeaderboardDisplayType(SteamLeaderboard hSteamLeaderboard) = 0;
    virtual SteamAPICall DownloadLeaderboardEntries(SteamLeaderboard hSteamLeaderboard, LeaderboardDataRequest eLeaderboardDataRequest, int nRangeStart, int nRangeEnd) = 0;
    virtual SteamAPICall DownloadLeaderboardEntriesForUsers(SteamLeaderboard hSteamLeaderboard, void* prgUsers, int cUsers) = 0;
    virtual bool GetDownloadedLeaderboardEntry(SteamLeaderboardEntries hSteamLeaderboardEntries, int index, void* pLeaderboardEntry, void* pDetails, int cDetailsMax) = 0;
    virtual SteamAPICall UploadLeaderboardScore(SteamLeaderboard hSteamLeaderboard, LeaderboardUploadScoreMethod eLeaderboardUploadScoreMethod, i32 nScore, void* pScoreDetails, int cScoreDetailsCount) = 0;
    virtual SteamAPICall AttachLeaderboardUGC(SteamLeaderboard hSteamLeaderboard, UGCHandle hUGC) = 0;
    virtual SteamAPICall GetNumberOfCurrentPlayers() = 0;
    virtual SteamAPICall RequestGlobalAchievementPercentages() = 0;
    virtual int GetMostAchievedAchievementInfo(void* pchName, u32 unNameBufLen, void* pflPercent, void* pbAchieved) = 0;
    virtual int GetNextMostAchievedAchievementInfo(int iIteratorPrevious, void* pchName, u32 unNameBufLen, void* pflPercent, void* pbAchieved) = 0;
    virtual bool GetAchievementAchievedPercent(void* pchName, void* pflPercent) = 0;
    virtual SteamAPICall RequestGlobalStats(int nHistoryDays) = 0;
    virtual bool GetGlobalStat_1(void* pchStatName, void* pData) = 0;
    virtual bool GetGlobalStat_2(void* pchStatName, void* pData) = 0;
    virtual i32 GetGlobalStatHistory_1(void* pchStateName, void* pData, u32 cubData) = 0;
    virtual i32 GetGlobalStatHistory_2(void* pchStatName, void* pData, u32 cubData) = 0;
};

struct ISteamApps
{
    virtual bool BIsSubscribed() = 0;
    virtual bool BIsLowViolence() = 0;
    virtual bool BIsCybercafe() = 0;
    virtual bool BIsVACBanned() = 0;
    virtual void* GetCurrentGameLanguage() = 0;
    virtual void* GetAvailableGameLanguages() = 0;
    virtual bool BIsSubscribedApp(AppId appID) = 0;
    virtual bool BIsDlcInstalled(AppId appID) = 0;
    virtual u32 GetEarliestPurchaseUnixTime(AppId appID) = 0;
    virtual bool BIsSubscribedFromFreeWeekend() = 0;
    virtual int GetDLCCount() = 0;
    virtual bool BGetDLCDataByIndex(int iDLC, void* pAppID, void* pbAvailable, void* pchName, int cchNameBufferSize) = 0;
    virtual void InstallDLC(AppId nAppID) = 0;
    virtual void UninstallDLC(AppId nAppID) = 0;
    virtual void RequestAppProofOfPurchaseKey(AppId nAppID) = 0;
    virtual bool GetCurrentBetaName(void* pchName, int cchNameBufferSize) = 0;
    virtual bool MarkContentCorrupt(bool bMissingFilesOnly) = 0;
    virtual u32 GetInstalledDepots(AppId appID, void* pvecDepots, u32 cMaxDepots) = 0;
    virtual u32 GetAppInstallDir(AppId appID, void* pchFolder, u32 cchFolderBufferSize) = 0;
    virtual bool BIsAppInstalled(AppId appID) = 0;
    virtual CSteamID GetAppOwner(void* __return) = 0;
    virtual void* GetLaunchQueryParam(void* pchKey) = 0;
    virtual bool GetDlcDownloadProgress(AppId nAppID, void* punBytesDownloaded, void* punBytesTotal) = 0;
    virtual int GetAppBuildId() = 0;
    virtual void RequestAllProofOfPurchaseKeys() = 0;
    virtual SteamAPICall GetFileDetails(void* pszFileName) = 0;
};

struct ISteamNetworking
{
    virtual bool SendP2PPacket(CSteamID steamIDRemote, void* pubData, u32 cubData, P2PSend eP2PSendType, i32 nChannel) = 0;
    virtual bool IsP2PPacketAvailable(void* pcubMsgSize, i32 nChannel) = 0;
    virtual bool ReadP2PPacket(void* pubDest, u32 cubDest, void* pcubMsgSize, void* psteamIDRemote, i32 nChannel) = 0;
    virtual bool AcceptP2PSessionWithUser(CSteamID steamIDRemote) = 0;
    virtual bool CloseP2PSessionWithUser(CSteamID steamIDRemote) = 0;
    virtual bool CloseP2PChannelWithUser(CSteamID steamIDRemote, i32 nChannel) = 0;
    virtual bool GetP2PSessionState(CSteamID steamIDRemote, void* pConnectionState) = 0;
    virtual bool AllowP2PPacketRelay(bool bAllow) = 0;
    virtual SNetListenSocket CreateListenSocket(int nVirtualP2PPort, u32 nIP, u16 nPort, bool bAllowUseOfPacketRelay) = 0;
    virtual SNetSocket CreateP2PConnectionSocket(CSteamID steamIDTarget, int nVirtualPort, int nTimeoutSec, bool bAllowUseOfPacketRelay) = 0;
    virtual SNetSocket CreateConnectionSocket(u32 nIP, u16 nPort, int nTimeoutSec) = 0;
    virtual bool DestroySocket(SNetSocket hSocket, bool bNotifyRemoteEnd) = 0;
    virtual bool DestroyListenSocket(SNetListenSocket hSocket, bool bNotifyRemoteEnd) = 0;
    virtual bool SendDataOnSocket(SNetSocket hSocket, void* pubData, u32 cubData, bool bReliable) = 0;
    virtual bool IsDataAvailableOnSocket(SNetSocket hSocket, void* pcubMsgSize) = 0;
    virtual bool RetrieveDataFromSocket(SNetSocket hSocket, void* pubDest, u32 cubDest, void* pcubMsgSize) = 0;
    virtual bool IsDataAvailable(SNetListenSocket hListenSocket, void* pcubMsgSize, void* phSocket) = 0;
    virtual bool RetrieveData(SNetListenSocket hListenSocket, void* pubDest, u32 cubDest, void* pcubMsgSize, void* phSocket) = 0;
    virtual bool GetSocketInfo(SNetSocket hSocket, void* pSteamIDRemote, void* peSocketStatus, void* punIPRemote, void* punPortRemote) = 0;
    virtual bool GetListenSocketInfo(SNetListenSocket hListenSocket, void* pnIP, void* pnPort) = 0;
    virtual SNetSocketConnectionType GetSocketConnectionType(SNetSocket hSocket) = 0;
    virtual int GetMaxPacketSize(SNetSocket hSocket) = 0;
};

struct ISteamRemoteStorage
{
    virtual bool FileWrite(void* pchFile, void* pvData, i32 cubData) = 0;
    virtual i32 FileRead(void* pchFile, void* pvData, i32 cubDataToRead) = 0;
    virtual SteamAPICall FileWriteAsync(void* pchFile, void* pvData, u32 cubData) = 0;
    virtual SteamAPICall FileReadAsync(void* pchFile, u32 nOffset, u32 cubToRead) = 0;
    virtual bool FileReadAsyncComplete(SteamAPICall hReadCall, void* pvBuffer, u32 cubToRead) = 0;
    virtual bool FileForget(void* pchFile) = 0;
    virtual bool FileDelete(void* pchFile) = 0;
    virtual SteamAPICall FileShare(void* pchFile) = 0;
    virtual bool SetSyncPlatforms(void* pchFile, RemoteStoragePlatform eRemoteStoragePlatform) = 0;
    virtual UGCFileWriteStreamHandle FileWriteStreamOpen(void* pchFile) = 0;
    virtual bool FileWriteStreamWriteChunk(UGCFileWriteStreamHandle writeHandle, void* pvData, i32 cubData) = 0;
    virtual bool FileWriteStreamClose(UGCFileWriteStreamHandle writeHandle) = 0;
    virtual bool FileWriteStreamCancel(UGCFileWriteStreamHandle writeHandle) = 0;
    virtual bool FileExists(void* pchFile) = 0;
    virtual bool FilePersisted(void* pchFile) = 0;
    virtual i32 GetFileSize(void* pchFile) = 0;
    virtual i64 GetFileTimestamp(void* pchFile) = 0;
    virtual RemoteStoragePlatform GetSyncPlatforms(void* pchFile) = 0;
    virtual i32 GetFileCount() = 0;
    virtual void* GetFileNameAndSize(i32 iFile, void* pnFileSizeInBytes) = 0;
    virtual bool GetQuota(void* pnTotalBytes, void* puAvailableBytes) = 0;
    virtual bool IsCloudEnabledForAccount() = 0;
    virtual bool IsCloudEnabledForApp() = 0;
    virtual void SetCloudEnabledForApp(bool bEnabled) = 0;
    virtual SteamAPICall UGCDownload(UGCHandle hContent, u32 unPriority) = 0;
    virtual bool GetUGCDownloadProgress(UGCHandle hContent, void* pnBytesDownloaded, void* pnBytesExpected) = 0;
    virtual bool GetUGCDetails(UGCHandle hContent, void* pnAppID, void* ppchName, void* pnFileSizeInBytes, void* pSteamIDOwner) = 0;
    virtual i32 UGCRead(UGCHandle hContent, void* pvData, i32 cubDataToRead, u32 cOffset, UGCReadAction eAction) = 0;
    virtual i32 GetCachedUGCCount() = 0;
    virtual UGCHandle GetCachedUGCHandle(i32 iCachedContent) = 0;
    virtual SteamAPICall PublishWorkshopFile(void* pchFile, void* pchPreviewFile, AppId nConsumerAppId, void* pchTitle, void* pchDescription, RemoteStoragePublishedFileVisibility eVisibility, void* pTags, WorkshopFileType eWorkshopFileType) = 0;
    virtual PublishedFileUpdateHandle CreatePublishedFileUpdateRequest(PublishedFileId unPublishedFileId) = 0;
    virtual bool UpdatePublishedFileFile(PublishedFileUpdateHandle updateHandle, void* pchFile) = 0;
    virtual bool UpdatePublishedFilePreviewFile(PublishedFileUpdateHandle updateHandle, void* pchPreviewFile) = 0;
    virtual bool UpdatePublishedFileTitle(PublishedFileUpdateHandle updateHandle, void* pchTitle) = 0;
    virtual bool UpdatePublishedFileDescription(PublishedFileUpdateHandle updateHandle, void* pchDescription) = 0;
    virtual bool UpdatePublishedFileVisibility(PublishedFileUpdateHandle updateHandle, RemoteStoragePublishedFileVisibility eVisibility) = 0;
    virtual bool UpdatePublishedFileTags(PublishedFileUpdateHandle updateHandle, void* pTags) = 0;
    virtual SteamAPICall CommitPublishedFileUpdate(PublishedFileUpdateHandle updateHandle) = 0;
    virtual SteamAPICall GetPublishedFileDetails(PublishedFileId unPublishedFileId, u32 unMaxSecondsOld) = 0;
    virtual SteamAPICall DeletePublishedFile(PublishedFileId unPublishedFileId) = 0;
    virtual SteamAPICall EnumerateUserPublishedFiles(u32 unStartIndex) = 0;
    virtual SteamAPICall SubscribePublishedFile(PublishedFileId unPublishedFileId) = 0;
    virtual SteamAPICall EnumerateUserSubscribedFiles(u32 unStartIndex) = 0;
    virtual SteamAPICall UnsubscribePublishedFile(PublishedFileId unPublishedFileId) = 0;
    virtual bool UpdatePublishedFileSetChangeDescription(PublishedFileUpdateHandle updateHandle, void* pchChangeDescription) = 0;
    virtual SteamAPICall GetPublishedItemVoteDetails(PublishedFileId unPublishedFileId) = 0;
    virtual SteamAPICall UpdateUserPublishedItemVote(PublishedFileId unPublishedFileId, bool bVoteUp) = 0;
    virtual SteamAPICall GetUserPublishedItemVoteDetails(PublishedFileId unPublishedFileId) = 0;
    virtual SteamAPICall EnumerateUserSharedWorkshopFiles(CSteamID steamId, u32 unStartIndex, void* pRequiredTags, void* pExcludedTags) = 0;
    virtual SteamAPICall PublishVideo(WorkshopVideoProvider eVideoProvider, void* pchVideoAccount, void* pchVideoIdentifier, void* pchPreviewFile, AppId nConsumerAppId, void* pchTitle, void* pchDescription, RemoteStoragePublishedFileVisibility eVisibility, void* pTags) = 0;
    virtual SteamAPICall SetUserPublishedFileAction(PublishedFileId unPublishedFileId, WorkshopFileAction eAction) = 0;
    virtual SteamAPICall EnumeratePublishedFilesByUserAction(WorkshopFileAction eAction, u32 unStartIndex) = 0;
    virtual SteamAPICall EnumeratePublishedWorkshopFiles(WorkshopEnumerationType eEnumerationType, u32 unStartIndex, u32 unCount, u32 unDays, void* pTags, void* pUserTags) = 0;
    virtual SteamAPICall UGCDownloadToLocation(UGCHandle hContent, void* pchLocation, u32 unPriority) = 0;
};

struct ISteamController
{
    virtual bool Init() = 0;
    virtual bool Shutdown() = 0;
    virtual void RunFrame() = 0;
    virtual int GetConnectedControllers(void* handlesOut) = 0;
    virtual bool ShowBindingPanel(ControllerHandle controllerHandle) = 0;
    virtual ControllerActionSetHandle GetActionSetHandle(void* pszActionSetName) = 0;
    virtual void ActivateActionSet(ControllerHandle controllerHandle, ControllerActionSetHandle actionSetHandle) = 0;
    virtual ControllerActionSetHandle GetCurrentActionSet(ControllerHandle controllerHandle) = 0;
    virtual void ActivateActionSetLayer(ControllerHandle controllerHandle, ControllerActionSetHandle actionSetLayerHandle) = 0;
    virtual void DeactivateActionSetLayer(ControllerHandle controllerHandle, ControllerActionSetHandle actionSetLayerHandle) = 0;
    virtual void DeactivateAllActionSetLayers(ControllerHandle controllerHandle) = 0;
    virtual int GetActiveActionSetLayers(ControllerHandle controllerHandle, void* handlesOut) = 0;
    virtual ControllerDigitalActionHandle GetDigitalActionHandle(void* pszActionName) = 0;
    virtual ControllerDigitalActionData GetDigitalActionData(void* __return, ControllerHandle controllerHandle, ControllerDigitalActionHandle digitalActionHandle) = 0;
    virtual int GetDigitalActionOrigins(ControllerHandle controllerHandle, ControllerActionSetHandle actionSetHandle, ControllerDigitalActionHandle digitalActionHandle, void* originsOut) = 0;
    virtual ControllerAnalogActionHandle GetAnalogActionHandle(void* pszActionName) = 0;
    virtual ControllerAnalogActionData GetAnalogActionData(void* __return, ControllerHandle controllerHandle, ControllerAnalogActionHandle analogActionHandle) = 0;
    virtual int GetAnalogActionOrigins(ControllerHandle controllerHandle, ControllerActionSetHandle actionSetHandle, ControllerAnalogActionHandle analogActionHandle, void* originsOut) = 0;
    virtual void StopAnalogActionMomentum(ControllerHandle controllerHandle, ControllerAnalogActionHandle eAction) = 0;
    virtual void TriggerHapticPulse(ControllerHandle controllerHandle, SteamControllerPad eTargetPad, u16 usDurationMicroSec) = 0;
    virtual void TriggerRepeatedHapticPulse(ControllerHandle controllerHandle, SteamControllerPad eTargetPad, u16 usDurationMicroSec, u16 usOffMicroSec, u16 unRepeat, u32 nFlags) = 0;
    virtual void TriggerVibration(ControllerHandle controllerHandle, u16 usLeftSpeed, u16 usRightSpeed) = 0;
    virtual void SetLEDColor(ControllerHandle controllerHandle, u8 nColorR, u8 nColorG, u8 nColorB, u32 nFlags) = 0;
    virtual int GetGamepadIndexForController(ControllerHandle ulControllerHandle) = 0;
    virtual ControllerHandle GetControllerForGamepadIndex(int nIndex) = 0;
    virtual ControllerMotionData GetMotionData(void* __return, ControllerHandle controllerHandle) = 0;
    virtual bool ShowDigitalActionOrigins(ControllerHandle controllerHandle, ControllerDigitalActionHandle digitalActionHandle, float flScale, float flXPosition, float flYPosition) = 0;
    virtual bool ShowAnalogActionOrigins(ControllerHandle controllerHandle, ControllerAnalogActionHandle analogActionHandle, float flScale, float flXPosition, float flYPosition) = 0;
    virtual void* GetStringForActionOrigin(ControllerActionOrigin eOrigin) = 0;
    virtual void* GetGlyphForActionOrigin(ControllerActionOrigin eOrigin) = 0;
    virtual SteamInputType GetInputTypeForHandle(ControllerHandle controllerHandle) = 0;
};

/*Start of interfaces not implemented by the vanilla sw_api.dll*/

struct ISteamMatchmakingServers
{
    void* Vtable; //Not implemented by the GOG version of sw_api.dll
};

struct ISteamScreenshots
{
    void* Vtable; //Not implemented by the GOG version of sw_api.dll
};

struct ISteamHTTP
{
    void* Vtable; //Not implemented by the GOG version of sw_api.dll
};

struct ISteamUGC
{
    void* Vtable; //Not implemented by the GOG version of sw_api.dll
};

struct ISteamAppList
{
    void* Vtable; //Not implemented by the GOG version of sw_api.dll
};

struct ISteamMusic
{
    void* Vtable; //Not implemented by the GOG version of sw_api.dll
};

struct ISteamMusicRemote
{
    void* Vtable; //Not implemented by the GOG version of sw_api.dll
};

struct ISteamHTMLSurface
{
    void* Vtable; //Not implemented by the GOG version of sw_api.dll
};

struct ISteamInventory
{
    void* Vtable; //Not implemented by the GOG version of sw_api.dll
};

struct ISteamVideo
{
    void* Vtable; //Not implemented by the GOG version of sw_api.dll
};

struct ISteamParentalSettings
{
    void* Vtable; //Not implemented by the GOG version of sw_api.dll
};

struct ISteamGameServer
{
    void* Vtable; //Not implemented by the GOG version of sw_api.dll
};

struct ISteamGameServerStats
{
    void* Vtable; //Not implemented by the GOG version of sw_api.dll
};

struct ISteamUnifiedMessages
{
    void* Vtable; //Not implemented by the GOG version of sw_api.dll
};

/*End of interfaces not implemented by the vanilla sw_api.dll*/

struct FriendGameInfo
{
    CGameID m_gameID;
    u32 m_unGameIP;
    u16 m_usGamePort;
    u16 m_usQueryPort;
    CSteamID m_steamIDLobby;
};

struct LeaderboardEntry
{
    CSteamID m_steamIDUser;
    i32 m_nGlobalRank;
    i32 m_nScore;
    i32 m_cDetails;
    UGCHandle m_hUGC;
};

struct P2PSessionState
{
    u8 m_bConnectionActive;
    u8 m_bConnecting;
    u8 m_eP2PSessionError;
    u8 m_bUsingRelay;
    i32 m_nBytesQueuedForSend;
    i32 m_nPacketsQueuedForSend;
    u32 m_nRemoteIP;
    u16 m_nRemotePort;
};

struct SteamParamStringArray
{
    char** m_ppStrings;
    i32 m_nNumStrings;
};

struct ControllerDigitalActionData
{
    bool bState;
    bool bActive;
};

struct ControllerAnalogActionData
{
    ControllerSourceMode eMode;
    f32 x;
    f32 y;
    bool bActive;
};

struct ControllerMotionData
{
    f32 rotQuatX;
    f32 rotQuatY;
    f32 rotQuatZ;
    f32 rotQuatW;
    f32 postAccelX;
    f32 postAccelY;
    f32 postAccelZ;
    f32 rotVelX;
    f32 rotVelY;
    f32 rotVelZ;
};