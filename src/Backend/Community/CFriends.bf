using RfgNetworking.Misc;
using RfgNetworking.API;
using System;

namespace RfgNetworking.Backend.Community
{
    public struct CFriends : ISteamFriends
    {
        [DebugLog]
        public void ModuleInit() mut
        {
            Vtable = new ISteamFriends.VTable();
            Vtable.GetPersonaName = => GetPersonaName;
            Vtable.SetPersonaName = => SetPersonaName;
            Vtable.GetPersonaState = => GetPersonaState;
            Vtable.GetFriendCount = => GetFriendCount;
            Vtable.GetFriendByIndex = => GetFriendByIndex;
            Vtable.GetFriendRelationship = => GetFriendRelationship;
            Vtable.GetFriendPersonaState = => GetFriendPersonaState;
            Vtable.GetFriendPersonaName = => GetFriendPersonaName;
            Vtable.GetFriendGamePlayed = => GetFriendGamePlayed;
            Vtable.GetFriendPersonaNameHistory = => GetFriendPersonaNameHistory;
            Vtable.GetFriendSteamLevel = => GetFriendSteamLevel;
            Vtable.GetPlayerNickname = => GetPlayerNickname;
            Vtable.GetFriendsGroupCount = => GetFriendsGroupCount;
            Vtable.GetFriendsGroupIDByIndex = => GetFriendsGroupIDByIndex;
            Vtable.GetFriendsGroupName = => GetFriendsGroupName;
            Vtable.GetFriendsGroupMembersCount = => GetFriendsGroupMembersCount;
            Vtable.GetFriendsGroupMembersList = => GetFriendsGroupMembersList;
            Vtable.HasFriend = => HasFriend;
            Vtable.GetClanCount = => GetClanCount;
            Vtable.GetClanByIndex = => GetClanByIndex;
            Vtable.GetClanName = => GetClanName;
            Vtable.GetClanTag = => GetClanTag;
            Vtable.GetClanActivityCounts = => GetClanActivityCounts;
            Vtable.DownloadClanActivityCounts = => DownloadClanActivityCounts;
            Vtable.GetFriendCountFromSource = => GetFriendCountFromSource;
            Vtable.GetFriendFromSourceByIndex = => GetFriendFromSourceByIndex;
            Vtable.IsUserInSource = => IsUserInSource;
            Vtable.SetInGameVoiceSpeaking = => SetInGameVoiceSpeaking;
            Vtable.ActivateGameOverlay = => ActivateGameOverlay;
            Vtable.ActivateGameOverlayToUser = => ActivateGameOverlayToUser;
            Vtable.ActivateGameOverlayToWebPage = => ActivateGameOverlayToWebPage;
            Vtable.ActivateGameOverlayToStore = => ActivateGameOverlayToStore;
            Vtable.SetPlayedWith = => SetPlayedWith;
            Vtable.ActivateGameOverlayInviteDialog = => ActivateGameOverlayInviteDialog;
            Vtable.GetSmallFriendAvatar = => GetSmallFriendAvatar;
            Vtable.GetMediumFriendAvatar = => GetMediumFriendAvatar;
            Vtable.GetLargeFriendAvatar = => GetLargeFriendAvatar;
            Vtable.RequestUserInformation = => RequestUserInformation;
            Vtable.RequestClanOfficerList = => RequestClanOfficerList;
            Vtable.GetClanOwner = => GetClanOwner;
            Vtable.GetClanOfficerCount = => GetClanOfficerCount;
            Vtable.GetClanOfficerByIndex = => GetClanOfficerByIndex;
            Vtable.GetUserRestrictions = => GetUserRestrictions;
            Vtable.SetRichPresence = => SetRichPresence;
            Vtable.ClearRichPresence = => ClearRichPresence;
            Vtable.GetFriendRichPresence = => GetFriendRichPresence;
            Vtable.GetFriendRichPresenceKeyCount = => GetFriendRichPresenceKeyCount;
            Vtable.GetFriendRichPresenceKeyByIndex = => GetFriendRichPresenceKeyByIndex;
            Vtable.RequestFriendRichPresence = => RequestFriendRichPresence;
            Vtable.InviteUserToGame = => InviteUserToGame;
            Vtable.GetCoplayFriendCount = => GetCoplayFriendCount;
            Vtable.GetCoplayFriend = => GetCoplayFriend;
            Vtable.GetFriendCoplayTime = => GetFriendCoplayTime;
            Vtable.GetFriendCoplayGame = => GetFriendCoplayGame;
            Vtable.JoinClanChatRoom = => JoinClanChatRoom;
            Vtable.LeaveClanChatRoom = => LeaveClanChatRoom;
            Vtable.GetClanChatMemberCount = => GetClanChatMemberCount;
            Vtable.GetChatMemberByIndex = => GetChatMemberByIndex;
            Vtable.SendClanChatMessage = => SendClanChatMessage;
            Vtable.GetClanChatMessage = => GetClanChatMessage;
            Vtable.IsClanChatAdmin = => IsClanChatAdmin;
            Vtable.IsClanChatWindowOpenInSteam = => IsClanChatWindowOpenInSteam;
            Vtable.OpenClanChatWindowInSteam = => OpenClanChatWindowInSteam;
            Vtable.CloseClanChatWindowInSteam = => CloseClanChatWindowInSteam;
            Vtable.SetListenForFriendsMessages = => SetListenForFriendsMessages;
            Vtable.ReplyToFriendMessage = => ReplyToFriendMessage;
            Vtable.GetFriendMessage = => GetFriendMessage;
            Vtable.GetFollowerCount = => GetFollowerCount;
            Vtable.IsFollowing = => IsFollowing;
            Vtable.EnumerateFollowingList = => EnumerateFollowingList;
            Vtable.IsClanPublic = => IsClanPublic;
            Vtable.IsClanOfficialGameGroup = => IsClanOfficialGameGroup;
        }

