// ModRM, prefixes, and encoding helpers for gallinule.amd64
module gallinule.amd64.encoding;

import std.bitmanip;
import std.traits;
import gallinule.amd64.types;

// Used for generating instructions with directly encoded registers.
enum ENCODED = 1 << 0;
enum INT = 1 << 6;
enum NO_REX = 1 << 1;
enum NO_REX_W = 1 << 7;
enum FLIP = 1 << 2;
enum VEX = (1 << 3) | FLIP;
enum EVEX = 1 << 4;
enum MVEX = 1 << 5;

enum MXOP = 0;
enum M38 = 2;
enum M3A = 3;
enum MMSR = 7;

package enum Mode
{
    Memory,
    MemoryOffset8,
    MemoryOffsetExt,
    Register
}

package union ModRM
{
public:
final:
    struct
    {
        mixin(bitfields!(
            ubyte, "src", 3,
            ubyte, "dst", 3,
            ubyte, "mod", 2
        ));
    }
    ubyte b;
    alias b this;
}

package ubyte[] generateModRM(ubyte OP, SRC, DST)(SRC src, DST dst)
    if (isInstanceOf!(Mem, SRC) && isInstanceOf!(Reg, DST))
{
    if (src.size == 0)
        return generateModRM!OP(DST(src.register), dst, Mode.Memory)~0x25~(cast(ubyte*)&src.offset)[0..uint.sizeof];
    else
    {
        if (src.offset == 0)
            return generateModRM!OP(DST(src.register), dst, Mode.Memory);
        else
        {
            immutable int signedOffset = cast(int)src.offset;
            if (signedOffset >= -128 && signedOffset <= 127)
                return generateModRM!OP(DST(src.register), dst, Mode.MemoryOffset8)~cast(ubyte)(cast(byte)signedOffset);
            else
                return generateModRM!OP(DST(src.register), dst, Mode.MemoryOffsetExt)~(cast(ubyte*)&src.offset)[0..uint.sizeof];
        }
    }
}

package ubyte[] generateModRM(ubyte OP, SRC, DST)(SRC src, DST dst, Mode mod = Mode.Register)
    if (isInstanceOf!(Reg, SRC) && isInstanceOf!(Reg, DST))
{
    ModRM m;
    m.src = (src.index % 8);
    m.dst = (dst.index % 8) | OP;
    m.mod = cast(ubyte)mod;
    return [m];
}

package ubyte[] generateModRM(ubyte OP, SRC, DST)(SRC src, DST dst)
    if (isInstanceOf!(Mem, SRC) && isInstanceOf!(Mem, DST))
{
    return generateModRM!OP(Reg!(TemplateArgsOf!(DST))(dst.register), Reg!(TemplateArgsOf!(SRC))(src.register));
}

package ubyte[] generateModRM(ubyte OP, SRC, DST)(SRC src, DST dst)
    if (isInstanceOf!(Reg, SRC) && isInstanceOf!(Mem, DST))
{
    return generateModRM!OP(dst, src);
}
