using RfgNetworking.API;

namespace RfgNetworking.Backend.Community
{
    public struct CApps : ISteamApps
    {
        public void ModuleInit() mut
        {
            Vtable = new ISteamApps.VTable();
            Vtable.BIsSubscribed = => BIsSubscribed;
            Vtable.BIsLowViolence = => BIsLowViolence;
            Vtable.BIsCybercafe = => BIsCybercafe;
            Vtable.BIsVACBanned = => BIsVACBanned;
            Vtable.GetCurrentGameLanguage = => GetCurrentGameLanguage;
            Vtable.GetAvailableGameLanguages = => GetAvailableGameLanguages;
            Vtable.BIsSubscribedApp = => BIsSubscribedApp;
            Vtable.BIsDlcInstalled = => BIsDlcInstalled;
            Vtable.GetEarliestPurchaseUnixTime = => GetEarliestPurchaseUnixTime;
            Vtable.BIsSubscribedFromFreeWeekend = => BIsSubscribedFromFreeWeekend;
            Vtable.GetDLCCount = => GetDLCCount;
            Vtable.BGetDLCDataByIndex = => BGetDLCDataByIndex;
            Vtable.InstallDLC = => InstallDLC;
            Vtable.UninstallDLC = => UninstallDLC;
            Vtable.RequestAppProofOfPurchaseKey = => RequestAppProofOfPurchaseKey;
            Vtable.GetCurrentBetaName = => GetCurrentBetaName;
            Vtable.MarkContentCorrupt = => MarkContentCorrupt;
            Vtable.GetInstalledDepots = => GetInstalledDepots;
            Vtable.GetAppInstallDir = => GetAppInstallDir;
            Vtable.BIsAppInstalled = => BIsAppInstalled;
            Vtable.GetAppOwner = => GetAppOwner;
            Vtable.GetLaunchQueryParam = => GetLaunchQueryParam;
            Vtable.GetDlcDownloadProgress = => GetDlcDownloadProgress;
            Vtable.GetAppBuildId = => GetAppBuildId;
            Vtable.RequestAllProofOfPurchaseKeys = => RequestAllProofOfPurchaseKeys;
            Vtable.GetFileDetails = => GetFileDetails;
        }

        public void ModuleShutdown()
        {
            delete Vtable;
        }

        public bool BIsSubscribed()
        {
             return false;
        }

        public bool BIsLowViolence()
        {
            return false;
        }

        public bool BIsCybercafe()
        {
            return false;
        }

        public bool BIsVACBanned()
        {
            return false;
        }

        public char8* GetCurrentGameLanguage()
        {
            return "english";
        }

        public char8* GetAvailableGameLanguages()
        {
            return "english";
        }

        public bool BIsSubscribedApp(AppId appID)
        {
            return true;
        }

        public bool BIsDlcInstalled(AppId appID)
        {
            return false;
        }

        public uint32 GetEarliestPurchaseUnixTime(AppId appID)
        {
            return 0;
        }

        public bool BIsSubscribedFromFreeWeekend()
        {
            return false;
        }

        public int GetDLCCount()
        {
            return 0;
        }

        public bool BGetDLCDataByIndex(int iDLC, AppId* pAppID, bool* pbAvailable, char8* pchName, int cchNameBufferSize)
        {
            return false;
        }

        public void InstallDLC(AppId nAppID)
        {

        }

        public void UninstallDLC(AppId nAppID)
        {

        }

        public void RequestAppProofOfPurchaseKey(AppId nAppID)
        {

        }

        public bool GetCurrentBetaName(char8* pchName, int cchNameBufferSize)
        {
            return false;
        }

        public bool MarkContentCorrupt(bool bMissingFilesOnly)
        {
            return false;
        }

        public uint32 GetInstalledDepots(AppId appID, DepotId* pvecDepots, uint32 cMaxDepots)
        {
            return 0;
        }

        public uint32 GetAppInstallDir(AppId appID, char8* pchFolder, uint32 cchFolderBufferSize)
        {
            return 0;
        }

        public bool BIsAppInstalled(AppId appID)
        {
            return false;
        }

        public CSteamID GetAppOwner(CSteamID* __return)
        {
            return 0;
        }

        public char8* GetLaunchQueryParam(char8* pchKey)
        {
            return null;
        }

        public bool GetDlcDownloadProgress(AppId nAppID, uint64* punBytesDownloaded, uint64* punBytesTotal)
        {
            return false;
        }

        public int GetAppBuildId()
        {
            return 0;
        }

        public void RequestAllProofOfPurchaseKeys()
        {

        }

        public SteamAPICall GetFileDetails(char8* pszFileName)
        {
            return 0;
        }
    }    
}