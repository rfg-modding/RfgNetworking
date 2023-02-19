using RfgNetworking.API;

namespace RfgNetworking.Backend.Community
{
    public struct CMatchmaking : ISteamMatchmaking
    {
        public void ModuleInit() mut
        {
            Vtable = new ISteamMatchmaking.VTable();
            Vtable.GetFavoriteGameCount = => GetFavoriteGameCount;
            Vtable.GetFavoriteGame = => GetFavoriteGame;
            Vtable.AddFavoriteGame = => AddFavoriteGame;
            Vtable.RemoveFavoriteGame = => RemoveFavoriteGame;
            Vtable.RequestLobbyList = => RequestLobbyList;
            Vtable.AddRequestLobbyListStringFilter = => AddRequestLobbyListStringFilter;
            Vtable.AddRequestLobbyListNumericalFilter = => AddRequestLobbyListNumericalFilter;
            Vtable.AddRequestLobbyListNearValueFilter = => AddRequestLobbyListNearValueFilter;
            Vtable.AddRequestLobbyListFilterSlotsAvailable = => AddRequestLobbyListFilterSlotsAvailable;
            Vtable.AddRequestLobbyListDistanceFilter = => AddRequestLobbyListDistanceFilter;
            Vtable.AddRequestLobbyListResultCountFilter = => AddRequestLobbyListResultCountFilter;
            Vtable.AddRequestLobbyListCompatibleMembersFilter = => AddRequestLobbyListCompatibleMembersFilter;
            Vtable.GetLobbyByIndex = => GetLobbyByIndex;
            Vtable.CreateLobby = => CreateLobby;
            Vtable.JoinLobby = => JoinLobby;
            Vtable.LeaveLobby = => LeaveLobby;
            Vtable.InviteUserToLobby = => InviteUserToLobby;
            Vtable.GetNumLobbyMembers = => GetNumLobbyMembers;
            Vtable.GetLobbyMemberByIndex = => GetLobbyMemberByIndex;
            Vtable.GetLobbyData = => GetLobbyData;
            Vtable.SetLobbyData = => SetLobbyData;
            Vtable.GetLobbyDataCount = => GetLobbyDataCount;
            Vtable.GetLobbyDataByIndex = => GetLobbyDataByIndex;
            Vtable.DeleteLobbyData = => DeleteLobbyData;
            Vtable.GetLobbyMemberData = => GetLobbyMemberData;
            Vtable.SetLobbyMemberData = => SetLobbyMemberData;
            Vtable.SendLobbyChatMsg = => SendLobbyChatMsg;
            Vtable.GetLobbyChatEntry = => GetLobbyChatEntry;
            Vtable.RequestLobbyData = => RequestLobbyData;
            Vtable.SetLobbyGameServer = => SetLobbyGameServer;
            Vtable.GetLobbyGameServer = => GetLobbyGameServer;
            Vtable.SetLobbyMemberLimit = => SetLobbyMemberLimit;
            Vtable.GetLobbyMemberLimit = => GetLobbyMemberLimit;
            Vtable.SetLobbyType = => SetLobbyType;
            Vtable.SetLobbyJoinable = => SetLobbyJoinable;
            Vtable.GetLobbyOwner = => GetLobbyOwner;
            Vtable.SetLobbyOwner = => SetLobbyOwner;
            Vtable.SetLinkedLobby = => SetLinkedLobby;
        }

        public void ModuleShutdown()
        {
            delete Vtable;
        }

        public int GetFavoriteGameCount()
        {
            return 0;
        }

        public bool GetFavoriteGame(int iGame, AppId* pnAppID, uint32* pnIP, uint16* pnConnPort, uint16* pnQueryPort, uint32* punFlags, uint32* pRTime32LastPlayedOnServer)
        {
            return false;
        }

        public int AddFavoriteGame(AppId nAppID, uint32 nIP, uint16 nConnPort, uint16 nQueryPort, uint32 unFlags, uint32 rTime32LastPlayedOnServer)
        {
            return 0;
        }

        public bool RemoveFavoriteGame(AppId nAppID, uint32 nIP, uint16 nConnPort, uint16 nQueryPort, uint32 unFlags)
        {
            return false;
        }

        public SteamAPICall RequestLobbyList()
        {
            return 0;
        }

        public void AddRequestLobbyListStringFilter(char8* pchKeyToMatch, char8* pchValueToMatch, LobbyComparison eComparisonType)
        {

        }

