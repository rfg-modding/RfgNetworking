using RfgNetworking.Misc;
using RfgNetworking.API;
using System;

namespace RfgNetworking.Backend.Community
{
    public struct CRemoteStorage : ISteamRemoteStorage
    {
        [DebugLog]
        public void ModuleInit() mut
        {
            Vtable = new ISteamRemoteStorage.VTable();
            Vtable.FileWrite = => FileWrite;
            Vtable.FileRead = => FileRead;
            Vtable.FileWriteAsync = => FileWriteAsync;
            Vtable.FileReadAsync = => FileReadAsync;
            Vtable.FileReadAsyncComplete = => FileReadAsyncComplete;
            Vtable.FileForget = => FileForget;
            Vtable.FileDelete = => FileDelete;
            Vtable.FileShare = => FileShare;
            Vtable.SetSyncPlatforms = => SetSyncPlatforms;
            Vtable.FileWriteStreamOpen = => FileWriteStreamOpen;
            Vtable.FileWriteStreamWriteChunk = => FileWriteStreamWriteChunk;
            Vtable.FileWriteStreamClose = => FileWriteStreamClose;
            Vtable.FileWriteStreamCancel = => FileWriteStreamCancel;
            Vtable.FileExists = => FileExists;
            Vtable.FilePersisted = => FilePersisted;
            Vtable.GetFileSize = => GetFileSize;
            Vtable.GetFileTimestamp = => GetFileTimestamp;
            Vtable.GetSyncPlatforms = => GetSyncPlatforms;
            Vtable.GetFileCount = => GetFileCount;
            Vtable.GetFileNameAndSize = => GetFileNameAndSize;
            Vtable.GetQuota = => GetQuota;
            Vtable.IsCloudEnabledForAccount = => IsCloudEnabledForAccount;
            Vtable.IsCloudEnabledForApp = => IsCloudEnabledForApp;
            Vtable.SetCloudEnabledForApp = => SetCloudEnabledForApp;
            Vtable.UGCDownload = => UGCDownload;
            Vtable.GetUGCDownloadProgress = => GetUGCDownloadProgress;
            Vtable.GetUGCDetails = => GetUGCDetails;
            Vtable.UGCRead = => UGCRead;
            Vtable.GetCachedUGCCount = => GetCachedUGCCount;
            Vtable.GetCachedUGCHandle = => GetCachedUGCHandle;
            Vtable.PublishWorkshopFile = => PublishWorkshopFile;
            Vtable.CreatePublishedFileUpdateRequest = => CreatePublishedFileUpdateRequest;
            Vtable.UpdatePublishedFileFile = => UpdatePublishedFileFile;
            Vtable.UpdatePublishedFilePreviewFile = => UpdatePublishedFilePreviewFile;
            Vtable.UpdatePublishedFileTitle = => UpdatePublishedFileTitle;
            Vtable.UpdatePublishedFileDescription = => UpdatePublishedFileDescription;
            Vtable.UpdatePublishedFileVisibility = => UpdatePublishedFileVisibility;
            Vtable.UpdatePublishedFileTags = => UpdatePublishedFileTags;
            Vtable.CommitPublishedFileUpdate = => CommitPublishedFileUpdate;
            Vtable.GetPublishedFileDetails = => GetPublishedFileDetails;
            Vtable.DeletePublishedFile = => DeletePublishedFile;
            Vtable.EnumerateUserPublishedFiles = => EnumerateUserPublishedFiles;
            Vtable.SubscribePublishedFile = => SubscribePublishedFile;
            Vtable.EnumerateUserSubscribedFiles = => EnumerateUserSubscribedFiles;
            Vtable.UnsubscribePublishedFile = => UnsubscribePublishedFile;
            Vtable.UpdatePublishedFileSetChangeDescription = => UpdatePublishedFileSetChangeDescription;
            Vtable.GetPublishedItemVoteDetails = => GetPublishedItemVoteDetails;
            Vtable.UpdateUserPublishedItemVote = => UpdateUserPublishedItemVote;
            Vtable.GetUserPublishedItemVoteDetails = => GetUserPublishedItemVoteDetails;
            Vtable.EnumerateUserSharedWorkshopFiles = => EnumerateUserSharedWorkshopFiles;
            Vtable.PublishVideo = => PublishVideo;
            Vtable.SetUserPublishedFileAction = => SetUserPublishedFileAction;
            Vtable.EnumeratePublishedFilesByUserAction = => EnumeratePublishedFilesByUserAction;
            Vtable.EnumeratePublishedWorkshopFiles = => EnumeratePublishedWorkshopFiles;
            Vtable.UGCDownloadToLocation = => UGCDownloadToLocation;
        }

