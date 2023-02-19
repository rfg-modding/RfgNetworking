using RfgNetworking.API;

namespace RfgNetworking.Backend.Community
{
    public struct CUtils : ISteamUtils
    {
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

        public void ModuleShutdown()
        {
            delete Vtable;
        }

        public uint32 GetSecondsSinceAppActive()
        {
            return 0;
        }

        public uint32 GetSecondsSinceComputerActive()
        {
            return 0;
        }

        public Universe GetConnectedUniverse()
        {
            return .Public;
        }

        public uint32 GetServerRealTime()
        {
            return 0;
        }

        public char8* GetIPCountry()
        {
            return null;
        }

        public uint8 GetImageSize(int32 iImage, uint32* pnWidth, uint32* pnHeight)
        {
            return 0;
        }

        public uint8 GetImageRGBA(int32 iImage, uint8* pubDest, int32 nDestBufferSize)
        {
            return 0;
        }

        public uint8 GetCSERIPPort(uint32* unIP, uint16* usPort)
        {
            return 0;
        }

        public uint8 GetCurrentBatteryPower()
        {
            return 0;
        }

        public uint32 GetAppID()
        {
            return 0;
        }

        public void SetOverlayNotificationPosition(NotificationPosition eNotificationPosition)
        {

        }

        public bool IsAPICallCompleted(SteamAPICall hSteamAPICall, bool* pbFailed)
        {
            return false;
        }

        public SteamAPICallFailure GetAPICallFailureReason(SteamAPICall hSteamAPICall)
        {
            return .None;
        }

        public bool GetAPICallResult(SteamAPICall hSteamAPICall, void* pCallback, int cubCallback, int iCallbackExpected, bool* pbFailed)
        {
            return false;
        }

        public void RunFrame()
        {

        }

        public uint32 GetIPCCallCount()
        {
            return 0;
        }

        public void SetWarningMessageHook(function  void(int32 nSeverity, char8* pchDebugText) pFunc)
        {

        }

        public bool IsOverlayEnabled()
        {
            return false;
        }

        public bool BOverlayNeedsPresent()
        {
            return false;
        }

        public SteamAPICall CheckFileSignature(char8* szFileName)
        {
            return 0;
        }

        public bool ShowGamepadTextInput(GamepadTextInputMode eInputMode, GamepadTextInputLineMode eLineInputMode, char8* pchDescription, uint32 unCharMax, char8* pchExistingText)
        {
            return false;
        }

        public uint32 GetEnteredGamepadTextLength()
        {
            return 0;
        }

        public bool GetEnteredGamepadTextInput(char8* pchText, uint32 cchText)
        {
            return false;
        }

        public char8* GetSteamUILanguage()
        {
            return null;
        }

        public bool IsSteamRunningInVR()
        {
            return false;
        }

        public void SetOverlayNotificationInset(int nHorizontalInset, int nVerticalInset)
        {

        }

        public bool IsSteamInBigPictureMode()
        {
            return false;
        }

        public void StartVRDashboard()
        {

        }

        public bool IsVRHeadsetStreamingEnabled()
        {
            return false;
        }

        public void SetVRHeadsetStreamingEnabled(bool bEnabled)
        {

        }
    }    
}