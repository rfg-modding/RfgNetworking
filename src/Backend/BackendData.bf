using System;
using RfgNetworking.API;
using RfgNetworking.Misc;
using Bon;

namespace RfgNetworking.Backend
{
    [CRepr, ReflectAll]
    enum CallbackType : i32
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
    }

    [CRepr, ReflectAll]
    public struct ValidateAuthTicketResponse
    {
        public CSteamID SteamID;
        public AuthSessionResponse AuthSessionResponse;
        public CSteamID OwnerSteamID;
    }

    [CRepr, ReflectAll]
    public struct GetAuthSessionTicketResponse
    {
        public u32 AuthTicket;
        public BackendResult Result;
    }

    [CRepr, ReflectAll]
    public struct GameLobbyJoinRequested
    {
        public CSteamID SteamIDLobby;
        public CSteamID SteamIDFriend;
    }

    [CRepr, ReflectAll]
    public struct LobbyEnter
    {
        public u64 SteamIDLobby; //TODO: Should this be a CSteamID?
        public u32 ChatPermissions;
        public bool Blocked; //TODO: Is this really a bool, or a u8? Naming scheme in rfg.exe indicates its a bool, but the debugger shows it being set to some strange values like 13 (would've expected 255 for true and 0 for false)
        public u32 ChatRoomEnterResponse; //Likely an enum
    }

    [CRepr, ReflectAll]
    public struct LobbyMatchList
    {
        public u32 NumLobbiesMatching;
    }

    [CRepr, ReflectAll]
    public struct LobbyCreated
    {
        public BackendResult Result;
        public u64 SteamIDLobby; //TODO: Should this be a CSteamID?
    }

    [CRepr, ReflectAll]
    public struct LobbyDataUpdate
    {
        public u64 SteamIDLobby;
        public u64 SteamIDMember;
        public bool Success;
    }

    [CRepr, ReflectAll]
    public struct LobbyChatUpdate
    {
        public u64 SteamIDLobby;
        public u64 SteamIDUserChanged;
        public u64 SteamIDMakingChange;
        public u64 ChatMemberStateChange;
    }

    [CRepr, ReflectAll]
    public struct UserStatsReceived
    {
        public u64 GameID;
        public BackendResult Result;
        public CSteamID SteamIDUser;
    }

    [CRepr, ReflectAll]
    public struct UserStatsStored
    {
        public u64 GameID;
        public BackendResult Result;
    }

    [CRepr, ReflectAll]
    public struct UserAchievementStored
    {
        public u64 GameID;
        public bool GroupAchievement;
        public char8[128] AchievementName;
        public u32 CurProgress;
        public u32 MaxProgress;
    }
    
    [CRepr, ReflectAll]
    public struct P2PSessionRequest
    {
        public CSteamID SteamIDRemote;
    }

    [CRepr, ReflectAll]
    public enum AuthSessionResponse : u32
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
    }

    [CRepr, ReflectAll]
    public enum BackendResult : u32
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
    }

    //Base class for callbacks and call results. Used by the DLL to communicate events/data to the game asynchronously.
    //Callbacks can send data to multiple listeners
    //Call results only send them to one listener
    [CRepr, ReflectAll]
    public struct CCallbackBase
    {
    	public CCallbackBase.VTable* Vfptr;

        //So far I've only seen these two fields use with CCallResult<>
    	public u8 CallbackFlags;
    	public CallbackType CallResultType;

        [CRepr]
        public struct VTable
        {
            public function void(CCallbackBase* this, void* param, u8 param1, u64 param2) Run;
            public function void(CCallbackBase* this, void* param) Run2;
            public function i32(CCallbackBase* this) GetCallbackSizeBytes;
        }
    }

    [CRepr, ReflectAll]
    public struct CCallResult<T, U> : CCallbackBase
    {
        public SteamAPICall ApiCall; //Unique handle for an API call. The vanilla DLL mimics the steamworks API so that's why we use the SteamAPICall type
        public T* Obj;
        public function void(T* this, U* data, bool bIOFailure) Func;
    }

    [CRepr, ReflectAll]
    public struct CCallback<T, U, V> : CCallbackBase where V : const int
    {
        public T* Obj;
        public function void(T* this, U* data) Func;
    }

    [CRepr, ReflectAll]
    public struct GameLinkInternet
    {
        public GameLinkInternet.VTable* Vtable;
        public GameLinkState State;
        public GameLinkError Error;
        public i32 PlatformErrorCode;
        public bool GameplayRunning;
        public f32 VoicechatVolume;
        //TODO: Define the rest of the members + the vtable funcs

        [CRepr]
        public struct VTable
        {

        }
    }

    [CRepr, ReflectAll]
    public enum GameLinkState
    {

    }

    [CRepr, ReflectAll]
    public enum GameLinkError
    {

    }

    struct CallbackLogger<T> : CCallbackBase where T : struct
    {
        public CallbackType CallbackType;
        public CCallbackBase* Original;
        private CCallbackBase.VTable* _originalVtable = null;
        private CCallbackBase.VTable _loggedVtable = .();

        public this(CCallbackBase* original, CallbackType callbackType)
        {
            CallbackType = callbackType;
            Original = original;

            //Point the struct to a new vtable that logs any calls then passes them onto the real vtable
            _originalVtable = Original.Vfptr;
            _loggedVtable.Run = => Run;
            _loggedVtable.Run2 = => Run2;
            _loggedVtable.GetCallbackSizeBytes = => GetCallbackSizeBytes;

            base.Vfptr = &_loggedVtable;
            base.CallResultType = original.CallResultType;
            base.CallbackFlags = original.CallbackFlags;

            Original.Vfptr = &_loggedVtable;
        }

        public void Cleanup()
        {
            Original.Vfptr = _originalVtable;
        }

        public void Run(void* param, u8 param1, u64 param2)
        {
            //Convert param and its fields to string and log it
            String dataFields = scope .();
            gBonEnv.serializeFlags |= .Verbose;
            Bon.Serialize<T>(*(T*)param, dataFields);

            String logString = scope $"[CALLBACK] {CallbackType.ToString(.. scope .())}.Run({typeof(T).GetName(.. scope .())}* param:\n{dataFields},\nuint8 param1: {param1}, uint64 param2: {param2})";
            logString.Replace("{", "{{"); //Have to escape these so StreamWriter doesn't think they're formatting parameters
            logString.Replace("}", "}}");
            Logger.WriteLine(logString);

            //Call original vtable func
            _originalVtable.Run(Original, param, param1, param2);

            Logger.WriteLine(scope $"[CALLBACK_END$$$] {CallbackType.ToString(.. scope .())}.Run()\n");
        }

        public void Run2(void* param)
        {
            //Convert param and its fields to string and log it
            String dataFields = scope .();
            gBonEnv.serializeFlags |= .Verbose;
            Bon.Serialize<T>(*(T*)param, dataFields);

            String logString = scope $"[CALLBACK] {CallbackType.ToString(.. scope .())}.Run2({typeof(T).GetName(.. scope .())}* param:\n{dataFields})";
            logString.Replace("{", "{{");
            logString.Replace("}", "}}");
            Logger.WriteLine(logString);

            //Call original vtable func
            _originalVtable.Run2(Original, param);

            Logger.WriteLine(scope $"[CALLBACK_END$$$] {CallbackType.ToString(.. scope .())}.Run2()\n");
        }

        public i32 GetCallbackSizeBytes()
        {
            i32 result = _originalVtable.GetCallbackSizeBytes(Original);
            Logger.WriteLine(scope $"[CALLBACK] {CallbackType.ToString(.. scope .())}.GetCallbackSizeBytes() -> {result}");
            return result;
        }
    }

    struct CallResultLogger <T> : CCallbackBase where T : struct
    {
        public u32 APICallLower;
        public u32 APICallUpper;
        public CCallbackBase* Original;
        private CCallbackBase.VTable* _originalVtable = null;
        private CCallbackBase.VTable _loggedVtable = .();

        public this(CCallbackBase* original, u32 apiCallLower, u32 apiCallUpper)
        {
            APICallLower = apiCallLower;
            APICallUpper = apiCallUpper;
            Original = original;

            //Point the struct to a new vtable that logs any calls then passes them onto the real vtable
            _originalVtable = Original.Vfptr;
            _loggedVtable.Run = => Run;
            _loggedVtable.Run2 = => Run2;
            _loggedVtable.GetCallbackSizeBytes = => GetCallbackSizeBytes;

            base.Vfptr = &_loggedVtable;
            base.CallResultType = original.CallResultType;
            base.CallbackFlags = original.CallbackFlags;

            Original.Vfptr = &_loggedVtable;
        }

        public void Cleanup()
        {
            Original.Vfptr = _originalVtable;
        }

        public void Run(void* param, u8 param1, u64 param2)
        {
            //Convert param and its fields to string and log it
            String dataFields = scope .();
            gBonEnv.serializeFlags |= .Verbose;
            Bon.Serialize<T>(*(T*)param, dataFields);

            String logString = scope $"[CALL_RESULT] {CallResultType.ToString(.. scope .())}.Run({typeof(T).GetName(.. scope .())}* param:\n{dataFields},\nuint8 param1: {param1}, uint64 param2: {param2})";
            logString.Replace("{", "{{"); //Have to escape these so StreamWriter doesn't think they're formatting parameters
            logString.Replace("}", "}}");
            Logger.WriteLine(logString);

            //Call original vtable func
            _originalVtable.Run(Original, param, param1, param2);

            Logger.WriteLine(scope $"[CALL_RESULT_END$$$] {CallResultType.ToString(.. scope .())}.Run()\n");
        }

        public void Run2(void* param)
        {
            //Convert param and its fields to string and log it
            String dataFields = scope .();
            gBonEnv.serializeFlags |= .Verbose;
            Bon.Serialize<T>(*(T*)param, dataFields);

            String logString = scope $"[CALL_RESULT] {CallResultType.ToString(.. scope .())}.Run2({typeof(T).GetName(.. scope .())}* param:\n{dataFields})";
            logString.Replace("{", "{{");
            logString.Replace("}", "}}");
            Logger.WriteLine(logString);

            //Call original vtable func
            _originalVtable.Run2(Original, param);

            Logger.WriteLine(scope $"[CALL_RESULT_END$$$] {CallResultType.ToString(.. scope .())}.Run2()\n");
        }

        public i32 GetCallbackSizeBytes()
        {
            i32 result = _originalVtable.GetCallbackSizeBytes(Original);
            Logger.WriteLine(scope $"[CALL_RESULT] {base.CallResultType.ToString(.. scope .())}.GetCallbackSizeBytes() -> {result}");
            return result;
        }
    }
}