// ModRM, prefixes, and encoding helpers for multidasm.amd64
module multidasm.amd64.encoding;

import multidasm.amd64.types;
import std.bitmanip : nativeToLittleEndian;
import std.traits;

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

package ubyte[] generateModRM(ubyte OP, SRC, DST)(SRC src, DST dst)
    if (isInstanceOf!(Mem, SRC) && isInstanceOf!(Reg, DST))
{
    // RIP-relative (64-bit): mod=00, r/m=101, then disp32 only.
    if (src.size == 0)
        return generateModRM!OP(DST(5), dst, Mode.Memory)~nativeToLittleEndian(src.offset);
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
                return generateModRM!OP(DST(src.register), dst, Mode.MemoryOffsetExt)~
                    nativeToLittleEndian(src.offset);
        }
    }
}

package ubyte[] generateModRM(ubyte OP, SRC, DST)(SRC src, DST dst, Mode mod = Mode.Register)
    if (isInstanceOf!(Reg, SRC) && isInstanceOf!(Reg, DST))
{
    return [cast(ubyte)((src.index % 8) | (((dst.index % 8) | OP) << 3) | (cast(ubyte)mod << 6))];
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