        [DebugLog]
        public void ModuleShutdown()
        {
            delete Vtable;
        }

        [DebugLog]
        public char8* GetPersonaName()
        {
            return null;
        }

        [DebugLog]
        public SteamAPICall SetPersonaName(char8* pchPersonaName)
        {
            return 0;
        }

        [DebugLog]
        public PersonaState GetPersonaState()
        {
            return .Offline;
        }

        [DebugLog]
        public int GetFriendCount(int iFriendFlags)
        {
            return 0;
        }

        [DebugLog]
        public CSteamID GetFriendByIndex(int iFriend, int iFriendFlags)
        {
            return 0;
        }

        [DebugLog]
        public FriendRelationship GetFriendRelationship(CSteamID steamIDFriend)
        {
            return .None;
        }

        [DebugLog]
        public PersonaState GetFriendPersonaState(CSteamID steamIDFriend)
        {
            return .Offline;
        }

        [DebugLog]
        public char8* GetFriendPersonaName(CSteamID steamIDFriend)
        {
            return null;
        }

        [DebugLog]
        public bool GetFriendGamePlayed(CSteamID steamIDFriend, FriendGameInfo* pFriendGameInfo)
        {
            return false;
        }

        [DebugLog]
        public char8* GetFriendPersonaNameHistory(CSteamID steamIDFriend, int iPersonaName)
        {
            return null;
        }

        [DebugLog]
        public int32 GetFriendSteamLevel(CSteamID steamIDFriend)
        {
            return 0;
        }

        [DebugLog]
        public char8* GetPlayerNickname(CSteamID steamIDPlayer)
        {
            return null;
        }

        [DebugLog]
        public int32 GetFriendsGroupCount()
        {
            return 0;
        }

        [DebugLog]
        public FriendsGroupID GetFriendsGroupIDByIndex(int32 iFG)
        {
            return 0;
        }

        [DebugLog]
        public char8* GetFriendsGroupName(FriendsGroupID friendsGroupID)
        {
            return null;
        }

