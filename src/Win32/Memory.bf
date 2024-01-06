using System;

namespace RfgNetworking.Win32
{
    [AllowDuplicates]
    public enum PAGE_PROTECTION_FLAGS : uint32
    {
    	PAGE_NOACCESS = 1,
    	PAGE_READONLY = 2,
    	PAGE_READWRITE = 4,
    	PAGE_WRITECOPY = 8,
    	PAGE_EXECUTE = 16,
    	PAGE_EXECUTE_READ = 32,
    	PAGE_EXECUTE_READWRITE = 64,
    	PAGE_EXECUTE_WRITECOPY = 128,
    	PAGE_GUARD = 256,
    	PAGE_NOCACHE = 512,
    	PAGE_WRITECOMBINE = 1024,
    	PAGE_GRAPHICS_NOACCESS = 2048,
    	PAGE_GRAPHICS_READONLY = 4096,
    	PAGE_GRAPHICS_READWRITE = 8192,
    	PAGE_GRAPHICS_EXECUTE = 16384,
    	PAGE_GRAPHICS_EXECUTE_READ = 32768,
    	PAGE_GRAPHICS_EXECUTE_READWRITE = 65536,
    	PAGE_GRAPHICS_COHERENT = 131072,
    	PAGE_GRAPHICS_NOCACHE = 262144,
    	PAGE_ENCLAVE_THREAD_CONTROL = 2147483648,
    	PAGE_REVERT_TO_FILE_MAP = 2147483648,
    	PAGE_TARGETS_NO_UPDATE = 1073741824,
    	PAGE_TARGETS_INVALID = 1073741824,
    	PAGE_ENCLAVE_UNVALIDATED = 536870912,
    	PAGE_ENCLAVE_MASK = 268435456,
    	PAGE_ENCLAVE_DECOMMIT = 268435456,
    	PAGE_ENCLAVE_SS_FIRST = 268435457,
    	PAGE_ENCLAVE_SS_REST = 268435458,
    	SEC_PARTITION_OWNER_HANDLE = 262144,
    	SEC_64K_PAGES = 524288,
    	SEC_FILE = 8388608,
    	SEC_IMAGE = 16777216,
    	SEC_PROTECTED_IMAGE = 33554432,
    	SEC_RESERVE = 67108864,
    	SEC_COMMIT = 134217728,
    	SEC_NOCACHE = 268435456,
    	SEC_WRITECOMBINE = 1073741824,
    	SEC_LARGE_PAGES = 2147483648,
    	SEC_IMAGE_NO_EXECUTE = 285212672,
    }

    extension Win32
    {
        [Import("kernel32.lib"), CLink, CallingConvention(.Stdcall)]
        public static extern BOOL VirtualProtect(void* lpAddress, uint dwSize, PAGE_PROTECTION_FLAGS flNewProtect, out PAGE_PROTECTION_FLAGS lpflOldProtect);

		[Import("kernel32.lib"), CLink, CallingConvention(.Stdcall)]
		public static extern void GetLocalTime(SystemTime* lpSystemTime);
    }

	[CRepr]
	public struct SystemTime{
		public uint16 Year;
		public uint16 Month;
		public uint16 DayOfWeek;
		public uint16 Day;
		public uint16 Hour;
		public uint16 Minute;
		public uint16 Second;
		public uint16 Milliseconds;
	}
}