using RfgNetworking.API;
using System;

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

        void IDLLBackend.SW_CCSys_InitCallbackFunc(void* callbackFunc, int32 callbackId)
        {

        }

        void IDLLBackend.SW_CCSys_RemoveCallbackFunc(void* callbackFunc)
        {

        }

        void IDLLBackend.SW_CCSys_IsBackendActive()
        {

        }

        void IDLLBackend.SW_CCSys_ProcessApiCb()
        {

        }

        void IDLLBackend.SW_CCSys_RegisterCallResult(CCallbackBase* callbackResult, uint32 apiCallHandleLower, uint32 apiCallHandleUpper)
        {

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