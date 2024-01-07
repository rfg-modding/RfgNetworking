#include "IBackend.h"
#include "Backend/Debug/DebugBackend.h"
#include "Backend/IPC/IPCBackend.h"
#include <stdexcept>
#include <windows.h>
#include <stdint.h>
#include <stdio.h>
#include <string>

enum class BackendType
{
    Debug,
    IPC
};

#define SelectedBackend BackendType::Debug

IBackend* Backend = nullptr;

BOOL WINAPI DllMain(HINSTANCE hinstDLL, DWORD fdwReason, LPVOID lpvReserved)
{
    if (fdwReason == DLL_PROCESS_ATTACH)
    {
        //Initialize backend that will handle calls to the DLLs exposed functions
        try
        {
            switch (SelectedBackend)
            {
            case BackendType::Debug:
                Backend = new DebugBackend(hinstDLL);
                break;

            case BackendType::IPC:
                Backend = new IPCBackend();
                break;

            default:
                throw std::runtime_error("Invalid backend type '" + std::to_string((int)SelectedBackend) + "'. Please recompile sw_api.dll with a supported backend type.");
                break;
            }
        }
        catch (const std::exception& ex)
        {
            //TODO: Add logging
            string error = "An error occurred in sw_api.dll. The game will close. Error: '" + std::string(ex.what()) + "'";
            MessageBoxA(nullptr, error.c_str(), "sw_api.dll error", MB_OK);
            exit(-1);
        }
    }
    else if (fdwReason == DLL_PROCESS_DETACH)
    {
        if (Backend)
        {
            delete Backend;
        }
    }
    return (TRUE);
}

extern "C"
{
    __declspec(dllexport) bool __cdecl SW_CCSys_Init()
    {
        return Backend->SW_CCSys_Init();
    }

    __declspec(dllexport) ISteamClient* __cdecl SW_CCSys_CreateInternalModule(const char* interfaceVersion)
    {
        return Backend->SW_CCSys_CreateInternalModule(interfaceVersion);
    }

    __declspec(dllexport) CSteamAPIContext* __cdecl SW_CCSys_DynamicInit(CallbackCounterAndContext* callbackCounterAndContext) //arg is possibly a void*[23] ???
    {
        return Backend->SW_CCSys_DynamicInit(callbackCounterAndContext);
    }

    __declspec(dllexport) void __cdecl SW_CCSys_GetP()
    {
        Backend->SW_CCSys_GetP();
    }

    __declspec(dllexport) HSteamPipe __cdecl SW_CCSys_GetPInterface()
    {
        return Backend->SW_CCSys_GetPInterface();
    }

    __declspec(dllexport) void __cdecl SW_CCSys_GetU()
    {
        Backend->SW_CCSys_GetU(); //Unused by game
    }

    __declspec(dllexport) HSteamUser __cdecl SW_CCSys_GetUInterface()
    {
        return Backend->SW_CCSys_GetUInterface();
    }

    __declspec(dllexport) void __cdecl SW_CCSys_InitCallbackFunc(CCallbackBase* callback, CallbackType callbackId)
    {
        Backend->SW_CCSys_InitCallbackFunc(callback, callbackId);
    }

    __declspec(dllexport) void __cdecl SW_CCSys_RemoveCallbackFunc(CCallbackBase* callback)
    {
        Backend->SW_CCSys_RemoveCallbackFunc(callback);
    }

    __declspec(dllexport) void __cdecl SW_CCSys_IsBackendActive()
    {
        Backend->SW_CCSys_IsBackendActive(); //Unused by game
    }

    __declspec(dllexport) void __cdecl SW_CCSys_ProcessApiCb()
    {
        Backend->SW_CCSys_ProcessApiCb(); //Game uses this but it's just a void func(void)
    }

    __declspec(dllexport) void __cdecl SW_CCSys_RegisterCallResult(CCallbackBase* callbackResult, u32 apiCallHandleLower, u32 apiCallHandleUpper)
    {
        Backend->SW_CCSys_RegisterCallResult(callbackResult, apiCallHandleLower, apiCallHandleUpper);
    }

    __declspec(dllexport) void __cdecl SW_CCSys_UnregisterCallResult(CCallbackBase* callbackResult, u32 apiCallHandleLower, u32 apiCallHandleUpper)
    {
        Backend->SW_CCSys_UnregisterCallResult(callbackResult, apiCallHandleLower, apiCallHandleUpper);
    }

    __declspec(dllexport) void __cdecl SW_CCSys_Shutdown()
    {
        Backend->SW_CCSys_Shutdown();
    }

    __declspec(dllexport) void __cdecl SW_CCSys_TestInitialConditions()
    {
        Backend->SW_CCSys_TestInitialConditions(); //Unused by game
    }

    __declspec(dllexport) bool __cdecl SW_HasAchievements()
    {
        return Backend->SW_HasAchievements();
    }

    __declspec(dllexport) bool __cdecl SW_HasInvites()
    {
        return Backend->SW_HasInvites();
    }

    __declspec(dllexport) bool __cdecl SW_HasLeaderboards()
    {
        return Backend->SW_HasLeaderboards();
    }

    __declspec(dllexport) void __cdecl SW_RegisterCallback()
    {
        Backend->SW_RegisterCallback(); //Unused by game
    }

    __declspec(dllexport) void __cdecl SW_UnregisterCallback()
    {
        Backend->SW_UnregisterCallback(); //Unused by game
    }
}