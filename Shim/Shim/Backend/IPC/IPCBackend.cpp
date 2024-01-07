#include "IPCBackend.h"
#include <stdexcept>

IPCBackend::IPCBackend()
{
    throw std::runtime_error("IPCBackend hasn't been implemented yet. Use DebugBackend.");
}

IPCBackend::~IPCBackend()
{

}

bool IPCBackend::SW_CCSys_Init()
{
    return false;
}

ISteamClient* IPCBackend::SW_CCSys_CreateInternalModule(const char* interfaceName)
{
    return nullptr;
}

CSteamAPIContext* IPCBackend::SW_CCSys_DynamicInit(CallbackCounterAndContext* callbackCounterAndContext)
{
    return nullptr;
}

void IPCBackend::SW_CCSys_GetP()
{
}

HSteamPipe IPCBackend::SW_CCSys_GetPInterface()
{
    return HSteamPipe();
}

void IPCBackend::SW_CCSys_GetU()
{
}

HSteamUser IPCBackend::SW_CCSys_GetUInterface()
{
    return HSteamUser();
}

void IPCBackend::SW_CCSys_InitCallbackFunc(CCallbackBase* callback, CallbackType callbackId)
{

}

void IPCBackend::SW_CCSys_RemoveCallbackFunc(CCallbackBase* callback)
{

}

void IPCBackend::SW_CCSys_IsBackendActive()
{

}

void IPCBackend::SW_CCSys_ProcessApiCb()
{

}

void IPCBackend::SW_CCSys_RegisterCallResult(CCallbackBase* callbackResult, u32 apiCallHandleLower, u32 apiCallHandleUpper)
{

}

void IPCBackend::SW_CCSys_UnregisterCallResult(CCallbackBase* callbackResult, u32 apiCallHandleLower, u32 apiCallHandleUpper)
{

}

void IPCBackend::SW_CCSys_Shutdown()
{

}

void IPCBackend::SW_CCSys_TestInitialConditions()
{

}

bool IPCBackend::SW_HasAchievements()
{
    return false;
}

bool IPCBackend::SW_HasInvites()
{
    return false;
}

bool IPCBackend::SW_HasLeaderboards()
{
    return false;
}

void IPCBackend::SW_RegisterCallback()
{
}

void IPCBackend::SW_UnregisterCallback()
{
}
