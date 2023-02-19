using RfgNetworking.API;

namespace RfgNetworking.Backend.Community
{
    public struct CFriends : ISteamFriends
    {
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

        public void ModuleShutdown()
        {
            delete Vtable;
        }

        public char8* GetPersonaName()
        {
            return null;
        }

        public SteamAPICall SetPersonaName(char8* pchPersonaName)
        {
            return 0;
        }

        public PersonaState GetPersonaState()
        {
            return .Offline;
        }

        public int GetFriendCount(int iFriendFlags)
        {
            return 0;
        }

        public CSteamID GetFriendByIndex(int iFriend, int iFriendFlags)
        {
            return 0;
        }

        public FriendRelationship GetFriendRelationship(CSteamID steamIDFriend)
        {
            return .None;
        }

        public PersonaState GetFriendPersonaState(CSteamID steamIDFriend)
        {
            return .Offline;
        }

        public char8* GetFriendPersonaName(CSteamID steamIDFriend)
        {
            return null;
        }

        public bool GetFriendGamePlayed(CSteamID steamIDFriend, FriendGameInfo* pFriendGameInfo)
        {
            return false;
        }

        public char8* GetFriendPersonaNameHistory(CSteamID steamIDFriend, int iPersonaName)
        {
            return null;
        }

        public int32 GetFriendSteamLevel(CSteamID steamIDFriend)
        {
            return 0;
        }

        public char8* GetPlayerNickname(CSteamID steamIDPlayer)
        {
            return null;
        }

        public int32 GetFriendsGroupCount()
        {
            return 0;
        }

        public FriendsGroupID GetFriendsGroupIDByIndex(int32 iFG)
        {
            return 0;
        }

        public char8* GetFriendsGroupName(FriendsGroupID friendsGroupID)
        {
            return null;
        }

        public int32 GetFriendsGroupMembersCount(FriendsGroupID friendsGroupID)
        {
            return 0;
        }

        public void GetFriendsGroupMembersList(FriendsGroupID friendsGroupID, CSteamID* pOutSteamIDMembers, int32 nMembersCount)
        {

        }

        public bool HasFriend(CSteamID steamIDFriend, int iFriendFlags)
        {
            return false;
        }

        public int32 GetClanCount()
        {
            return 0;
        }

        public CSteamID GetClanByIndex(CSteamID* __return, int32 iClan)
        {
            return 0;
        }

        public char8* GetClanName(CSteamID steamIDClan)
        {
            return null;
        }

        public char8* GetClanTag(CSteamID steamIDClan)
        {
            return null;
        }

        public bool GetClanActivityCounts(CSteamID steamIDClan, int32* pnOnline, int32* pnInGame, int32* pnChatting)
        {
            return false;
        }

        public SteamAPICall DownloadClanActivityCounts(CSteamID* psteamIDClans, int32 cClansToRequest)
        {
            return 0;
        }

        public int32 GetFriendCountFromSource(CSteamID steamIDSource)
        {
            return 0;
        }

        public CSteamID GetFriendFromSourceByIndex(CSteamID* __return, CSteamID steamIDSource, int32 iFriend)
        {
            return 0;
        }

        public bool IsUserInSource(CSteamID steamIDUser, CSteamID steamIDSource)
        {
            return false;
        }

        public void SetInGameVoiceSpeaking(CSteamID steamIDUser, bool bSpeaking)
        {

        }

        public void ActivateGameOverlay(char8* pchDialog)
        {

        }

        public void ActivateGameOverlayToUser(char8* pchDialog, CSteamID steamID)
        {

        }

        public void ActivateGameOverlayToWebPage(char8* pchURL)
        {

        }

        public void ActivateGameOverlayToStore(AppId nAppID, OverlayToStoreFlag eFlag)
        {

        }

        public void SetPlayedWith(CSteamID steamIDUserPlayedWith)
        {

        }

        public void ActivateGameOverlayInviteDialog(CSteamID steamIDLobby)
        {

        }

        public int GetSmallFriendAvatar(CSteamID steamIDFriend)
        {
            return 0;
        }

        public int GetMediumFriendAvatar(CSteamID steamIDFriend)
        {
            return 0;
        }

