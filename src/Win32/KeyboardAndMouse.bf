using System;

namespace RfgNetworking.Win32
{
    extension Win32
    {
        [Import("user32.lib"), CLink, CallingConvention(.Stdcall)]
        public static extern int16 GetKeyState(int32 nVirtKey);
    }
}