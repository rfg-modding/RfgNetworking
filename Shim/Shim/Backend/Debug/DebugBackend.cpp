#include "DebugBackend.h"
#include <stdexcept>

template <typename T>
static T GetDLLFunction(HINSTANCE dllHandle, const char* functionName)
{
    return reinterpret_cast<T>(GetProcAddress(dllHandle, functionName));
}

DebugBackend::DebugBackend(HINSTANCE dllHandle)
{
    _dllHandle = dllHandle;
    _originalDLLHandle = LoadLibrary("sw_api.original.dll");
    if (!_originalDLLHandle)
        throw std::runtime_error("Failed to laod sw_api.original.dll. Make sure it's present in your RFGR folder.");

    //Load function pointers for original functions so wrappers can call them
#define GetOriginalFunction(functionVariable, functionName) functionVariable = GetDLLFunction<decltype(functionVariable)>(_originalDLLHandle, functionName)
    GetOriginalFunction(SW_CCSys_Init_Original, "SW_CCSys_Init");
    GetOriginalFunction(SW_CCSys_CreateInternalModule_Original, "SW_CCSys_CreateInternalModule");
    GetOriginalFunction(SW_CCSys_DynamicInit_Original, "SW_CCSys_DynamicInit");
    GetOriginalFunction(SW_CCSys_GetP_Original, "SW_CCSys_GetP");
    GetOriginalFunction(SW_CCSys_GetPInterface_Original, "SW_CCSys_GetPInterface");
    GetOriginalFunction(SW_CCSys_GetU_Original, "SW_CCSys_GetU");
    GetOriginalFunction(SW_CCSys_GetUInterface_Original, "SW_CCSys_GetUInterface");
    GetOriginalFunction(SW_CCSys_InitCallbackFunc_Original, "SW_CCSys_InitCallbackFunc");
    GetOriginalFunction(SW_CCSys_RemoveCallbackFunc_Original, "SW_CCSys_RemoveCallbackFunc");
    GetOriginalFunction(SW_CCSys_IsBackendActive_Original, "SW_CCSys_IsBackendActive");
    GetOriginalFunction(SW_CCSys_ProcessApiCb_Original, "SW_CCSys_ProcessApiCb");
    GetOriginalFunction(SW_CCSys_RegisterCallResult_Original, "SW_CCSys_RegisterCallResult");
    GetOriginalFunction(SW_CCSys_UnregisterCallResult_Original, "SW_CCSys_UnregisterCallResult");
    GetOriginalFunction(SW_CCSys_Shutdown_Original, "SW_CCSys_Shutdown");
    GetOriginalFunction(SW_CCSys_TestInitialConditions_Original, "SW_CCSys_TestInitialConditions");
    GetOriginalFunction(SW_HasAchievements_Original, "SW_HasAchievements");
    GetOriginalFunction(SW_HasInvites_Original, "SW_HasInvites");
    GetOriginalFunction(SW_HasLeaderboards_Original, "SW_HasLeaderboards");
    GetOriginalFunction(SW_RegisterCallback_Original, "SW_RegisterCallback");
    GetOriginalFunction(SW_UnregisterCallback_Original, "SW_UnregisterCallback");
}

DebugBackend::~DebugBackend()
{
    FreeLibrary(_originalDLLHandle);
}

bool DebugBackend::SW_CCSys_Init()
{
    return SW_CCSys_Init_Original();
}

ISteamClient* DebugBackend::SW_CCSys_CreateInternalModule(const char* interfaceName)
{
    return SW_CCSys_CreateInternalModule_Original(interfaceName);
}

CSteamAPIContext* DebugBackend::SW_CCSys_DynamicInit(CallbackCounterAndContext* callbackCounterAndContext)
{
    return SW_CCSys_DynamicInit_Original(callbackCounterAndContext);
}

void DebugBackend::SW_CCSys_GetP()
{
    SW_CCSys_GetP_Original();
}

HSteamPipe DebugBackend::SW_CCSys_GetPInterface()
{
    return SW_CCSys_GetPInterface_Original();
}

void DebugBackend::SW_CCSys_GetU()
{
    SW_CCSys_GetU_Original();
}

HSteamUser DebugBackend::SW_CCSys_GetUInterface()
{
    return SW_CCSys_GetUInterface_Original();
}

void DebugBackend::SW_CCSys_InitCallbackFunc(CCallbackBase* callback, CallbackType callbackId)
{
    SW_CCSys_InitCallbackFunc_Original(callback, callbackId);
}

void DebugBackend::SW_CCSys_RemoveCallbackFunc(CCallbackBase* callback)
{
    SW_CCSys_RemoveCallbackFunc_Original(callback);
}

void DebugBackend::SW_CCSys_IsBackendActive()
{
    SW_CCSys_IsBackendActive_Original();
}

void DebugBackend::SW_CCSys_ProcessApiCb()
{
    SW_CCSys_ProcessApiCb_Original();
}

void DebugBackend::SW_CCSys_RegisterCallResult(CCallbackBase* callbackResult, u32 apiCallHandleLower, u32 apiCallHandleUpper)
{
    SW_CCSys_RegisterCallResult_Original(callbackResult, apiCallHandleLower, apiCallHandleUpper);
}

void DebugBackend::SW_CCSys_UnregisterCallResult(CCallbackBase* callbackResult, u32 apiCallHandleLower, u32 apiCallHandleUpper)
{
    SW_CCSys_UnregisterCallResult_Original(callbackResult, apiCallHandleLower, apiCallHandleUpper);
}

void DebugBackend::SW_CCSys_Shutdown()
{
    SW_CCSys_Shutdown_Original();
}

void DebugBackend::SW_CCSys_TestInitialConditions()
{
    SW_CCSys_TestInitialConditions_Original();
}

bool DebugBackend::SW_HasAchievements()
{
    return SW_HasAchievements_Original();
}

bool DebugBackend::SW_HasInvites()
{
    return SW_HasInvites_Original();
}

bool DebugBackend::SW_HasLeaderboards()
{
    return SW_HasLeaderboards_Original();
}

void DebugBackend::SW_RegisterCallback()
{
    SW_RegisterCallback_Original();
}

void DebugBackend::SW_UnregisterCallback()
{
    SW_UnregisterCallback_Original();
}