        [DebugLog]
        public int32 GetFriendsGroupMembersCount(FriendsGroupID friendsGroupID)
        {
            return 0;
        }

        [DebugLog]
        public void GetFriendsGroupMembersList(FriendsGroupID friendsGroupID, CSteamID* pOutSteamIDMembers, int32 nMembersCount)
        {

        }

        [DebugLog]
        public bool HasFriend(CSteamID steamIDFriend, int iFriendFlags)
        {
            return false;
        }

        [DebugLog]
        public int32 GetClanCount()
        {
            return 0;
        }

        [DebugLog]
        public CSteamID GetClanByIndex(CSteamID* __return, int32 iClan)
        {
            return 0;
        }

        [DebugLog]
        public char8* GetClanName(CSteamID steamIDClan)
        {
            return null;
        }

        [DebugLog]
        public char8* GetClanTag(CSteamID steamIDClan)
        {
            return null;
        }

        [DebugLog]
        public bool GetClanActivityCounts(CSteamID steamIDClan, int32* pnOnline, int32* pnInGame, int32* pnChatting)
        {
            return false;
        }

        [DebugLog]
        public SteamAPICall DownloadClanActivityCounts(CSteamID* psteamIDClans, int32 cClansToRequest)
        {
            return 0;
        }

        [DebugLog]
        public int32 GetFriendCountFromSource(CSteamID steamIDSource)
        {
            return 0;
        }

        [DebugLog]
        public CSteamID GetFriendFromSourceByIndex(CSteamID* __return, CSteamID steamIDSource, int32 iFriend)
        {
            return 0;
        }

        [DebugLog]
        public bool IsUserInSource(CSteamID steamIDUser, CSteamID steamIDSource)
        {
            return false;
        }

        [DebugLog]
        public void SetInGameVoiceSpeaking(CSteamID steamIDUser, bool bSpeaking)
        {

        }

        [DebugLog]
        public void ActivateGameOverlay(char8* pchDialog)
        {

        }

        [DebugLog]
        public void ActivateGameOverlayToUser(char8* pchDialog, CSteamID steamID)
        {

        }

        [DebugLog]
        public void ActivateGameOverlayToWebPage(char8* pchURL)
        {

        }

        [DebugLog]
        public void ActivateGameOverlayToStore(AppId nAppID, OverlayToStoreFlag eFlag)
        {

        }

        [DebugLog]
        public void SetPlayedWith(CSteamID steamIDUserPlayedWith)
        {

        }

        [DebugLog]
        public void ActivateGameOverlayInviteDialog(CSteamID steamIDLobby)
        {

        }

        [DebugLog]
        public int GetSmallFriendAvatar(CSteamID steamIDFriend)
        {
            return 0;
        }

        [DebugLog]
        public int GetMediumFriendAvatar(CSteamID steamIDFriend)
        {
            return 0;
        }

        [DebugLog]
        public int GetLargeFriendAvatar(CSteamID steamIDFriend)
        {
            return 0;
        }

        [DebugLog]
        public bool RequestUserInformation(CSteamID steamIDUser, bool bRequireNameOnly)
        {
            return false;
        }

        [DebugLog]
        public SteamAPICall RequestClanOfficerList(CSteamID steamIDClan)
        {
            return 0;
        }

        [DebugLog]
        public CSteamID GetClanOwner(CSteamID* __return, CSteamID steamIDClan)
        {
            return 0;
        }

        [DebugLog]
        public int GetClanOfficerCount(CSteamID steamIDClan)
        {
            return 0;
        }

        [DebugLog]
        public CSteamID GetClanOfficerByIndex(CSteamID* __return, CSteamID steamIDClan, int iOfficer)
        {
            return 0;
        }

        [DebugLog]
        public uint32 GetUserRestrictions()
        {
            return 0;
        }

        [DebugLog]
        public bool SetRichPresence(char8* pchKey, char8* pchValue)
        {
            return false;
        }

