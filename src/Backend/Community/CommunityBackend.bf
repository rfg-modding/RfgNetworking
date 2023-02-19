using RfgNetworking.API;
using System;

namespace RfgNetworking.Backend.Community
{
    //Standalone DLL that connects to a community made master server
    public class CommunityBackend : IDLLBackend
    {
        void IDLLBackend.Init()
        {
            
        }

        void IDLLBackend.Shutdown()
        {

        }

        bool IDLLBackend.SW_CCSys_Init()
        {
            return true;
        }

        ISteamClient* IDLLBackend.SW_CCSys_CreateInternalModule(char8* interfaceName)
        {
            return null;
        }

        CSteamAPIContext* IDLLBackend.SW_CCSys_DynamicInit(CallbackCounterAndContext* callbackCounterAndContext)
        {
            return null;
        }

        void IDLLBackend.SW_CCSys_GetP()
        {

        }

        HSteamPipe IDLLBackend.SW_CCSys_GetPInterface()
        {
            return 0;
        }

        void IDLLBackend.SW_CCSys_GetU()
        {

        }

        HSteamUser IDLLBackend.SW_CCSys_GetUInterface()
        {
            return 0;
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