using RfgNetworking.Misc;
using RfgNetworking.API;
using System;

namespace RfgNetworking.Backend.Community
{
    public struct CUserStats : ISteamUserStats
    {
        [DebugLog]
        public void ModuleInit() mut
        {
            Vtable = new ISteamUserStats.VTable();
            Vtable.RequestCurrentStats = => RequestCurrentStats;
            Vtable.GetStat_1 = => GetStat_1;
            Vtable.GetStat_2 = => GetStat_2;
            Vtable.SetStat_1 = => SetStat_1;
            Vtable.SetStat_2 = => SetStat_2;
            Vtable.UpdateAvgRateStat = => UpdateAvgRateStat;
            Vtable.GetAchievement = => GetAchievement;
            Vtable.SetAchievement = => SetAchievement;
            Vtable.ClearAchievement = => ClearAchievement;
            Vtable.GetAchievementAndUnlockTime = => GetAchievementAndUnlockTime;
            Vtable.StoreStats = => StoreStats;
            Vtable.GetAchievementIcon = => GetAchievementIcon;
            Vtable.GetAchievementDisplayAttribute = => GetAchievementDisplayAttribute;
            Vtable.IndicateAchievementProgress = => IndicateAchievementProgress;
            Vtable.GetNumAchievements = => GetNumAchievements;
            Vtable.GetAchievementName = => GetAchievementName;
            Vtable.RequestUserStats = => RequestUserStats;
            Vtable.GetUserStat_1 = => GetUserStat_1;
            Vtable.GetUserStat_2 = => GetUserStat_2;
            Vtable.GetUserAchievement = => GetUserAchievement;
            Vtable.GetUserAchievementAndUnlockTime = => GetUserAchievementAndUnlockTime;
            Vtable.ResetAllStats = => ResetAllStats;
            Vtable.FindOrCreateLeaderboard = => FindOrCreateLeaderboard;
            Vtable.FindLeaderboard = => FindLeaderboard;
            Vtable.GetLeaderboardName = => GetLeaderboardName;
            Vtable.GetLeaderboardEntryCount = => GetLeaderboardEntryCount;
            Vtable.GetLeaderboardSortMethod = => GetLeaderboardSortMethod;
            Vtable.GetLeaderboardDisplayType = => GetLeaderboardDisplayType;
            Vtable.DownloadLeaderboardEntries = => DownloadLeaderboardEntries;
            Vtable.DownloadLeaderboardEntriesForUsers = => DownloadLeaderboardEntriesForUsers;
            Vtable.GetDownloadedLeaderboardEntry = => GetDownloadedLeaderboardEntry;
            Vtable.UploadLeaderboardScore = => UploadLeaderboardScore;
            Vtable.AttachLeaderboardUGC = => AttachLeaderboardUGC;
            Vtable.GetNumberOfCurrentPlayers = => GetNumberOfCurrentPlayers;
            Vtable.RequestGlobalAchievementPercentages = => RequestGlobalAchievementPercentages;
            Vtable.GetMostAchievedAchievementInfo = => GetMostAchievedAchievementInfo;
            Vtable.GetNextMostAchievedAchievementInfo = => GetNextMostAchievedAchievementInfo;
            Vtable.GetAchievementAchievedPercent = => GetAchievementAchievedPercent;
            Vtable.RequestGlobalStats = => RequestGlobalStats;
            Vtable.GetGlobalStat_1 = => GetGlobalStat_1;
            Vtable.GetGlobalStat_2 = => GetGlobalStat_2;
            Vtable.GetGlobalStatHistory_1 = => GetGlobalStatHistory_1;
            Vtable.GetGlobalStatHistory_2 = => GetGlobalStatHistory_2;
        }

        [DebugLog]
        public void ModuleShutdown()
        {
            delete Vtable;
        }

        [DebugLog]
        public bool RequestCurrentStats()
        {
            return false;
        }

        [DebugLog]
        public bool GetStat_1(char8* pchName, float* pData)
        {
            return false;
        }

        [DebugLog]
        public bool GetStat_2(char8* pchName, int32* pData)
        {
            return false;
        }

        [DebugLog]
        public bool SetStat_1(char8* pchName, float nData)
        {
            return false;
        }

        [DebugLog]
        public bool SetStat_2(char8* pchName, int32 nData)
        {
            return false;
        }

        [DebugLog]
        public bool UpdateAvgRateStat(char8* pchName, float flCountThisSession, double dSessionLength)
        {
            return false;
        }

        [DebugLog]
        public bool GetAchievement(char8* pchName, bool* pbAchieved)
        {
            return false;
        }

        [DebugLog]
        public bool SetAchievement(char8* pchName)
        {
            return false;
        }

        [DebugLog]
        public bool ClearAchievement(char8* pchName)
        {
            return false;
        }

        [DebugLog]
        public bool GetAchievementAndUnlockTime(char8* pchName, bool* pbAchieved, uint32* punUnlockTime)
        {
            return false;
        }

        [DebugLog]
        public bool StoreStats()
        {
            return false;
        }

        [DebugLog]
        public int GetAchievementIcon(char8* pchName)
        {
            return 0;
        }