        [DebugLog]
        public void ClearRichPresence()
        {

        }

        [DebugLog]
        public char8* GetFriendRichPresence(CSteamID steamIDFriend, char8* pchKey)
        {
            return null;
        }

        [DebugLog]
        public int GetFriendRichPresenceKeyCount(CSteamID steamIDFriend)
        {
            return 0;
        }

        [DebugLog]
        public char8* GetFriendRichPresenceKeyByIndex(CSteamID steamIDFriend, int iKey)
        {
            return null;
        }

        [DebugLog]
        public void RequestFriendRichPresence(CSteamID steamIDFriend)
        {

        }

        [DebugLog]
        public bool InviteUserToGame(CSteamID steamIDFriend, char8* pchConnectString)
        {
            return false;
        }

        [DebugLog]
        public int GetCoplayFriendCount()
        {
            return 0;
        }

        [DebugLog]
        public CSteamID GetCoplayFriend(CSteamID* __return, int iCoplayFriend)
        {
            return 0;
        }

        [DebugLog]
        public int GetFriendCoplayTime(CSteamID steamIDFriend)
        {
            return 0;
        }

        [DebugLog]
        public AppId GetFriendCoplayGame(CSteamID steamIDFriend)
        {
            return 0;
        }

        [DebugLog]
        public SteamAPICall JoinClanChatRoom(CSteamID steamIDClan)
        {
            return 0;
        }

        [DebugLog]
        public bool LeaveClanChatRoom(CSteamID steamIDClan)
        {
            return false;
        }

        [DebugLog]
        public int GetClanChatMemberCount(CSteamID steamIDClan)
        {
            return 0;
        }

        [DebugLog]
        public CSteamID GetChatMemberByIndex(CSteamID* __return, CSteamID steamIDClan, int iUser)
        {
            return 0;
        }

        [DebugLog]
        public bool SendClanChatMessage(CSteamID steamIDClanChat, char8* pchText)
        {
            return false;
        }

        [DebugLog]
        public int GetClanChatMessage(CSteamID steamIDClanChat, int iMessage, void* prgchText, int cchTextMax, ChatEntryType* peChatEntryType, CSteamID* psteamidChatter)
        {
            return 0;
        }

        [DebugLog]
        public bool IsClanChatAdmin(CSteamID steamIDClanChat, CSteamID steamIDUser)
        {
            return false;
        }

        [DebugLog]
        public bool IsClanChatWindowOpenInSteam(CSteamID steamIDClanChat)
        {
            return false;
        }

        [DebugLog]
        public bool OpenClanChatWindowInSteam(CSteamID steamIDClanChat)
        {
            return false;
        }

        [DebugLog]
        public bool CloseClanChatWindowInSteam(CSteamID steamIDClanChat)
        {
            return false;
        }

        [DebugLog]
        public bool SetListenForFriendsMessages(bool bInterceptEnabled)
        {
            return false;
        }

        [DebugLog]
        public bool ReplyToFriendMessage(CSteamID steamIDFriend, char8* pchMsgToSend)
        {
            return false;
        }

        [DebugLog]
        public int GetFriendMessage(CSteamID steamIDFriend, int iMessageID, void* pvData, int cubData, ChatEntryType* peChatEntryType)
        {
            return 0;
        }

        [DebugLog]
        public SteamAPICall GetFollowerCount(CSteamID steamID)
        {
            return 0;
        }

        [DebugLog]
        public SteamAPICall IsFollowing(CSteamID steamID)
        {
            return 0;
        }

        [DebugLog]
        public SteamAPICall EnumerateFollowingList(uint32 unStartIndex)
        {
            return 0;
        }

        [DebugLog]
        public bool IsClanPublic(CSteamID steamIDClan)
        {
            return false;
        }

        [DebugLog]
        public bool IsClanOfficialGameGroup(CSteamID steamIDClan)
        {
            return false;
        }
    }    
}