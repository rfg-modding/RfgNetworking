using System;

namespace RfgNetworkAPI.Win32
{
    public function int FARPROC();

    extension Win32
    {
        [Import("kernel32.lib"), CLink, CallingConvention(.Stdcall)]
        public static extern HINSTANCE LoadLibraryA(PSTR lpLibFileName);
        [Import("kernel32.lib"), CLink, CallingConvention(.Stdcall)]
        public static extern BOOL FreeLibrary(HINSTANCE hLibModule);
        [Import("kernel32.lib"), CLink, CallingConvention(.Stdcall)]
        public static extern FARPROC GetProcAddress(HINSTANCE hModule, PSTR lpProcName);
    }
}