        [DebugLog]
        public void ModuleShutdown()
        {
            delete Vtable;
        }

        [DebugLog]
        public bool FileWrite(char8* pchFile, void* pvData, int32 cubData)
        {
            return false;
        }

        [DebugLog]
        public int32 FileRead(char8* pchFile, void* pvData, int32 cubDataToRead)
        {
            return 0;
        }

        [DebugLog]
        public SteamAPICall FileWriteAsync(char8* pchFile, void* pvData, uint32 cubData)
        {
            return 0;
        }

        [DebugLog]
        public SteamAPICall FileReadAsync(char8* pchFile, uint32 nOffset, uint32 cubToRead)
        {
            return 0;
        }

        [DebugLog]
        public bool FileReadAsyncComplete(SteamAPICall hReadCall, void* pvBuffer, uint32 cubToRead)
        {
            return false;
        }

        [DebugLog]
        public bool FileForget(char8* pchFile)
        {
            return false;
        }

        [DebugLog]
        public bool FileDelete(char8* pchFile)
        {
            return false;
        }

        [DebugLog]
        public SteamAPICall FileShare(char8* pchFile)
        {
            return 0;
        }

        [DebugLog]
        public bool SetSyncPlatforms(char8* pchFile, RemoteStoragePlatform eRemoteStoragePlatform)
        {
            return false;
        }

        [DebugLog]
        public UGCFileWriteStreamHandle FileWriteStreamOpen(char8* pchFile)
        {
            return 0;
        }

        [DebugLog]
        public bool FileWriteStreamWriteChunk(UGCFileWriteStreamHandle writeHandle, void* pvData, int32 cubData)
        {
            return false;
        }

        [DebugLog]
        public bool FileWriteStreamClose(UGCFileWriteStreamHandle writeHandle)
        {
            return false;
        }

        [DebugLog]
        public bool FileWriteStreamCancel(UGCFileWriteStreamHandle writeHandle)
        {
            return false;
        }

        [DebugLog]
        public bool FileExists(char8* pchFile)
        {
            return false;
        }

        [DebugLog]
        public bool FilePersisted(char8* pchFile)
        {
            return false;
        }

        [DebugLog]
        public int32 GetFileSize(char8* pchFile)
        {
            return 0;
        }

        [DebugLog]
        public int64 GetFileTimestamp(char8* pchFile)
        {
            return 0;
        }

        [DebugLog]
        public RemoteStoragePlatform GetSyncPlatforms(char8* pchFile)
        {
            return .Windows;
        }

        [DebugLog]
        public int32 GetFileCount()
        {
            return 0;
        }

        [DebugLog]
        public char8* GetFileNameAndSize(int32 iFile, int32* pnFileSizeInBytes)
        {
            return null;
        }

        [DebugLog]
        public bool GetQuota(uint64* pnTotalBytes, uint64* puAvailableBytes)
        {
            return false;
        }

        [DebugLog]
        public bool IsCloudEnabledForAccount()
        {
            return false;
        }

        [DebugLog]
        public bool IsCloudEnabledForApp()
        {
            return false;
        }

        [DebugLog]
        public void SetCloudEnabledForApp(bool bEnabled)
        {

        }

        [DebugLog]
        public SteamAPICall UGCDownload(UGCHandle hContent, uint32 unPriority)
        {
            return 0;
        }

        [DebugLog]
        public bool GetUGCDownloadProgress(UGCHandle hContent, int32* pnBytesDownloaded, int32* pnBytesExpected)
        {
            return false;
        }

        [DebugLog]
        public bool GetUGCDetails(UGCHandle hContent, AppId* pnAppID, char8** ppchName, int32* pnFileSizeInBytes, CSteamID* pSteamIDOwner)
        {
            return false;
        }

        [DebugLog]
        public int32 UGCRead(UGCHandle hContent, void* pvData, int32 cubDataToRead, uint32 cOffset, UGCReadAction eAction)
        {
            return 0;
        }

        [DebugLog]
        public int32 GetCachedUGCCount()
        {
            return 0;
        }

        [DebugLog]
        public UGCHandle GetCachedUGCHandle(int32 iCachedContent)
        {
            return 0;
        }

        [DebugLog]
        public SteamAPICall PublishWorkshopFile(char8* pchFile, char8* pchPreviewFile, AppId nConsumerAppId, char8* pchTitle, char8* pchDescription, RemoteStoragePublishedFileVisibility eVisibility, SteamParamStringArray* pTags, WorkshopFileType eWorkshopFileType)
        {
            return 0;
        }

