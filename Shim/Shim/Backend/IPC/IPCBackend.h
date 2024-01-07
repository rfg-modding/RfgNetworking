#pragma once
#include "Typedefs.h"
#include "IBackend.h"
#include <Windows.h>

class IPCBackend : public IBackend
{
public:
    IPCBackend();
    virtual ~IPCBackend() override;
    virtual bool SW_CCSys_Init() override;
    virtual ISteamClient* SW_CCSys_CreateInternalModule(const char* interfaceName) override;
    virtual CSteamAPIContext* SW_CCSys_DynamicInit(CallbackCounterAndContext* callbackCounterAndContext) override;
    virtual void SW_CCSys_GetP() override;
    virtual HSteamPipe SW_CCSys_GetPInterface() override;
    virtual void SW_CCSys_GetU() override;
    virtual HSteamUser SW_CCSys_GetUInterface() override;
    virtual void SW_CCSys_InitCallbackFunc(CCallbackBase* callback, CallbackType callbackId) override;
    virtual void SW_CCSys_RemoveCallbackFunc(CCallbackBase* callback) override;
    virtual void SW_CCSys_IsBackendActive() override;
    virtual void SW_CCSys_ProcessApiCb() override;
    virtual void SW_CCSys_RegisterCallResult(CCallbackBase* callbackResult, u32 apiCallHandleLower, u32 apiCallHandleUpper) override;
    virtual void SW_CCSys_UnregisterCallResult(CCallbackBase* callbackResult, u32 apiCallHandleLower, u32 apiCallHandleUpper) override;
    virtual void SW_CCSys_Shutdown() override;
    virtual void SW_CCSys_TestInitialConditions() override;
    virtual bool SW_HasAchievements() override;
    virtual bool SW_HasInvites() override;
    virtual bool SW_HasLeaderboards() override;
    virtual void SW_RegisterCallback() override;
    virtual void SW_UnregisterCallback() override;
};