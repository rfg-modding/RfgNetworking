using RfgNetworking.Misc;
using RfgNetworking.API;
using System;
using System.Collections;

namespace RfgNetworking.Backend.Community
{
    public struct CMatchmaking : ISteamMatchmaking
    {
        public List<LobbyCreationRequest> LobbyCreationRequests = null;

        public struct LobbyCreationRequest
        {
            public SteamAPICall ApiCall;
            public LobbyType LobbyType;
            public int MaxMembers;

            public this(SteamAPICall apiCall, LobbyType lobbyType, int maxMembers)
            {
                this.ApiCall = apiCall;
                this.LobbyType = lobbyType;
                this.MaxMembers = maxMembers;
            }
        }

        [DebugLog]
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

            LobbyCreationRequests = new .();
        }

        [DebugLog]
        public void ModuleShutdown()
        {
            delete LobbyCreationRequests;

            delete Vtable;
        }

        [DebugLog]
        public int GetFavoriteGameCount()
        {
            return 0;
        }

        [DebugLog]
        public bool GetFavoriteGame(int iGame, AppId* pnAppID, uint32* pnIP, uint16* pnConnPort, uint16* pnQueryPort, uint32* punFlags, uint32* pRTime32LastPlayedOnServer)
        {
            return false;
        }

        [DebugLog]
        public int AddFavoriteGame(AppId nAppID, uint32 nIP, uint16 nConnPort, uint16 nQueryPort, uint32 unFlags, uint32 rTime32LastPlayedOnServer)
        {
            return 0;
        }

        [DebugLog]
        public bool RemoveFavoriteGame(AppId nAppID, uint32 nIP, uint16 nConnPort, uint16 nQueryPort, uint32 unFlags)
        {
            return false;
        }

        [DebugLog]
        public SteamAPICall RequestLobbyList()
        {
            return 0;
        }

        [DebugLog]
        public void AddRequestLobbyListStringFilter(char8* pchKeyToMatch, char8* pchValueToMatch, LobbyComparison eComparisonType)
        {

        }

        [DebugLog]
        public void AddRequestLobbyListNumericalFilter(char8* pchKeyToMatch, int nValueToMatch, LobbyComparison eComparisonType)
        {

        }

        [DebugLog]
        public void AddRequestLobbyListNearValueFilter(char8* pchKeyToMatch, int nValueToBeCloseTo)
        {

        }

        [DebugLog]
        public void AddRequestLobbyListFilterSlotsAvailable(int nSlotsAvailable)
        {

        }

        [DebugLog]
        public void AddRequestLobbyListDistanceFilter(LobbyDistanceFilter eLobbyDistanceFilter)
        {

        }

        [DebugLog]
        public void AddRequestLobbyListResultCountFilter(int cMaxResults)
        {

        }

        [DebugLog]
        public void AddRequestLobbyListCompatibleMembersFilter(CSteamID steamIDLobby)
        {

        }

        [DebugLog]
        public CSteamID* GetLobbyByIndex(CSteamID* __return, int nLobby)
        {
            return null;
        }

        [DebugLog]
        public SteamAPICall CreateLobby(LobbyType eLobbyType, int cMaxMembers)
        {
            SteamAPICall apiCall = SteamAPICall.GetNext();
            LobbyCreationRequests.Add(.(apiCall, eLobbyType, cMaxMembers));
            return apiCall;
        }

        [DebugLog]
        public SteamAPICall JoinLobby(CSteamID steamIDLobby)
        {
            return 0;
        }

        [DebugLog]
        public void LeaveLobby(CSteamID steamIDLobby)
        {

        }

        [DebugLog]
        public bool InviteUserToLobby(CSteamID steamIDLobby, CSteamID steamIDInvitee)
        {
            return false;
        }

        [DebugLog]
        public int GetNumLobbyMembers(CSteamID steamIDLobby)
        {
            return 1; //TODO: De-hardcode
        }

