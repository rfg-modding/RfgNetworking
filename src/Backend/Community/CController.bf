using RfgNetworking.Misc;
using RfgNetworking.API;
using System;

namespace RfgNetworking.Backend.Community
{
    public struct CController : ISteamController
    {
        [DebugLog]
        public void ModuleInit() mut
        {
            Vtable = new ISteamController.VTable();
            Vtable.Init = => Init;
            Vtable.Shutdown = => Shutdown;
            Vtable.RunFrame = => RunFrame;
            Vtable.GetConnectedControllers = => GetConnectedControllers;
            Vtable.ShowBindingPanel = => ShowBindingPanel;
            Vtable.GetActionSetHandle = => GetActionSetHandle;
            Vtable.ActivateActionSet = => ActivateActionSet;
            Vtable.GetCurrentActionSet = => GetCurrentActionSet;
            Vtable.ActivateActionSetLayer = => ActivateActionSetLayer;
            Vtable.DeactivateActionSetLayer = => DeactivateActionSetLayer;
            Vtable.DeactivateAllActionSetLayers = => DeactivateAllActionSetLayers;
            Vtable.GetActiveActionSetLayers = => GetActiveActionSetLayers;
            Vtable.GetDigitalActionHandle = => GetDigitalActionHandle;
            Vtable.GetDigitalActionData = => GetDigitalActionData;
            Vtable.GetDigitalActionOrigins = => GetDigitalActionOrigins;
            Vtable.GetAnalogActionHandle = => GetAnalogActionHandle;
            Vtable.GetAnalogActionData = => GetAnalogActionData;
            Vtable.GetAnalogActionOrigins = => GetAnalogActionOrigins;
            Vtable.StopAnalogActionMomentum = => StopAnalogActionMomentum;
            Vtable.TriggerHapticPulse = => TriggerHapticPulse;
            Vtable.TriggerRepeatedHapticPulse = => TriggerRepeatedHapticPulse;
            Vtable.TriggerVibration = => TriggerVibration;
            Vtable.SetLEDColor = => SetLEDColor;
            Vtable.GetGamepadIndexForController = => GetGamepadIndexForController;
            Vtable.GetControllerForGamepadIndex = => GetControllerForGamepadIndex;
            Vtable.GetMotionData = => GetMotionData;
            Vtable.ShowDigitalActionOrigins = => ShowDigitalActionOrigins;
            Vtable.ShowAnalogActionOrigins = => ShowAnalogActionOrigins;
            Vtable.GetStringForActionOrigin = => GetStringForActionOrigin;
            Vtable.GetGlyphForActionOrigin = => GetGlyphForActionOrigin;
            Vtable.GetInputTypeForHandle = => GetInputTypeForHandle;
        }

        [DebugLog]
        public void ModuleShutdown()
        {
            delete Vtable;
        }

        [DebugLog]
        public bool Init()
        {
            return true;
        }

        [DebugLog]
        public bool Shutdown()
        {
            return true;
        }

        [DebugLog]
        public void RunFrame()
        {

        }

        [DebugLog]
        public int GetConnectedControllers(ControllerHandle* handlesOut)
        {
            return 0;
        }

        [DebugLog]
        public bool ShowBindingPanel(ControllerHandle controllerHandle)
        {
            return false;
        }

        [DebugLog]
        public ControllerActionSetHandle GetActionSetHandle(char8* pszActionSetName)
        {
            return 0;
        }

        [DebugLog]
        public void ActivateActionSet(ControllerHandle controllerHandle, ControllerActionSetHandle actionSetHandle)
        {

        }

        [DebugLog]
        public ControllerActionSetHandle GetCurrentActionSet(ControllerHandle controllerHandle)
        {
            return 0;
        }

        [DebugLog]
        public void ActivateActionSetLayer(ControllerHandle controllerHandle, ControllerActionSetHandle actionSetLayerHandle)
        {

        }

        [DebugLog]
        public void DeactivateActionSetLayer(ControllerHandle controllerHandle, ControllerActionSetHandle actionSetLayerHandle)
        {

        }