        public void AddRequestLobbyListNumericalFilter(char8* pchKeyToMatch, int nValueToMatch, LobbyComparison eComparisonType)
        {

        }

        public void AddRequestLobbyListNearValueFilter(char8* pchKeyToMatch, int nValueToBeCloseTo)
        {

        }

        public void AddRequestLobbyListFilterSlotsAvailable(int nSlotsAvailable)
        {

        }

        public void AddRequestLobbyListDistanceFilter(LobbyDistanceFilter eLobbyDistanceFilter)
        {

        }

        public void AddRequestLobbyListResultCountFilter(int cMaxResults)
        {

        }

        public void AddRequestLobbyListCompatibleMembersFilter(CSteamID steamIDLobby)
        {

        }

        public CSteamID* GetLobbyByIndex(CSteamID* __return, int nLobby)
        {
            return null;
        }

        public SteamAPICall CreateLobby(LobbyType eLobbyType, int cMaxMembers)
        {
            return 0;
        }

        public SteamAPICall JoinLobby(CSteamID steamIDLobby)
        {
            return 0;
        }

        public void LeaveLobby(CSteamID steamIDLobby)
        {

        }

        public bool InviteUserToLobby(CSteamID steamIDLobby, CSteamID steamIDInvitee)
        {
            return false;
        }

        public int GetNumLobbyMembers(CSteamID steamIDLobby)
        {
            return 0;
        }

        public CSteamID GetLobbyMemberByIndex(CSteamID* __return, CSteamID steamIDLobby, int iMember)
        {
            return 0;
        }

        public char8* GetLobbyData(CSteamID steamIDLobby, char8* pchKey)
        {
            return null;
        }

        public bool SetLobbyData(CSteamID steamIDLobby, char8* pchKey, char8* pchValue)
        {
            return false;
        }

        public int GetLobbyDataCount(CSteamID steamIDLobby)
        {
            return 0;
        }

        public bool GetLobbyDataByIndex(CSteamID steamIDLobby, int iLobbyData, char8* pchKey, int cchKeyBufferSize, char8* pchValue, int cchValueBufferSize)
        {
            return false;
        }

        public bool DeleteLobbyData(CSteamID steamIDLobby, char8* pchKey)
        {
            return false;
        }

        public char8* GetLobbyMemberData(CSteamID steamIDLobby, CSteamID steamIDUser, char8* pchKey)
        {
            return null;
        }

        public void SetLobbyMemberData(CSteamID steamIDLobby, char8* pchKey, char8* pchValue)
        {

        }

        public bool SendLobbyChatMsg(CSteamID steamIDLobby, void* pvMsgBody, int cubMsgBody)
        {
            return false;
        }

        public int GetLobbyChatEntry(CSteamID steamIDLobby, int iChatID, CSteamID* pSteamIDUser, void* pvData, int cubData, ChatEntryType* peChatEntryType)
        {
            return 0;
        }

        public bool RequestLobbyData(CSteamID steamIDLobby)
        {
            return false;
        }

        public void SetLobbyGameServer(CSteamID steamIDLobby, uint32 unGameServerIP, uint16 unGameServerPort, CSteamID steamIDGameServer)
        {

        }

        public bool GetLobbyGameServer(CSteamID steamIDLobby, uint32* punGameServerIP, uint16* punGameServerPort, CSteamID* psteamIDGameServer)
        {
            return false;
        }

        public bool SetLobbyMemberLimit(CSteamID steamIDLobby, int cMaxMembers)
        {
            return false;
        }

        public int GetLobbyMemberLimit(CSteamID steamIDLobby)
        {
            return 0;
        }

        public bool SetLobbyType(CSteamID steamIDLobby, LobbyType eLobbyType)
        {
            return false;
        }

        public bool SetLobbyJoinable(CSteamID steamIDLobby, bool bLobbyJoinable)
        {
            return false;
        }

        public CSteamID GetLobbyOwner(CSteamID* __return, CSteamID steamIDLobby)
        {
            return 0;
        }

        public bool SetLobbyOwner(CSteamID steamIDLobby, CSteamID steamIDNewOwner)
        {
            return false;
        }

        public bool SetLinkedLobby(CSteamID steamIDLobby, CSteamID steamIDLobbyDependent)
        {
            return false;
        }
    }    
}