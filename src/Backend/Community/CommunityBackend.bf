using RfgNetworking.API;
using System;
using RfgNetworking.Misc;
using System.Collections;

namespace RfgNetworking.Backend.Community
{
    //Standalone DLL that connects to a community made master server
    public class CommunityBackend : IDLLBackend
    {
        //The game stores all its interface pointers in this
        public static CSteamAPIContext Context;

        //Interfaces exposed by the DLL. Some user the interfaces directly since they aren't implemented yet.
        public static CClient Client;
        public static CUser User;
        public static CFriends Friends;
        public static CUtils Utils;
        public static CMatchmaking Matchmaking;
        public static CUserStats UserStats;
        public static CApps Apps;
        public static CNetworking Networking;
        public static CRemoteStorage RemoteStorage;
        public static CController Controller;

        /*typealias CallbackFunc = function void(void* data);
        typealias CallResultFunc = function void(void* data, bool param1, SteamAPICall apiCall);*/

        typealias LobbyCreatedCallResultFunc = function void(LobbyCreated* data, bool param1, SteamAPICall apiCall);
        /*public List<LobbyCreatedCallResultFunc> LobbyCreatedCallResults = new .() ~delete _;*/
        public List<CCallbackBase*> LobbyCreatedCallResults = new .() ~delete _;
        public List<CCallbackBase*> LobbyEnterCallbacks = new .() ~delete _;
        public List<CCallbackBase*> LobbyDataUpdateCallbacks = new .() ~delete _;

        void IDLLBackend.Init()
        {
            Client.ModuleInit();
            User.ModuleInit();
            Friends.ModuleInit();
            Utils.ModuleInit();
            Matchmaking.ModuleInit();
            UserStats.ModuleInit();
            Apps.ModuleInit();
            Networking.ModuleInit();
            RemoteStorage.ModuleInit();
            Controller.ModuleInit();
        }

        void IDLLBackend.Shutdown()
        {
            Client.ModuleShutdown();
            User.ModuleShutdown();
            Friends.ModuleShutdown();
            Utils.ModuleShutdown();
            Matchmaking.ModuleShutdown();
            UserStats.ModuleShutdown();
            Apps.ModuleShutdown();
            Networking.ModuleShutdown();
            RemoteStorage.ModuleShutdown();
            Controller.ModuleShutdown();
        }

        bool IDLLBackend.SW_CCSys_Init()
        {
            return true;
        }

        ISteamClient* IDLLBackend.SW_CCSys_CreateInternalModule(char8* interfaceName)
        {
            return &Client;
        }

        CSteamAPIContext* IDLLBackend.SW_CCSys_DynamicInit(CallbackCounterAndContext* callbackCounterAndContext)
        {
            if (callbackCounterAndContext.Counter == 0)
            {
                callbackCounterAndContext.Context = &Context;
                callbackCounterAndContext.InitCallback(callbackCounterAndContext.Context);
            }

            callbackCounterAndContext.Counter++;
            return callbackCounterAndContext.Context;
        }

        void IDLLBackend.SW_CCSys_GetP()
        {

        }

        HSteamPipe IDLLBackend.SW_CCSys_GetPInterface()
        {
            return (HSteamPipe)1;
        }

        void IDLLBackend.SW_CCSys_GetU()
        {

        }

        HSteamUser IDLLBackend.SW_CCSys_GetUInterface()
        {
            return (HSteamUser)1;
        }

        void IDLLBackend.SW_CCSys_InitCallbackFunc(CCallbackBase* callback, CallbackType callbackId)
        {
            switch (callbackId)
			{
                case .ValidateAuthTicketResponse:

                case .GetAuthSessionTicketResponse:

                case .GameLobbyJoinRequested:

                case .LobbyEnter:
                    LobbyEnterCallbacks.Add(callback);

                case .LobbyDataUpdate:
                    LobbyDataUpdateCallbacks.Add(callback);

                case .LobbyChatUpdate:

                case .SteamUserStatsReceived:

                case .SteamUserStatsStored:

                case .SteamUserAchievementStored:

                case .P2PSessionRequest:

                default:
                    String errorMessage = scope $"Unsupported callback ID '{(i32)callbackId}' in CommunityBackend.SW_CCSys_InitCallbackFunc()";
                    Logger.WriteLine(errorMessage);
                    Runtime.FatalError(errorMessage);
			}
        }

        void IDLLBackend.SW_CCSys_RemoveCallbackFunc(CCallbackBase* callback)
        {

        }