        [DebugLog]
        public void DeactivateAllActionSetLayers(ControllerHandle controllerHandle)
        {

        }

        [DebugLog]
        public int GetActiveActionSetLayers(ControllerHandle controllerHandle, ControllerActionSetHandle* handlesOut)
        {
            return 0;
        }

        [DebugLog]
        public ControllerDigitalActionHandle GetDigitalActionHandle(char8* pszActionName)
        {
            return 0;
        }

        [DebugLog]
        public ControllerDigitalActionData GetDigitalActionData(ControllerDigitalActionData* __return, ControllerHandle controllerHandle, ControllerDigitalActionHandle digitalActionHandle)
        {
            return .();
        }

        [DebugLog]
        public int GetDigitalActionOrigins(ControllerHandle controllerHandle, ControllerActionSetHandle actionSetHandle, ControllerDigitalActionHandle digitalActionHandle, ControllerActionOrigin* originsOut)
        {
            return 0;
        }

        [DebugLog]
        public ControllerAnalogActionHandle GetAnalogActionHandle(char8* pszActionName)
        {
            return 0;
        }

        [DebugLog]
        public ControllerAnalogActionData GetAnalogActionData(ControllerAnalogActionData* __return, ControllerHandle controllerHandle, ControllerAnalogActionHandle analogActionHandle)
        {
            return .();
        }

        [DebugLog]
        public int GetAnalogActionOrigins(ControllerHandle controllerHandle, ControllerActionSetHandle actionSetHandle, ControllerAnalogActionHandle analogActionHandle, ControllerActionOrigin* originsOut)
        {
            return 0;
        }

        [DebugLog]
        public void StopAnalogActionMomentum(ControllerHandle controllerHandle, ControllerAnalogActionHandle eAction)
        {

        }

        [DebugLog]
        public void TriggerHapticPulse(ControllerHandle controllerHandle, SteamControllerPad eTargetPad, uint16 usDurationMicroSec)
        {

        }

        [DebugLog]
        public void TriggerRepeatedHapticPulse(ControllerHandle controllerHandle, SteamControllerPad eTargetPad, uint16 usDurationMicroSec, uint16 usOffMicroSec, uint16 unRepeat, uint32 nFlags)
        {

        }

        [DebugLog]
        public void TriggerVibration(ControllerHandle controllerHandle, uint16 usLeftSpeed, uint16 usRightSpeed)
        {

        }

        [DebugLog]
        public void SetLEDColor(ControllerHandle controllerHandle, uint8 nColorR, uint8 nColorG, uint8 nColorB, uint32 nFlags)
        {

        }

        [DebugLog]
        public int GetGamepadIndexForController(ControllerHandle ulControllerHandle)
        {
            return 0;
        }

        [DebugLog]
        public ControllerHandle GetControllerForGamepadIndex(int nIndex)
        {
            return 0;
        }

        [DebugLog]
        public ControllerMotionData GetMotionData(ControllerMotionData* __return, ControllerHandle controllerHandle)
        {
            return .();
        }

        [DebugLog]
        public bool ShowDigitalActionOrigins(ControllerHandle controllerHandle, ControllerDigitalActionHandle digitalActionHandle, float flScale, float flXPosition, float flYPosition)
        {
            return false;
        }

        [DebugLog]
        public bool ShowAnalogActionOrigins(ControllerHandle controllerHandle, ControllerAnalogActionHandle analogActionHandle, float flScale, float flXPosition, float flYPosition)
        {
            return false;
        }

        [DebugLog]
        public char8* GetStringForActionOrigin(ControllerActionOrigin eOrigin)
        {
            return null;
        }

        [DebugLog]
        public char8* GetGlyphForActionOrigin(ControllerActionOrigin eOrigin)
        {
            return null;
        }

        [DebugLog]
        public SteamInputType GetInputTypeForHandle(ControllerHandle controllerHandle)
        {
            return .GenericXInput;
        }
    }    
}