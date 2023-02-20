using RfgNetworking.Misc;
using RfgNetworking.API;
using System;

namespace RfgNetworking.Backend.Community
{
    public struct CUtils : ISteamUtils
    {
        [DebugLog]
        public void ModuleInit() mut
        {
            Vtable = new ISteamUtils.VTable();
            Vtable.GetSecondsSinceAppActive = => GetSecondsSinceAppActive;
            Vtable.GetSecondsSinceComputerActive = => GetSecondsSinceComputerActive;
            Vtable.GetConnectedUniverse = => GetConnectedUniverse;
            Vtable.GetServerRealTime = => GetServerRealTime;
            Vtable.GetIPCountry = => GetIPCountry;
            Vtable.GetImageSize = => GetImageSize;
            Vtable.GetImageRGBA = => GetImageRGBA;
            Vtable.GetCSERIPPort = => GetCSERIPPort;
            Vtable.GetCurrentBatteryPower = => GetCurrentBatteryPower;
            Vtable.GetAppID = => GetAppID;
            Vtable.SetOverlayNotificationPosition = => SetOverlayNotificationPosition;
            Vtable.IsAPICallCompleted = => IsAPICallCompleted;
            Vtable.GetAPICallFailureReason = => GetAPICallFailureReason;
            Vtable.GetAPICallResult = => GetAPICallResult;
            Vtable.RunFrame = => RunFrame;
            Vtable.GetIPCCallCount = => GetIPCCallCount;
            Vtable.SetWarningMessageHook = => SetWarningMessageHook;
            Vtable.IsOverlayEnabled = => IsOverlayEnabled;
            Vtable.BOverlayNeedsPresent = => BOverlayNeedsPresent;
            Vtable.CheckFileSignature = => CheckFileSignature;
            Vtable.ShowGamepadTextInput = => ShowGamepadTextInput;
            Vtable.GetEnteredGamepadTextLength = => GetEnteredGamepadTextLength;
            Vtable.GetEnteredGamepadTextInput = => GetEnteredGamepadTextInput;
            Vtable.GetSteamUILanguage = => GetSteamUILanguage;
            Vtable.IsSteamRunningInVR = => IsSteamRunningInVR;
            Vtable.SetOverlayNotificationInset = => SetOverlayNotificationInset;
            Vtable.IsSteamInBigPictureMode = => IsSteamInBigPictureMode;
            Vtable.StartVRDashboard = => StartVRDashboard;
            Vtable.IsVRHeadsetStreamingEnabled = => IsVRHeadsetStreamingEnabled;
            Vtable.SetVRHeadsetStreamingEnabled = => SetVRHeadsetStreamingEnabled;
        }

        [DebugLog]
        public void ModuleShutdown()
        {
            delete Vtable;
        }

        [DebugLog]
        public uint32 GetSecondsSinceAppActive()
        {
            return 0;
        }

        [DebugLog]
        public uint32 GetSecondsSinceComputerActive()
        {
            return 0;
        }

        [DebugLog]
        public Universe GetConnectedUniverse()
        {
            return .Public;
        }

        [DebugLog]
        public uint32 GetServerRealTime()
        {
            return 0;
        }

        [DebugLog]
        public char8* GetIPCountry()
        {
            return null;
        }

        [DebugLog]
        public uint8 GetImageSize(int32 iImage, uint32* pnWidth, uint32* pnHeight)
        {
            return 0;
        }

        [DebugLog]
        public uint8 GetImageRGBA(int32 iImage, uint8* pubDest, int32 nDestBufferSize)
        {
            return 0;
        }

        [DebugLog]
        public uint8 GetCSERIPPort(uint32* unIP, uint16* usPort)
        {
            return 0;
        }

        [DebugLog]
        public uint8 GetCurrentBatteryPower()
        {
            return 0;
        }

        [DebugLog]
        public uint32 GetAppID()
        {
            return 0;
        }

        [DebugLog]
        public void SetOverlayNotificationPosition(NotificationPosition eNotificationPosition)
        {

        }

        [DebugLog]
        public bool IsAPICallCompleted(SteamAPICall hSteamAPICall, bool* pbFailed)
        {
            return false;
        }

        [DebugLog]
        public SteamAPICallFailure GetAPICallFailureReason(SteamAPICall hSteamAPICall)
        {
            return .None;
        }

        [DebugLog]
        public bool GetAPICallResult(SteamAPICall hSteamAPICall, void* pCallback, int cubCallback, int iCallbackExpected, bool* pbFailed)
        {
            return false;
        }

        [DebugLog]
        public void RunFrame()
        {

        }

        [DebugLog]
        public uint32 GetIPCCallCount()
        {
            return 0;
        }

        [DebugLog]
        public void SetWarningMessageHook(function  void(int32 nSeverity, char8* pchDebugText) pFunc)
        {

        }

        [DebugLog]
        public bool IsOverlayEnabled()
        {
            return false;
        }

        [DebugLog]
        public bool BOverlayNeedsPresent()
        {
            return false;
        }

        [DebugLog]
        public SteamAPICall CheckFileSignature(char8* szFileName)
        {
            return 0;
        }

        [DebugLog]
        public bool ShowGamepadTextInput(GamepadTextInputMode eInputMode, GamepadTextInputLineMode eLineInputMode, char8* pchDescription, uint32 unCharMax, char8* pchExistingText)
        {
            return false;
        }

        [DebugLog]
        public uint32 GetEnteredGamepadTextLength()
        {
            return 0;
        }

        [DebugLog]
        public bool GetEnteredGamepadTextInput(char8* pchText, uint32 cchText)
        {
            return false;
        }

        [DebugLog]
        public char8* GetSteamUILanguage()
        {
            return null;
        }

        [DebugLog]
        public bool IsSteamRunningInVR()
        {
            return false;
        }

        [DebugLog]
        public void SetOverlayNotificationInset(int nHorizontalInset, int nVerticalInset)
        {

        }

        [DebugLog]
        public bool IsSteamInBigPictureMode()
        {
            return false;
        }

        [DebugLog]
        public void StartVRDashboard()
        {

        }

        [DebugLog]
        public bool IsVRHeadsetStreamingEnabled()
        {
            return false;
        }

        [DebugLog]
        public void SetVRHeadsetStreamingEnabled(bool bEnabled)
        {

        }
    }    
}