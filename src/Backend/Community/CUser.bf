using RfgNetworking.API;

namespace RfgNetworking.Backend.Community
{
    public struct CUser : ISteamUser
    {
        public void ModuleInit() mut
        {
            Vtable = new ISteamUser.VTable();
            Vtable.SW_CCSys_GetU = => SW_CCSys_GetU;
            Vtable.BLoggedOn = => BLoggedOn;
            Vtable.GetSteamID = => GetSteamID;
            Vtable.InitiateGameConnection = => InitiateGameConnection;
            Vtable.TerminateGameConnection = => TerminateGameConnection;
            Vtable.TrackAppUsageEvent = => TrackAppUsageEvent;
            Vtable.GetUserDataFolder = => GetUserDataFolder;
            Vtable.StartVoiceRecording = => StartVoiceRecording;
            Vtable.StopVoiceRecording = => StopVoiceRecording;
            Vtable.GetAvailableVoice = => GetAvailableVoice;
            Vtable.GetVoice = => GetVoice;
            Vtable.DecompressVoice = => DecompressVoice;
            Vtable.GetVoiceOptimalSampleRate = => GetVoiceOptimalSampleRate;
            Vtable.GetAuthSessionTicket = => GetAuthSessionTicket;
            Vtable.BeginAuthSession = => BeginAuthSession;
            Vtable.EndAuthSession = => EndAuthSession;
            Vtable.CancelAuthTicket = => CancelAuthTicket;
            Vtable.UserHasLicenseForApp = => UserHasLicenseForApp;
            Vtable.BIsBehindNAT = => BIsBehindNAT;
            Vtable.AdvertiseGame = => AdvertiseGame;
            Vtable.RequestEncryptedAppTicket = => RequestEncryptedAppTicket;
            Vtable.GetEncryptedAppTicket = => GetEncryptedAppTicket;
            Vtable.GetGameBadgeLevel = => GetGameBadgeLevel;
            Vtable.GetPlayerSteamLevel = => GetPlayerSteamLevel;
            Vtable.RequestStoreAuthURL = => RequestStoreAuthURL;
            Vtable.BIsPhoneVerified = => BIsPhoneVerified;
            Vtable.BIsTwoFactorEnabled = => BIsTwoFactorEnabled;
            Vtable.BIsPhoneIdentifying = => BIsPhoneIdentifying;
            Vtable.BIsPhoneRequiringVerification = => BIsPhoneRequiringVerification;
        }

        public void ModuleShutdown()
        {
            delete Vtable;
        }

        public HSteamUser SW_CCSys_GetU()
        {
            return (HSteamUser)1;
        }

        public bool BLoggedOn()
        {
            return true;
        }

        public CSteamID GetSteamID(CSteamID* __return)
        {
            return 0;
        }

        public int32 InitiateGameConnection(void* pAuthBlob, int32 cbMaxAuthBlob, CSteamID steamIDGameServer, uint32 unIPServer, uint16 usPortServer, bool bSecure)
        {
            return 0;
        }

        public void TerminateGameConnection(uint32 unIPServer, uint16 usPortServer)
        {

        }

        public void TrackAppUsageEvent(CGameID gameID, int32 eAppUsageEvent, char8* pchExtraInfo)
        {

        }

        public bool GetUserDataFolder(char8* pchBuffer, int32 cubBuffer)
        {
            return false;
        }

        public void StartVoiceRecording()
        {

        }

        public void StopVoiceRecording()
        {

        }

        public VoiceResult GetAvailableVoice(uint32* pcbCompressed, uint32* pcbUncompressed_Deprecated, uint32 nUncompressedVoiceDesiredSampleRate_Deprecated)
        {
            return 0;
        }

        public VoiceResult GetVoice(bool bWantCompressed, void* pDestBuffer, uint32 cbDestBufferSize, uint32* nBytesWritten, bool bWantUncompressed_Deprecated, void* pUncompressedDestBuffer_Deprecated, uint32 cbUncompressedDestBufferSize_Deprecated, uint32* nUncompressBytesWritten_Deprecated, uint32 nUncompressedVoiceDesiredSampleRate_Deprecated)
        {
            return 0;
        }

        public VoiceResult DecompressVoice(void* pCompressed, uint32 cbCompressed, void* pDestBuffer, uint32 cbDestBufferSize, uint32* nBytesWritten, uint32 nDesiredSampleRate)
        {
            return 0;
        }

        public uint32 GetVoiceOptimalSampleRate()
        {
            return 24000;
        }

        public HAuthTicket GetAuthSessionTicket(void* pTicket, int32 cbMaxTicket, uint32* pcbTicket)
        {
            return 0;
        }

        public BeginAuthSessionResult BeginAuthSession(void* pAuthTicket, int32 cbAuthTicket, CSteamID steamID)
        {
            return 0;
        }

        public void EndAuthSession(CSteamID steamID)
        {

        }

        public void CancelAuthTicket(HAuthTicket hAuthTicket)
        {

        }

        public UserHasLicenseForAppResult UserHasLicenseForApp(CSteamID steamID, AppId appId)
        {
            return .HasLicense;
        }

        public bool BIsBehindNAT()
        {
            return false;
        }

        public void AdvertiseGame(CSteamID steamIDGameServer, uint32 unIPServer, uint16 usPortServer)
        {

        }

        public SteamAPICall RequestEncryptedAppTicket(void* pDataToInclude, int32 cbDataToInclude)
        {
            return 0;
        }

        public bool GetEncryptedAppTicket(void* pTicket, int32 cbMaxTicket, uint32* pcbTicket)
        {
            return false;
        }

        public int GetGameBadgeLevel(int32 nSeries, bool bFoil)
        {
            return 0;
        }

        public int GetPlayerSteamLevel()
        {
            return 0;
        }

        public SteamAPICall RequestStoreAuthURL(char8* pchRedirectURL)
        {
            return 0;
        }

        public bool BIsPhoneVerified()
        {
            return false;
        }

        public bool BIsTwoFactorEnabled()
        {
            return false;
        }

        public bool BIsPhoneIdentifying()
        {
            return false;
        }

        public bool BIsPhoneRequiringVerification()
        {
            return false;
        }
    }    
}