        [DebugLog]
        public CSteamID GetLobbyMemberByIndex(CSteamID* __return, CSteamID steamIDLobby, int iMember)
        {
            //TODO: De-hardcode and actually record members and their IDs
            //return (CSteamID)83805435213237740;

            //For some reason this differs from the actual players id in vanilla. I guess maybe you have a personal ID + a lobby member ID?
            //TODO: Figure out why
            return (CSteamID)83129647636540704;
        }

        [DebugLog]
        public char8* GetLobbyData(CSteamID steamIDLobby, char8* pchKey)
        {
            if (String.Equals(pchKey, "lobby_id"))
            {
                return "";
            }
            else
            {
                return "UnknownLobbyDataKey!!!";
            }
            //return null;
        }

        [DebugLog]
        public bool SetLobbyData(CSteamID steamIDLobby, char8* pchKey, char8* pchValue)
        {
            return true;
        }

        [DebugLog]
        public int GetLobbyDataCount(CSteamID steamIDLobby)
        {
            return 0;
        }

        [DebugLog]
        public bool GetLobbyDataByIndex(CSteamID steamIDLobby, int iLobbyData, char8* pchKey, int cchKeyBufferSize, char8* pchValue, int cchValueBufferSize)
        {
            return false;
        }

        [DebugLog]
        public bool DeleteLobbyData(CSteamID steamIDLobby, char8* pchKey)
        {
            return false;
        }

        [DebugLog]
        public char8* GetLobbyMemberData(CSteamID steamIDLobby, CSteamID steamIDUser, char8* pchKey)
        {
            return null;
        }

        [DebugLog]
        public void SetLobbyMemberData(CSteamID steamIDLobby, char8* pchKey, char8* pchValue)
        {

        }

        [DebugLog]
        public bool SendLobbyChatMsg(CSteamID steamIDLobby, void* pvMsgBody, int cubMsgBody)
        {
            return false;
        }

        [DebugLog]
        public int GetLobbyChatEntry(CSteamID steamIDLobby, int iChatID, CSteamID* pSteamIDUser, void* pvData, int cubData, ChatEntryType* peChatEntryType)
        {
            return 0;
        }

        [DebugLog]
        public bool RequestLobbyData(CSteamID steamIDLobby)
        {
            return false;
        }

        [DebugLog]
        public void SetLobbyGameServer(CSteamID steamIDLobby, uint32 unGameServerIP, uint16 unGameServerPort, CSteamID steamIDGameServer)
        {

        }

        [DebugLog]
        public bool GetLobbyGameServer(CSteamID steamIDLobby, uint32* punGameServerIP, uint16* punGameServerPort, CSteamID* psteamIDGameServer)
        {
            return false;
        }

        [DebugLog]
        public bool SetLobbyMemberLimit(CSteamID steamIDLobby, int cMaxMembers)
        {
            return false;
        }

        [DebugLog]
        public int GetLobbyMemberLimit(CSteamID steamIDLobby)
        {
            return 0;
        }

        [DebugLog]
        public bool SetLobbyType(CSteamID steamIDLobby, LobbyType eLobbyType)
        {
            return false;
        }

        [DebugLog]
        public bool SetLobbyJoinable(CSteamID steamIDLobby, bool bLobbyJoinable)
        {
            return false;
        }

        [DebugLog]
        public CSteamID GetLobbyOwner(CSteamID* __return, CSteamID steamIDLobby)
        {
            //TODO: De-hardcode and actually record owners of each lobby
            //return (CSteamID)83805435213237740;

            //TODO: Figure out how this works
            //Based on logged vanilla data. For some reason the owner id is different from the player ID even if you're the only one in the lobby. Maybe this ID is hardcoded for the THQN server?

            *__return = CUser.SteamID;

            return (CSteamID)342836523205258536;
        }

        [DebugLog]
        public bool SetLobbyOwner(CSteamID steamIDLobby, CSteamID steamIDNewOwner)
        {
            return false;
        }

        [DebugLog]
        public bool SetLinkedLobby(CSteamID steamIDLobby, CSteamID steamIDLobbyDependent)
        {
            return false;
        }
    }    
}