        void IDLLBackend.SW_CCSys_IsBackendActive()
        {

        }

        void IDLLBackend.SW_CCSys_ProcessApiCb()
        {
            CSteamID fakeSteamLobbyId = (CSteamID)81064793292695571;
            //CSteamID fakeSelfSteamId = (CSteamID)83805435213237740;

            if (Matchmaking.LobbyCreationRequests != null)
            {
                for (var lobbyCreationRequest in Matchmaking.LobbyCreationRequests)
                {
                    for (CCallbackBase* lobbyCreationCallback in LobbyCreatedCallResults)
                    {
                        LobbyCreated lobbyCreationData = .();
                        lobbyCreationData.Result = .OK;
                        lobbyCreationData.SteamIDLobby = (u64)fakeSteamLobbyId;
                        Logger.WriteLine("Running LobbyCreated CallResult");
                        lobbyCreationCallback.Vfptr.Run(lobbyCreationCallback, (void*)&lobbyCreationData, 0, (u64)lobbyCreationRequest.ApiCall);
                        Logger.WriteLine("$$$Ending LobbyCreated CallResult\n");
                        //lobbyCreationCallback.Vfptr.Run2(lobbyCreationCallback, (void*)&lobbyCreationData);//, 0, (u64)lobbyCreationRequest.ApiCall);
                    }

                    //Auto enter the lobby when one is created. May not exactly match vanilla behavior since that possibly involves getting server confirmation first.
                    //For now this suffices as a test of concept
                    for (CCallbackBase* lobbyEnterCallback in LobbyEnterCallbacks)
                    {
                        LobbyEnter enterData = .();
                        enterData.SteamIDLobby = (u64)fakeSteamLobbyId;
                        enterData.ChatPermissions = 2949229;
                        enterData.Blocked = true;
                        enterData.ChatRoomEnterResponse = 1;
                        Logger.WriteLine("Running LobbyEntered Callback");
                        lobbyEnterCallback.Vfptr.Run2(lobbyEnterCallback, &enterData);
                        Logger.WriteLine("$$$Ending LobbyEntered Callback\n");
                    }

                    for (CCallbackBase* lobbyDataUpdateCallback in LobbyDataUpdateCallbacks)
                    {
                        LobbyDataUpdate updateData = .();
                        updateData.SteamIDLobby = (u64)fakeSteamLobbyId;
                        //TODO: Figure out why this wouldn't be the name of the player who is a member. For some reason game passes the lobby ID for both params here in vanilla
                        updateData.SteamIDMember = (u64)fakeSteamLobbyId;//(u64)fakeSelfSteamId;
                        updateData.Success = true;
                        Logger.WriteLine("Running LobbyDataUpdate Callback");
                        lobbyDataUpdateCallback.Vfptr.Run2(lobbyDataUpdateCallback, &updateData);
                        Logger.WriteLine("$$$Ending LobbyDataUpdate Callback\n");
                    }
                }
                Matchmaking.LobbyCreationRequests.Clear();
            }
        }

        void IDLLBackend.SW_CCSys_RegisterCallResult(CCallbackBase* callbackResult, uint32 apiCallHandleLower, uint32 apiCallHandleUpper)
        {
            switch (callbackResult.CallResultType)
            {
                case .LobbyEnter:


                case .LobbyMatchList:


                case .LobbyCreated:
                    LobbyCreatedCallResults.Add(callbackResult);

                default:
                    String errorMessage = scope $"Unsupported callback ID '{(i32)callbackResult.CallResultType}' in CommunityBackend.SW_CCSys_RegisterCallResult()";
                    Logger.WriteLine(errorMessage);
                    Runtime.FatalError(errorMessage);
            }
        }

        void IDLLBackend.SW_CCSys_UnregisterCallResult(CCallbackBase* callbackResult, uint32 apiCallHandleLower, uint32 apiCallHandleUpper)
        {

        }

        void IDLLBackend.SW_CCSys_Shutdown()
        {

        }

        void IDLLBackend.SW_CCSys_TestInitialConditions()
        {

        }

        bool IDLLBackend.SW_HasAchievements()
        {
            return false;
        }

        bool IDLLBackend.SW_HasInvites()
        {
            return false;
        }

        bool IDLLBackend.SW_HasLeaderboards()
        {
            return false;
        }

        void IDLLBackend.SW_RegisterCallback()
        {

        }

        void IDLLBackend.SW_UnregisterCallback()
        {

        }
    }
}