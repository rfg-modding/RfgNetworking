using System;
namespace RfgNetworking.Misc;

namespace System.IO
{
    extension Path
    {
        //Original signature: uint32(PSTR lpSrc, uint8* lpDst, uint32 nSize)
        [Import("kernel32.lib"), CLink, CallingConvention(.Stdcall)]
        private static extern uint32 ExpandEnvironmentStringsA(char8* lpSrc, char8* lpDst, uint32 nSize);

        public static Result<void> ExpandEnvironmentVariables(String path, String expandedPath)
        {
            path.EnsureNullTerminator();
            char8[] outBuffer = new char8[2048];

            u32 finalSize = ExpandEnvironmentStringsA(path.Ptr, outBuffer.Ptr, (u32)outBuffer.Count);
            if (finalSize > (u32)outBuffer.Count)
            {
                //Buffer is too small. Realloc to required size and try again
                delete outBuffer;
                outBuffer = new char8[finalSize + 1]; //Windows docs say it should be str length + null terminator + 1 for ANSI strings
                finalSize = ExpandEnvironmentStringsA(path.Ptr, outBuffer.Ptr, (u32)outBuffer.Count);
            }
            if (finalSize == 0)
            {
                //Some other error happened. Can use windows GetLastError() function for more details. For now I don't need it to be that advanced.
                return .Err;
            }

            expandedPath.Set(StringView(outBuffer, 0, (int)finalSize - 1 /*Length includes null terminator*/));
            delete outBuffer;
            return .Ok;
        }
    }

    extension File
    {
        public static i64 GetFileSize(StringView filePath)
        {
            FileStream stream = new .()..Open(filePath, .Read, .Read);
            i64 fileSize = stream.Length;
            stream.Close();
            delete stream;
            return fileSize;
        }
    }
}

namespace Bon
{
    extension Bon
    {
        public static void SafePointerSerialize<T>(T* value, String into, BonEnvironment env = gBonEnv)
        {
            var addr = (u64)(int)(void*)value;
            if (addr == 0 || addr == 0xDEADBEEF || addr == 0xDEADC0DE)
            {
                into.Set(scope $"({typeof(T).GetName(.. scope .())})(0x{addr:X})");
            }
            else
            {
                Bon.Serialize<T>(*value, into, env);
            }
        }
    }
}