        [DebugLog]
        public PublishedFileUpdateHandle CreatePublishedFileUpdateRequest(PublishedFileId unPublishedFileId)
        {
            return 0;
        }

        [DebugLog]
        public bool UpdatePublishedFileFile(PublishedFileUpdateHandle updateHandle, char8* pchFile)
        {
            return false;
        }

        [DebugLog]
        public bool UpdatePublishedFilePreviewFile(PublishedFileUpdateHandle updateHandle, char8* pchPreviewFile)
        {
            return false;
        }

        [DebugLog]
        public bool UpdatePublishedFileTitle(PublishedFileUpdateHandle updateHandle, char8* pchTitle)
        {
            return false;
        }

        [DebugLog]
        public bool UpdatePublishedFileDescription(PublishedFileUpdateHandle updateHandle, char8* pchDescription)
        {
            return false;
        }

        [DebugLog]
        public bool UpdatePublishedFileVisibility(PublishedFileUpdateHandle updateHandle, RemoteStoragePublishedFileVisibility eVisibility)
        {
            return false;
        }

        [DebugLog]
        public bool UpdatePublishedFileTags(PublishedFileUpdateHandle updateHandle, SteamParamStringArray* pTags)
        {
            return false;
        }

        [DebugLog]
        public SteamAPICall CommitPublishedFileUpdate(PublishedFileUpdateHandle updateHandle)
        {
            return 0;
        }

        [DebugLog]
        public SteamAPICall GetPublishedFileDetails(PublishedFileId unPublishedFileId, uint32 unMaxSecondsOld)
        {
            return 0;
        }

        [DebugLog]
        public SteamAPICall DeletePublishedFile(PublishedFileId unPublishedFileId)
        {
            return 0;
        }

        [DebugLog]
        public SteamAPICall EnumerateUserPublishedFiles(uint32 unStartIndex)
        {
            return 0;
        }

        [DebugLog]
        public SteamAPICall SubscribePublishedFile(PublishedFileId unPublishedFileId)
        {
            return 0;
        }

        [DebugLog]
        public SteamAPICall EnumerateUserSubscribedFiles(uint32 unStartIndex)
        {
            return 0;
        }

        [DebugLog]
        public SteamAPICall UnsubscribePublishedFile(PublishedFileId unPublishedFileId)
        {
            return 0;
        }

        [DebugLog]
        public bool UpdatePublishedFileSetChangeDescription(PublishedFileUpdateHandle updateHandle, char8* pchChangeDescription)
        {
            return false;
        }

        [DebugLog]
        public SteamAPICall GetPublishedItemVoteDetails(PublishedFileId unPublishedFileId)
        {
            return 0;
        }

        [DebugLog]
        public SteamAPICall UpdateUserPublishedItemVote(PublishedFileId unPublishedFileId, bool bVoteUp)
        {
            return 0;
        }

        [DebugLog]
        public SteamAPICall GetUserPublishedItemVoteDetails(PublishedFileId unPublishedFileId)
        {
            return 0;
        }

        [DebugLog]
        public SteamAPICall EnumerateUserSharedWorkshopFiles(CSteamID steamId, uint32 unStartIndex, SteamParamStringArray* pRequiredTags, SteamParamStringArray* pExcludedTags)
        {
            return 0;
        }

        [DebugLog]
        public SteamAPICall PublishVideo(WorkshopVideoProvider eVideoProvider, char8* pchVideoAccount, char8* pchVideoIdentifier, char8* pchPreviewFile, AppId nConsumerAppId, char8* pchTitle, char8* pchDescription, RemoteStoragePublishedFileVisibility eVisibility, SteamParamStringArray* pTags)
        {
            return 0;
        }

        [DebugLog]
        public SteamAPICall SetUserPublishedFileAction(PublishedFileId unPublishedFileId, WorkshopFileAction eAction)
        {
            return 0;
        }

        [DebugLog]
        public SteamAPICall EnumeratePublishedFilesByUserAction(WorkshopFileAction eAction, uint32 unStartIndex)
        {
            return 0;
        }

        [DebugLog]
        public SteamAPICall EnumeratePublishedWorkshopFiles(WorkshopEnumerationType eEnumerationType, uint32 unStartIndex, uint32 unCount, uint32 unDays, SteamParamStringArray* pTags, SteamParamStringArray* pUserTags)
        {
            return 0;
        }

        [DebugLog]
        public SteamAPICall UGCDownloadToLocation(UGCHandle hContent, char8* pchLocation, uint32 unPriority)
        {
            return 0;
        }
    }    
}