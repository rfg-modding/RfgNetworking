#pragma once
#include "Typedefs.h"
#include "Backend/BackendData.h"

class IBackend
{
public:
    virtual ~IBackend() { }

    //Functions exposed by the DLL
    virtual bool SW_CCSys_Init() = 0;
    virtual ISteamClient* SW_CCSys_CreateInternalModule(const char* interfaceName) = 0;
    virtual CSteamAPIContext* SW_CCSys_DynamicInit(CallbackCounterAndContext* callbackCounterAndContext) = 0;
    virtual void SW_CCSys_GetP() = 0;
    virtual HSteamPipe SW_CCSys_GetPInterface() = 0;
    virtual void SW_CCSys_GetU() = 0;
    virtual HSteamUser SW_CCSys_GetUInterface() = 0;
    virtual void SW_CCSys_InitCallbackFunc(CCallbackBase* callback, CallbackType callbackId) = 0;
    virtual void SW_CCSys_RemoveCallbackFunc(CCallbackBase* callback) = 0;
    virtual void SW_CCSys_IsBackendActive() = 0;
    virtual void SW_CCSys_ProcessApiCb() = 0;
    virtual void SW_CCSys_RegisterCallResult(CCallbackBase* callbackResult, u32 apiCallHandleLower, u32 apiCallHandleUpper) = 0;
    virtual void SW_CCSys_UnregisterCallResult(CCallbackBase* callbackResult, u32 apiCallHandleLower, u32 apiCallHandleUpper) = 0;
    virtual void SW_CCSys_Shutdown() = 0;
    virtual void SW_CCSys_TestInitialConditions() = 0;
    virtual bool SW_HasAchievements() = 0;
    virtual bool SW_HasInvites() = 0;
    virtual bool SW_HasLeaderboards() = 0;
    virtual void SW_RegisterCallback() = 0;
    virtual void SW_UnregisterCallback() = 0;
};