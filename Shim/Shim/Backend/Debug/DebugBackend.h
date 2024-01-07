#pragma once
#include "Typedefs.h"
#include "IBackend.h"
#include <Windows.h>

class DebugBackend : public IBackend
{
public:
    DebugBackend(HINSTANCE dllHandle);
    ~DebugBackend() override;
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

private:
    HINSTANCE _dllHandle = 0;
    HINSTANCE _originalDLLHandle = 0;

    bool(__cdecl* SW_CCSys_Init_Original)(void) = nullptr;
    ISteamClient*(__cdecl* SW_CCSys_CreateInternalModule_Original)(const char* interfaceVersion) = nullptr;
    CSteamAPIContext*(__cdecl* SW_CCSys_DynamicInit_Original)(CallbackCounterAndContext* callbackCounterAndContext) = nullptr;
    void(__cdecl* SW_CCSys_GetP_Original)(void) = nullptr;
    HSteamPipe(__cdecl* SW_CCSys_GetPInterface_Original)(void) = nullptr;
    void(__cdecl* SW_CCSys_GetU_Original)(void) = nullptr;
    HSteamUser(__cdecl* SW_CCSys_GetUInterface_Original)(void) = nullptr;
    void(__cdecl* SW_CCSys_InitCallbackFunc_Original)(CCallbackBase* callback, CallbackType callbackId) = nullptr;
    void(__cdecl* SW_CCSys_RemoveCallbackFunc_Original)(CCallbackBase* callback) = nullptr;
    void(__cdecl* SW_CCSys_IsBackendActive_Original)(void) = nullptr;
    void(__cdecl* SW_CCSys_ProcessApiCb_Original)(void) = nullptr;
    void(__cdecl* SW_CCSys_RegisterCallResult_Original)(CCallbackBase* callbackResult, u32 apiCallHandleLower, u32 apiCallHandleUpper) = nullptr;
    void(__cdecl* SW_CCSys_UnregisterCallResult_Original)(CCallbackBase* callbackResult, u32 apiCallHandleLower, u32 apiCallHandleUpper) = nullptr;
    void(__cdecl* SW_CCSys_Shutdown_Original)(void) = nullptr;
    void(__cdecl* SW_CCSys_TestInitialConditions_Original)(void) = nullptr;
    bool(__cdecl* SW_HasAchievements_Original)(void) = nullptr;
    bool(__cdecl* SW_HasInvites_Original)(void) = nullptr;
    bool(__cdecl* SW_HasLeaderboards_Original)(void) = nullptr;
    void(__cdecl* SW_RegisterCallback_Original)(void) = nullptr;
    void(__cdecl* SW_UnregisterCallback_Original)(void) = nullptr;
};