        [DebugLog]
        public char8* GetAchievementDisplayAttribute(char8* pchName, char8* pchKey)
        {
            return null;
        }

        [DebugLog]
        public bool IndicateAchievementProgress(char8* pchName, uint32 nCurProgress, uint32 nMaxProgress)
        {
            return false;
        }

        [DebugLog]
        public uint32 GetNumAchievements()
        {
            return 0;
        }

        [DebugLog]
        public char8* GetAchievementName(uint32 iAchievement)
        {
            return null;
        }

        [DebugLog]
        public SteamAPICall RequestUserStats(CSteamID steamIDUser)
        {
            return 0;
        }

        [DebugLog]
        public bool GetUserStat_1(CSteamID steamIDUser, char8* pchName, float* pData)
        {
            return false;
        }

        [DebugLog]
        public bool GetUserStat_2(CSteamID steamIDUser, char8* pchName, int32* pData)
        {
            return false;
        }

        [DebugLog]
        public bool GetUserAchievement(CSteamID steamIDUser, char8* pchName, uint8* pbAchieved)
        {
            return false;
        }

        [DebugLog]
        public bool GetUserAchievementAndUnlockTime(CSteamID steamIDUser, char8* pchName, uint8* pbAchieved, uint32* punUnlockTime)
        {
            return false;
        }

        [DebugLog]
        public bool ResetAllStats(uint8 bAchievementsToo)
        {
            return false;
        }

        [DebugLog]
        public SteamAPICall FindOrCreateLeaderboard(char8* pchLeaderboardName, LeaderboardSortMethod eLeaderboardSortMethod, LeaderboardDisplayType eLeaderboardDisplayType)
        {
            return 0;
        }

        [DebugLog]
        public SteamAPICall FindLeaderboard(char8* pchLeaderboardName)
        {
            return 0;
        }

        [DebugLog]
        public char8* GetLeaderboardName(SteamLeaderboard hSteamLeaderboard)
        {
            return null;
        }

        [DebugLog]
        public int GetLeaderboardEntryCount(SteamLeaderboard hSteamLeaderboard)
        {
            return 0;
        }

        [DebugLog]
        public LeaderboardSortMethod GetLeaderboardSortMethod(SteamLeaderboard hSteamLeaderboard)
        {
            return .None;
        }

        [DebugLog]
        public LeaderboardDisplayType GetLeaderboardDisplayType(SteamLeaderboard hSteamLeaderboard)
        {
            return .None;
        }

        [DebugLog]
        public SteamAPICall DownloadLeaderboardEntries(SteamLeaderboard hSteamLeaderboard, LeaderboardDataRequest eLeaderboardDataRequest, int nRangeStart, int nRangeEnd)
        {
            return 0;
        }

        [DebugLog]
        public SteamAPICall DownloadLeaderboardEntriesForUsers(SteamLeaderboard hSteamLeaderboard, CSteamID* prgUsers, int cUsers)
        {
            return 0;
        }

        [DebugLog]
        public bool GetDownloadedLeaderboardEntry(SteamLeaderboardEntries hSteamLeaderboardEntries, int index, LeaderboardEntry* pLeaderboardEntry, int32* pDetails, int cDetailsMax)
        {
            return false;
        }

        [DebugLog]
        public SteamAPICall UploadLeaderboardScore(SteamLeaderboard hSteamLeaderboard, LeaderboardUploadScoreMethod eLeaderboardUploadScoreMethod, int32 nScore, int32* pScoreDetails, int cScoreDetailsCount)
        {
            return 0;
        }

        [DebugLog]
        public SteamAPICall AttachLeaderboardUGC(SteamLeaderboard hSteamLeaderboard, UGCHandle hUGC)
        {
            return 0;
        }

        [DebugLog]
        public SteamAPICall GetNumberOfCurrentPlayers()
        {
            return 0;
        }

        [DebugLog]
        public SteamAPICall RequestGlobalAchievementPercentages()
        {
            return 0;
        }

        [DebugLog]
        public int GetMostAchievedAchievementInfo(char8* pchName, uint32 unNameBufLen, float* pflPercent, bool* pbAchieved)
        {
            return 0;
        }

        [DebugLog]
        public int GetNextMostAchievedAchievementInfo(int iIteratorPrevious, char8* pchName, uint32 unNameBufLen, float* pflPercent, bool* pbAchieved)
        {
            return 0;
        }

        [DebugLog]
        public bool GetAchievementAchievedPercent(char8* pchName, float* pflPercent)
        {
            return false;
        }

        [DebugLog]
        public SteamAPICall RequestGlobalStats(int nHistoryDays)
        {
            return 0;
        }

        [DebugLog]
        public bool GetGlobalStat_1(char8* pchStatName, double* pData)
        {
            return false;
        }

        [DebugLog]
        public bool GetGlobalStat_2(char8* pchStatName, int64* pData)
        {
            return false;
        }

        [DebugLog]
        public int32 GetGlobalStatHistory_1(char8* pchStateName, double* pData, uint32 cubData)
        {
            return 0;
        }

        [DebugLog]
        public int32 GetGlobalStatHistory_2(char8* pchStatName, int64* pData, uint32 cubData)
        {
            return 0;
        }
    }    
}