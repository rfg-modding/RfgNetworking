using RfgNetworking.Misc;
using RfgNetworking.API;
using System;

namespace RfgNetworking.Backend.Community
{
    public struct CApps : ISteamApps
    {
        [DebugLog]
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

        [DebugLog]
        public void ModuleShutdown()
        {
            delete Vtable;
        }

        [DebugLog]
        public bool BIsSubscribed()
        {
             return false;
        }

        [DebugLog]
        public bool BIsLowViolence()
        {
            return false;
        }

        [DebugLog]
        public bool BIsCybercafe()
        {
            return false;
        }

        [DebugLog]
        public bool BIsVACBanned()
        {
            return false;
        }

        [DebugLog]
        public char8* GetCurrentGameLanguage()
        {
            return "english";
        }

        [DebugLog]
        public char8* GetAvailableGameLanguages()
        {
            return "english";
        }

        [DebugLog]
        public bool BIsSubscribedApp(AppId appID)
        {
            return true;
        }

        [DebugLog]
        public bool BIsDlcInstalled(AppId appID)
        {
            return false;
        }

        [DebugLog]
        public uint32 GetEarliestPurchaseUnixTime(AppId appID)
        {
            return 0;
        }

        [DebugLog]
        public bool BIsSubscribedFromFreeWeekend()
        {
            return false;
        }

        [DebugLog]
        public int GetDLCCount()
        {
            return 0;
        }

        [DebugLog]
        public bool BGetDLCDataByIndex(int iDLC, AppId* pAppID, bool* pbAvailable, char8* pchName, int cchNameBufferSize)
        {
            return false;
        }

        [DebugLog]
        public void InstallDLC(AppId nAppID)
        {

        }

        [DebugLog]
        public void UninstallDLC(AppId nAppID)
        {

        }

        [DebugLog]
        public void RequestAppProofOfPurchaseKey(AppId nAppID)
        {

        }

        [DebugLog]
        public bool GetCurrentBetaName(char8* pchName, int cchNameBufferSize)
        {
            return false;
        }

        [DebugLog]
        public bool MarkContentCorrupt(bool bMissingFilesOnly)
        {
            return false;
        }

        [DebugLog]
        public uint32 GetInstalledDepots(AppId appID, DepotId* pvecDepots, uint32 cMaxDepots)
        {
            return 0;
        }

        [DebugLog]
        public uint32 GetAppInstallDir(AppId appID, char8* pchFolder, uint32 cchFolderBufferSize)
        {
            return 0;
        }

        [DebugLog]
        public bool BIsAppInstalled(AppId appID)
        {
            return false;
        }

        [DebugLog]
        public CSteamID GetAppOwner(CSteamID* __return)
        {
            return 0;
        }

        [DebugLog]
        public char8* GetLaunchQueryParam(char8* pchKey)
        {
            return null;
        }

        [DebugLog]
        public bool GetDlcDownloadProgress(AppId nAppID, uint64* punBytesDownloaded, uint64* punBytesTotal)
        {
            return false;
        }

        [DebugLog]
        public int GetAppBuildId()
        {
            return 0;
        }

        [DebugLog]
        public void RequestAllProofOfPurchaseKeys()
        {

        }

        [DebugLog]
        public SteamAPICall GetFileDetails(char8* pszFileName)
        {
            return 0;
        }
    }    
}