        public int GetLargeFriendAvatar(CSteamID steamIDFriend)
        {
            return 0;
        }

        public bool RequestUserInformation(CSteamID steamIDUser, bool bRequireNameOnly)
        {
            return false;
        }

        public SteamAPICall RequestClanOfficerList(CSteamID steamIDClan)
        {
            return 0;
        }

        public CSteamID GetClanOwner(CSteamID* __return, CSteamID steamIDClan)
        {
            return 0;
        }

        public int GetClanOfficerCount(CSteamID steamIDClan)
        {
            return 0;
        }

        public CSteamID GetClanOfficerByIndex(CSteamID* __return, CSteamID steamIDClan, int iOfficer)
        {
            return 0;
        }

        public uint32 GetUserRestrictions()
        {
            return 0;
        }

        public bool SetRichPresence(char8* pchKey, char8* pchValue)
        {
            return false;
        }

        public void ClearRichPresence()
        {

        }

        public char8* GetFriendRichPresence(CSteamID steamIDFriend, char8* pchKey)
        {
            return null;
        }

        public int GetFriendRichPresenceKeyCount(CSteamID steamIDFriend)
        {
            return 0;
        }

        public char8* GetFriendRichPresenceKeyByIndex(CSteamID steamIDFriend, int iKey)
        {
            return null;
        }

        public void RequestFriendRichPresence(CSteamID steamIDFriend)
        {

        }

        public bool InviteUserToGame(CSteamID steamIDFriend, char8* pchConnectString)
        {
            return false;
        }

        public int GetCoplayFriendCount()
        {
            return 0;
        }

        public CSteamID GetCoplayFriend(CSteamID* __return, int iCoplayFriend)
        {
            return 0;
        }

        public int GetFriendCoplayTime(CSteamID steamIDFriend)
        {
            return 0;
        }

        public AppId GetFriendCoplayGame(CSteamID steamIDFriend)
        {
            return 0;
        }

        public SteamAPICall JoinClanChatRoom(CSteamID steamIDClan)
        {
            return 0;
        }

        public bool LeaveClanChatRoom(CSteamID steamIDClan)
        {
            return false;
        }

        public int GetClanChatMemberCount(CSteamID steamIDClan)
        {
            return 0;
        }

        public CSteamID GetChatMemberByIndex(CSteamID* __return, CSteamID steamIDClan, int iUser)
        {
            return 0;
        }

        public bool SendClanChatMessage(CSteamID steamIDClanChat, char8* pchText)
        {
            return false;
        }

        public int GetClanChatMessage(CSteamID steamIDClanChat, int iMessage, void* prgchText, int cchTextMax, ChatEntryType* peChatEntryType, CSteamID* psteamidChatter)
        {
            return 0;
        }

        public bool IsClanChatAdmin(CSteamID steamIDClanChat, CSteamID steamIDUser)
        {
            return false;
        }

        public bool IsClanChatWindowOpenInSteam(CSteamID steamIDClanChat)
        {
            return false;
        }

        public bool OpenClanChatWindowInSteam(CSteamID steamIDClanChat)
        {
            return false;
        }

        public bool CloseClanChatWindowInSteam(CSteamID steamIDClanChat)
        {
            return false;
        }

        public bool SetListenForFriendsMessages(bool bInterceptEnabled)
        {
            return false;
        }

        public bool ReplyToFriendMessage(CSteamID steamIDFriend, char8* pchMsgToSend)
        {
            return false;
        }

        public int GetFriendMessage(CSteamID steamIDFriend, int iMessageID, void* pvData, int cubData, ChatEntryType* peChatEntryType)
        {
            return 0;
        }

        public SteamAPICall GetFollowerCount(CSteamID steamID)
        {
            return 0;
        }

        public SteamAPICall IsFollowing(CSteamID steamID)
        {
            return 0;
        }

        public SteamAPICall EnumerateFollowingList(uint32 unStartIndex)
        {
            return 0;
        }

        public bool IsClanPublic(CSteamID steamIDClan)
        {
            return false;
        }

        public bool IsClanOfficialGameGroup(CSteamID steamIDClan)
        {
            return false;
        }
    }    
}