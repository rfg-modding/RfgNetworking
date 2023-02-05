using System;

namespace RfgNetworkAPI
{
	typealias u8 = uint8;
	typealias u16 = uint16;
	typealias u32 = uint32;
	typealias u64 = uint64;

	typealias i8 = int8;
	typealias i16 = int16;
	typealias i32 = int32;
	typealias i64 = int64;

	typealias f32 = float;
	typealias f64 = double;
}

static
{
    //Ensure sized types are the expected size. If any of these fail you're either on a weird platform or there are serious problems
    [Comptime]
	static void ValidateRfgNetworkAPITypeSizes()
    {
        Compiler.Assert(sizeof(RfgNetworkAPI.u8) == 1);
        Compiler.Assert(sizeof(RfgNetworkAPI.u16) == 2);
        Compiler.Assert(sizeof(RfgNetworkAPI.u32) == 4);
        Compiler.Assert(sizeof(RfgNetworkAPI.u64) == 8);

        Compiler.Assert(sizeof(RfgNetworkAPI.i8) == 1);
        Compiler.Assert(sizeof(RfgNetworkAPI.i16) == 2);
        Compiler.Assert(sizeof(RfgNetworkAPI.i32) == 4);
        Compiler.Assert(sizeof(RfgNetworkAPI.i64) == 8);

        Compiler.Assert(sizeof(RfgNetworkAPI.f32) == 4);
        Compiler.Assert(sizeof(RfgNetworkAPI.f64) == 8);
    }
}
