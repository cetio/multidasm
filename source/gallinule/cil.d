// CIL (Common Intermediate Language) assembler; Block-based API (labels, branches patched in finalize).
// Reference: https://github.com/cetio/cilk/blob/master/cilk/cilk.d
module gallinule.cil;

import std.algorithm;
import std.array;
import std.conv;
import std.format;
import std.string;
import std.typecons;

immutable ubyte[][string] instructions = [
    "add": [0x58],
    "add.ovf": [0xD6],
    "add.ovf.un": [0xD7],
    "and": [0x5F],
    "arglist": [0xFE, 0x00],
    "beq": [0x3B],
    "beq.s": [0x2E],
    "bge": [0x3C],
    "bge.s": [0x2F],
    "bge.un": [0x41],
    "bge.un.s": [0x34],
    "bgt": [0x3D],
    "bgt.s": [0x30],
    "bgt.un": [0x42],
    "bgt.un.s": [0x35],
    "ble": [0x3E],
    "ble.s": [0x31],
    "ble.un": [0x43],
    "ble.un.s": [0x36],
    "blt": [0x3F],
    "blt.s": [0x32],
    "blt.un": [0x44],
    "blt.un.s": [0x37],
    "bne.un": [0x40],
    "bne.un.s": [0x33],
    "box": [0x8C],
    "br": [0x38],
    "br.s": [0x2B],
    "break": [0x01],
    "brfalse": [0x39],
    "brfalse.s": [0x2C],
    "brinst": [0x3A],
    "brinst.s": [0x2D],
    "brnull": [0x39],
    "brnull.s": [0x2C],
    "brtrue": [0x3A],
    "brtrue.s": [0x2D],
    "brzero": [0x39],
    "brzero.s": [0x2C],
    "call": [0x28],
    "calli": [0x29],
    "callvirt": [0x6F],
    "castclass": [0x74],
    "ceq": [0xFE, 0x01],
    "cgt": [0xFE, 0x02],
    "cgt.un": [0xFE, 0x03],
    "ckfinite": [0xC3],
    "clt": [0xFE, 0x04],
    "clt.un": [0xFE, 0x05],
    "constrained": [0xFE, 0x16],
    "conv.i": [0xD3],
    "conv.i1": [0x67],
    "conv.i2": [0x68],
    "conv.i4": [0x69],
    "conv.i8": [0x6A],
    "conv.ovf.i": [0xD4],
    "conv.ovf.i.un": [0x8A],
    "conv.ovf.i1": [0xB3],
    "conv.ovf.i1.un": [0x82],
    "conv.ovf.i2": [0xB5],
    "conv.ovf.i2.un": [0x83],
    "conv.ovf.i4": [0xB7],
    "conv.ovf.i4.un": [0x84],
    "conv.ovf.i8": [0xB9],
    "conv.ovf.i8.un": [0x85],
    "conv.ovf.u": [0xD5],
    "conv.ovf.u.un": [0x8B],
    "conv.ovf.u1": [0xB4],
    "conv.ovf.u1.un": [0x86],
    "conv.ovf.u2": [0xB6],
    "conv.ovf.u2.un": [0x87],
    "conv.ovf.u4": [0xB8],
    "conv.ovf.u4.un": [0x88],
    "conv.ovf.u8": [0xBA],
    "conv.ovf.u8.un": [0x89],
    "conv.r.un": [0x76],
    "conv.r4": [0x6B],
    "conv.r8": [0x6C],
    "conv.u": [0xE0],
    "conv.u1": [0xD2],
    "conv.u2": [0xD1],
    "conv.u4": [0x6D],
    "conv.u8": [0x6E],
    "cpblk": [0xFE, 0x17],
    "cpobj": [0x70],
    "div": [0x5B],
    "div.un": [0x5C],
    "dup": [0x25],
    "endfault": [0xDC],
    "endfilter": [0xFE, 0x11],
    "endfinally": [0xDC],
    "initblk": [0xFE, 0x18],
    "initobj": [0xFE, 0x15],
    "isinst": [0x75],
    "jmp": [0x27],
    "ldarg": [0xFE, 0x09],
    "ldarg.0": [0x02],
    "ldarg.1": [0x03],
    "ldarg.2": [0x04],
    "ldarg.3": [0x05],
    "ldarg.s": [0x0E],
    "ldarga": [0xFE, 0x0A],
    "ldarga.s": [0x0F],
    "ldc.i4": [0x20],
    "ldc.i4.0": [0x16],
    "ldc.i4.1": [0x17],
    "ldc.i4.2": [0x18],
    "ldc.i4.3": [0x19],
    "ldc.i4.4": [0x1A],
    "ldc.i4.5": [0x1B],
    "ldc.i4.6": [0x1C],
    "ldc.i4.7": [0x1D],
    "ldc.i4.8": [0x1E],
    "ldc.i4.m1": [0x15],
    "ldc.i4.s": [0x1F],
    "ldc.i8": [0x21],
    "ldc.r4": [0x22],
    "ldc.r8": [0x23],
    "ldelem": [0xA3],
    "ldelem.i": [0x97],
    "ldelem.i1": [0x90],
    "ldelem.i2": [0x92],
    "ldelem.i4": [0x94],
    "ldelem.i8": [0x96],
    "ldelem.r4": [0x98],
    "ldelem.r8": [0x99],
    "ldelem.ref": [0x9A],
    "ldelem.u1": [0x91],
    "ldelem.u2": [0x93],
    "ldelem.u4": [0x95],
    "ldelema": [0x8F],
    "ldfld": [0x7B],
    "ldflda": [0x7C],
    "ldftn": [0xFE, 0x06],
    "ldind.i": [0x4D],
    "ldind.i1": [0x46],
    "ldind.i2": [0x48],
    "ldind.i4": [0x4A],
    "ldind.i8": [0x4C],
    "ldind.r4": [0x4E],
    "ldind.r8": [0x4F],
    "ldind.ref": [0x50],
    "ldind.u1": [0x47],
    "ldind.u2": [0x49],
    "ldind.u4": [0x4B],
    "ldlen": [0x8E],
    "ldloc": [0xFE, 0x0C],
    "ldloc.0": [0x06],
    "ldloc.1": [0x07],
    "ldloc.2": [0x08],
    "ldloc.3": [0x09],
    "ldloc.s": [0x11],
    "ldloca": [0xFE, 0x0D],
    "ldloca.s": [0x12],
    "ldnull": [0x14],
    "ldobj": [0x71],
    "ldsfld": [0x7E],
    "ldsflda": [0x7F],
    "ldstr": [0x72],
    "ldtoken": [0xD0],
    "ldvirtftn": [0xFE, 0x07],
    "leave": [0xDD],
    "leave.s": [0xDE],
    "localloc": [0xFE, 0x0F],
    "mkrefany": [0xC6],
    "mul": [0x5A],
    "mul.ovf": [0xD8],
    "mul.ovf.un": [0xD9],
    "neg": [0x65],
    "newarr": [0x8D],
    "newobj": [0x73],
    "no": [0xFE, 0x19],
    "nop": [0x00],
    "not": [0x66],
    "or": [0x60],
    "pop": [0x26],
    "readonly": [0xFE, 0x1E],
    "refanytype": [0xC2],
    "refanyval": [0xC7],
    "rem": [0x5D],
    "rem.un": [0x5E],
    "ret": [0x2A],
    "rethrow": [0xFE, 0x1A],
    "shl": [0x62],
    "shr": [0x63],
    "shr.un": [0x64],
    "sizeof": [0xFE, 0x1C],
    "starg": [0xFE, 0x0B],
    "starg.s": [0x10],
    "stelem": [0xA4],
    "stelem.i": [0x9F],
    "stelem.i1": [0x9C],
    "stelem.i2": [0x9D],
    "stelem.i4": [0x9E],
    "stelem.i8": [0xA0],
    "stelem.r4": [0xA1],
    "stelem.r8": [0xA2],
    "stelem.ref": [0xA3],
    "stfld": [0x7D],
    "stind.i": [0x51],
    "stind.i1": [0x52],
    "stind.i2": [0x53],
    "stind.i4": [0x54],
    "stind.i8": [0x55],
    "stind.r4": [0x56],
    "stind.r8": [0x57],
    "stind.ref": [0x58],
    "stloc": [0xFE, 0x0E],
    "stloc.0": [0x0A],
    "stloc.1": [0x0B],
    "stloc.2": [0x0C],
    "stloc.3": [0x0D],
    "stloc.s": [0x13],
    "stobj": [0x81],
    "stsfld": [0x80],
    "sub": [0x59],
    "sub.ovf": [0xDA],
    "sub.ovf.un": [0xDB],
    "switch": [0x45],
    "tail": [0xFE, 0x14],
    "throw": [0x7A],
    "unaligned": [0xFE, 0x12],
    "unbox": [0x79],
    "unbox.any": [0xA5],
    "volatile": [0xFE, 0x13],
    "xor": [0x61]
];

immutable string[string] prefixes = [
    "no": "no.",
    "tail": "tail.",
    "volatile": "volatile.",
    "constrained": "constrained.",
    "readonly": "readonly."
];

struct Block
{
package:
final:
    ptrdiff_t[string] labels;
    Tuple!(size_t, string, string)[] branches;  // operand start, label, "rel1"|"rel4"
    Tuple!(size_t, size_t, string[])[] switches; // opcode start, count, target labels
    ubyte[] buffer;
    ubyte[] pendingPrefix;

    size_t emitOp(string mnemonic)
    {
        buffer ~= pendingPrefix;
        pendingPrefix = null;
        assert(mnemonic in instructions, "Unknown CIL mnemonic: " ~ mnemonic);
        buffer ~= instructions[mnemonic];
        return instructions[mnemonic].length;
    }

    void putInt(size_t pos, int value)
    {
        copy((cast(ubyte*)&value)[0..int.sizeof], buffer[pos .. pos + int.sizeof]);
    }

    void putByte(size_t pos, byte value)
    {
        buffer[pos] = cast(ubyte)value;
    }

public:
    ubyte[] finalize()
    {
        foreach (ref br; branches)
        {
            immutable pos = br[0];
            immutable name = br[1];
            immutable kind = br[2];
            assert(name in labels, "Branch label not defined: " ~ name);
            immutable target = labels[name];
            immutable nextInstr = pos + (kind == "rel1" ? 1 : 4);
            immutable offset = cast(int)(target - nextInstr);
            if (kind == "rel1")
            {
                assert(offset >= byte.min && offset <= byte.max, "Short branch offset out of range");
                putByte(pos, cast(byte)offset);
            }
            else
                putInt(pos, offset);
        }
        branches = null;

        foreach (ref sw; switches)
        {
            immutable opcodeStart = sw[0];
            immutable n = sw[1];
            string[] targetNames = sw[2];
            assert(targetNames.length == n, "Switch target count mismatch");
            immutable nextInstr = opcodeStart + 1 + uint.sizeof + n * int.sizeof;
            foreach (i, name; targetNames)
            {
                assert(name in labels, "Switch target label not defined: " ~ name);
                immutable offset = cast(int)(labels[name] - nextInstr);
                putInt(opcodeStart + 1 + uint.sizeof + i * int.sizeof, offset);
            }
        }
        switches = null;

        return buffer;
    }

    auto label(string name) => labels[name] = buffer.length;

    // Prefixes: apply to next instruction only
    void no() { pendingPrefix ~= instructions["no"]; }
    void tail_() { pendingPrefix ~= instructions["tail"]; }
    void volatile_() { pendingPrefix ~= instructions["volatile"]; }
    void constrained_() { pendingPrefix ~= instructions["constrained"]; }
    void readonly_() { pendingPrefix ~= instructions["readonly"]; }

    // No-operand instructions
    size_t add() => emitOp("add");
    size_t addOvf() => emitOp("add.ovf");
    size_t addOvfUn() => emitOp("add.ovf.un");
    size_t and_() => emitOp("and");
    size_t arglist() => emitOp("arglist");
    size_t box(uint token) { emitOp("box"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t break_() => emitOp("break");
    size_t call(uint token) { emitOp("call"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t calli(ptrdiff_t token) { emitOp("calli"); buffer ~= (cast(ubyte*)&token)[0..ptrdiff_t.sizeof]; return 1 + ptrdiff_t.sizeof; }
    size_t callvirt(uint token) { emitOp("callvirt"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t castclass(uint token) { emitOp("castclass"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t ceq() => emitOp("ceq");
    size_t cgt() => emitOp("cgt");
    size_t cgtUn() => emitOp("cgt.un");
    size_t ckfinite() => emitOp("ckfinite");
    size_t clt() => emitOp("clt");
    size_t cltUn() => emitOp("clt.un");
    size_t convI() => emitOp("conv.i");
    size_t convI1() => emitOp("conv.i1");
    size_t convI2() => emitOp("conv.i2");
    size_t convI4() => emitOp("conv.i4");
    size_t convI8() => emitOp("conv.i8");
    size_t convOvfI() => emitOp("conv.ovf.i");
    size_t convOvfIUn() => emitOp("conv.ovf.i.un");
    size_t convOvfI1() => emitOp("conv.ovf.i1");
    size_t convOvfI1Un() => emitOp("conv.ovf.i1.un");
    size_t convOvfI2() => emitOp("conv.ovf.i2");
    size_t convOvfI2Un() => emitOp("conv.ovf.i2.un");
    size_t convOvfI4() => emitOp("conv.ovf.i4");
    size_t convOvfI4Un() => emitOp("conv.ovf.i4.un");
    size_t convOvfI8() => emitOp("conv.ovf.i8");
    size_t convOvfI8Un() => emitOp("conv.ovf.i8.un");
    size_t convOvfU() => emitOp("conv.ovf.u");
    size_t convOvfUUn() => emitOp("conv.ovf.u.un");
    size_t convOvfU1() => emitOp("conv.ovf.u1");
    size_t convOvfU1Un() => emitOp("conv.ovf.u1.un");
    size_t convOvfU2() => emitOp("conv.ovf.u2");
    size_t convOvfU2Un() => emitOp("conv.ovf.u2.un");
    size_t convOvfU4() => emitOp("conv.ovf.u4");
    size_t convOvfU4Un() => emitOp("conv.ovf.u4.un");
    size_t convOvfU8() => emitOp("conv.ovf.u8");
    size_t convOvfU8Un() => emitOp("conv.ovf.u8.un");
    size_t convRUn() => emitOp("conv.r.un");
    size_t convR4() => emitOp("conv.r4");
    size_t convR8() => emitOp("conv.r8");
    size_t convU() => emitOp("conv.u");
    size_t convU1() => emitOp("conv.u1");
    size_t convU2() => emitOp("conv.u2");
    size_t convU4() => emitOp("conv.u4");
    size_t convU8() => emitOp("conv.u8");
    size_t cpobj(uint token) { emitOp("cpobj"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t div() => emitOp("div");
    size_t divUn() => emitOp("div.un");
    size_t dup() => emitOp("dup");
    size_t endfault() => emitOp("endfault");
    size_t endfilter() => emitOp("endfilter");
    size_t endfinally() => emitOp("endfinally");
    size_t initobj(uint token) { emitOp("initobj"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t isinst(uint token) { emitOp("isinst"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t jmp(uint token) { emitOp("jmp"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t ldarg(ushort ix) { emitOp("ldarg"); buffer ~= (cast(ubyte*)&ix)[0..ushort.sizeof]; return 2 + ushort.sizeof; }
    size_t ldarg0() => emitOp("ldarg.0");
    size_t ldarg1() => emitOp("ldarg.1");
    size_t ldarg2() => emitOp("ldarg.2");
    size_t ldarg3() => emitOp("ldarg.3");
    size_t ldargS(ubyte ix) { emitOp("ldarg.s"); buffer ~= (cast(ubyte*)&ix)[0..ubyte.sizeof]; return 2; }
    size_t ldarga(ushort ix) { emitOp("ldarga"); buffer ~= (cast(ubyte*)&ix)[0..ushort.sizeof]; return 2 + ushort.sizeof; }
    size_t ldargaS(ubyte ix) { emitOp("ldarga.s"); buffer ~= (cast(ubyte*)&ix)[0..ubyte.sizeof]; return 2; }
    size_t ldcI4(int value) { emitOp("ldc.i4"); buffer ~= (cast(ubyte*)&value)[0..int.sizeof]; return 1 + int.sizeof; }
    size_t ldcI4_0() => emitOp("ldc.i4.0");
    size_t ldcI4_1() => emitOp("ldc.i4.1");
    size_t ldcI4_2() => emitOp("ldc.i4.2");
    size_t ldcI4_3() => emitOp("ldc.i4.3");
    size_t ldcI4_4() => emitOp("ldc.i4.4");
    size_t ldcI4_5() => emitOp("ldc.i4.5");
    size_t ldcI4_6() => emitOp("ldc.i4.6");
    size_t ldcI4_7() => emitOp("ldc.i4.7");
    size_t ldcI4_8() => emitOp("ldc.i4.8");
    size_t ldcI4_M1() => emitOp("ldc.i4.m1");
    size_t ldcI4_S(byte value) { emitOp("ldc.i4.s"); buffer ~= (cast(ubyte*)&value)[0..byte.sizeof]; return 2; }
    size_t ldcI8(long value) { emitOp("ldc.i8"); buffer ~= (cast(ubyte*)&value)[0..long.sizeof]; return 1 + long.sizeof; }
    size_t ldcR4(float value) { emitOp("ldc.r4"); buffer ~= (cast(ubyte*)&value)[0..float.sizeof]; return 1 + float.sizeof; }
    size_t ldcR8(double value) { emitOp("ldc.r8"); buffer ~= (cast(ubyte*)&value)[0..double.sizeof]; return 1 + double.sizeof; }
    size_t ldelem(uint token) { emitOp("ldelem"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t ldelemI(uint token) { emitOp("ldelem.i"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t ldelemI1() => emitOp("ldelem.i1");
    size_t ldelemI2() => emitOp("ldelem.i2");
    size_t ldelemI4() => emitOp("ldelem.i4");
    size_t ldelemI8() => emitOp("ldelem.i8");
    size_t ldelemR4() => emitOp("ldelem.r4");
    size_t ldelemR8() => emitOp("ldelem.r8");
    size_t ldelemRef(uint token) { emitOp("ldelem.ref"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t ldelemU1() => emitOp("ldelem.u1");
    size_t ldelemU2() => emitOp("ldelem.u2");
    size_t ldelemU4() => emitOp("ldelem.u4");
    size_t ldelema(uint token) { emitOp("ldelema"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t ldfld(uint token) { emitOp("ldfld"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t ldflda(uint token) { emitOp("ldflda"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t ldftn(uint token) { emitOp("ldftn"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t ldindI() => emitOp("ldind.i");
    size_t ldindI1() => emitOp("ldind.i1");
    size_t ldindI2() => emitOp("ldind.i2");
    size_t ldindI4() => emitOp("ldind.i4");
    size_t ldindI8() => emitOp("ldind.i8");
    size_t ldindR4() => emitOp("ldind.r4");
    size_t ldindR8() => emitOp("ldind.r8");
    size_t ldindRef() => emitOp("ldind.ref");
    size_t ldindU1() => emitOp("ldind.u1");
    size_t ldindU2() => emitOp("ldind.u2");
    size_t ldindU4() => emitOp("ldind.u4");
    size_t ldlen() => emitOp("ldlen");
    size_t ldloc(ushort ix) { emitOp("ldloc"); buffer ~= (cast(ubyte*)&ix)[0..ushort.sizeof]; return 2 + ushort.sizeof; }
    size_t ldloc0() => emitOp("ldloc.0");
    size_t ldloc1() => emitOp("ldloc.1");
    size_t ldloc2() => emitOp("ldloc.2");
    size_t ldloc3() => emitOp("ldloc.3");
    size_t ldlocS(ubyte ix) { emitOp("ldloc.s"); buffer ~= (cast(ubyte*)&ix)[0..ubyte.sizeof]; return 2; }
    size_t ldloca(ushort ix) { emitOp("ldloca"); buffer ~= (cast(ubyte*)&ix)[0..ushort.sizeof]; return 2 + ushort.sizeof; }
    size_t ldlocaS(ubyte ix) { emitOp("ldloca.s"); buffer ~= (cast(ubyte*)&ix)[0..ubyte.sizeof]; return 2; }
    size_t ldnull() => emitOp("ldnull");
    size_t ldobj(uint token) { emitOp("ldobj"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t ldsfld(uint token) { emitOp("ldsfld"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t ldsflda(uint token) { emitOp("ldsflda"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t ldstr(uint token) { emitOp("ldstr"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t ldtoken(uint token) { emitOp("ldtoken"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t ldvirtftn(uint token) { emitOp("ldvirtftn"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t localloc() => emitOp("localloc");
    size_t mkrefany(uint token) { emitOp("mkrefany"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t mul() => emitOp("mul");
    size_t mulOvf() => emitOp("mul.ovf");
    size_t mulOvfUn() => emitOp("mul.ovf.un");
    size_t neg() => emitOp("neg");
    size_t newarr(uint token) { emitOp("newarr"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t newobj(uint token) { emitOp("newobj"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t nop() => emitOp("nop");
    size_t not_() => emitOp("not");
    size_t or_() => emitOp("or");
    size_t pop() => emitOp("pop");
    size_t refanytype() => emitOp("refanytype");
    size_t refanyval(uint token) { emitOp("refanyval"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t rem() => emitOp("rem");
    size_t remUn() => emitOp("rem.un");
    size_t ret() => emitOp("ret");
    size_t rethrow() => emitOp("rethrow");
    size_t shl() => emitOp("shl");
    size_t shr() => emitOp("shr");
    size_t shrUn() => emitOp("shr.un");
    size_t sizeof_(uint token) { emitOp("sizeof"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t starg(ushort ix) { emitOp("starg"); buffer ~= (cast(ubyte*)&ix)[0..ushort.sizeof]; return 2 + ushort.sizeof; }
    size_t stargS(ubyte ix) { emitOp("starg.s"); buffer ~= (cast(ubyte*)&ix)[0..ubyte.sizeof]; return 2; }
    size_t stelem(uint token) { emitOp("stelem"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t stelemI() => emitOp("stelem.i");
    size_t stelemI1() => emitOp("stelem.i1");
    size_t stelemI2() => emitOp("stelem.i2");
    size_t stelemI4() => emitOp("stelem.i4");
    size_t stelemI8() => emitOp("stelem.i8");
    size_t stelemR4() => emitOp("stelem.r4");
    size_t stelemR8() => emitOp("stelem.r8");
    size_t stelemRef(uint token) { emitOp("stelem.ref"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t stfld(uint token) { emitOp("stfld"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t stindI() => emitOp("stind.i");
    size_t stindI1() => emitOp("stind.i1");
    size_t stindI2() => emitOp("stind.i2");
    size_t stindI4() => emitOp("stind.i4");
    size_t stindI8() => emitOp("stind.i8");
    size_t stindR4() => emitOp("stind.r4");
    size_t stindR8() => emitOp("stind.r8");
    size_t stindRef() => emitOp("stind.ref");
    size_t stloc(ushort ix) { emitOp("stloc"); buffer ~= (cast(ubyte*)&ix)[0..ushort.sizeof]; return 2 + ushort.sizeof; }
    size_t stloc0() => emitOp("stloc.0");
    size_t stloc1() => emitOp("stloc.1");
    size_t stloc2() => emitOp("stloc.2");
    size_t stloc3() => emitOp("stloc.3");
    size_t stlocS(ubyte ix) { emitOp("stloc.s"); buffer ~= (cast(ubyte*)&ix)[0..ubyte.sizeof]; return 2; }
    size_t stobj(uint token) { emitOp("stobj"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t stsfld(uint token) { emitOp("stsfld"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t sub() => emitOp("sub");
    size_t subOvf() => emitOp("sub.ovf");
    size_t subOvfUn() => emitOp("sub.ovf.un");
    size_t throw_() => emitOp("throw");
    size_t unbox(uint token) { emitOp("unbox"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t unboxAny(uint token) { emitOp("unbox.any"); buffer ~= (cast(ubyte*)&token)[0..uint.sizeof]; return 5; }
    size_t xor_() => emitOp("xor");

    // Branch/jump by label (offset patched in finalize)
    size_t beq(string target)
    {
        emitOp("beq");
        size_t pos = buffer.length;
        branches ~= tuple(pos, target, "rel4");
        buffer.length += 4;
        return 5;
    }
    size_t beqS(string target)
    {
        emitOp("beq.s");
        size_t pos = buffer.length;
        branches ~= tuple(pos, target, "rel1");
        buffer.length += 1;
        return 2;
    }
    size_t bge(string target)
    {
        emitOp("bge");
        size_t pos = buffer.length;
        branches ~= tuple(pos, target, "rel4");
        buffer.length += 4;
        return 5;
    }
    size_t bgeS(string target)
    {
        emitOp("bge.s");
        size_t pos = buffer.length;
        branches ~= tuple(pos, target, "rel1");
        buffer.length += 1;
        return 2;
    }
    size_t bgeUn(string target)
    {
        emitOp("bge.un");
        size_t pos = buffer.length;
        branches ~= tuple(pos, target, "rel4");
        buffer.length += 4;
        return 5;
    }
    size_t bgeUnS(string target)
    {
        emitOp("bge.un.s");
        size_t pos = buffer.length;
        branches ~= tuple(pos, target, "rel1");
        buffer.length += 1;
        return 2;
    }
    size_t bgt(string target)
    {
        emitOp("bgt");
        size_t pos = buffer.length;
        branches ~= tuple(pos, target, "rel4");
        buffer.length += 4;
        return 5;
    }
    size_t bgtS(string target)
    {
        emitOp("bgt.s");
        size_t pos = buffer.length;
        branches ~= tuple(pos, target, "rel1");
        buffer.length += 1;
        return 2;
    }
    size_t bgtUn(string target)
    {
        emitOp("bgt.un");
        size_t pos = buffer.length;
        branches ~= tuple(pos, target, "rel4");
        buffer.length += 4;
        return 5;
    }
    size_t bgtUnS(string target)
    {
        emitOp("bgt.un.s");
        size_t pos = buffer.length;
        branches ~= tuple(pos, target, "rel1");
        buffer.length += 1;
        return 2;
    }
    size_t ble(string target)
    {
        emitOp("ble");
        size_t pos = buffer.length;
        branches ~= tuple(pos, target, "rel4");
        buffer.length += 4;
        return 5;
    }
    size_t bleS(string target)
    {
        emitOp("ble.s");
        size_t pos = buffer.length;
        branches ~= tuple(pos, target, "rel1");
        buffer.length += 1;
        return 2;
    }
    size_t bleUn(string target)
    {
        emitOp("ble.un");
        size_t pos = buffer.length;
        branches ~= tuple(pos, target, "rel4");
        buffer.length += 4;
        return 5;
    }
    size_t bleUnS(string target)
    {
        emitOp("ble.un.s");
        size_t pos = buffer.length;
        branches ~= tuple(pos, target, "rel1");
        buffer.length += 1;
        return 2;
    }
    size_t blt(string target)
    {
        emitOp("blt");
        size_t pos = buffer.length;
        branches ~= tuple(pos, target, "rel4");
        buffer.length += 4;
        return 5;
    }
    size_t bltS(string target)
    {
        emitOp("blt.s");
        size_t pos = buffer.length;
        branches ~= tuple(pos, target, "rel1");
        buffer.length += 1;
        return 2;
    }
    size_t bltUn(string target)
    {
        emitOp("blt.un");
        size_t pos = buffer.length;
        branches ~= tuple(pos, target, "rel4");
        buffer.length += 4;
        return 5;
    }
    size_t bltUnS(string target)
    {
        emitOp("blt.un.s");
        size_t pos = buffer.length;
        branches ~= tuple(pos, target, "rel1");
        buffer.length += 1;
        return 2;
    }
    size_t bneUn(string target)
    {
        emitOp("bne.un");
        size_t pos = buffer.length;
        branches ~= tuple(pos, target, "rel4");
        buffer.length += 4;
        return 5;
    }
    size_t bneUnS(string target)
    {
        emitOp("bne.un.s");
        size_t pos = buffer.length;
        branches ~= tuple(pos, target, "rel1");
        buffer.length += 1;
        return 2;
    }
    size_t br(string target)
    {
        emitOp("br");
        size_t pos = buffer.length;
        branches ~= tuple(pos, target, "rel4");
        buffer.length += 4;
        return 5;
    }
    size_t brS(string target)
    {
        emitOp("br.s");
        size_t pos = buffer.length;
        branches ~= tuple(pos, target, "rel1");
        buffer.length += 1;
        return 2;
    }
    size_t brfalse(string target)
    {
        emitOp("brfalse");
        size_t pos = buffer.length;
        branches ~= tuple(pos, target, "rel4");
        buffer.length += 4;
        return 5;
    }
    size_t brfalseS(string target)
    {
        emitOp("brfalse.s");
        size_t pos = buffer.length;
        branches ~= tuple(pos, target, "rel1");
        buffer.length += 1;
        return 2;
    }
    size_t brinst(string target)
    {
        emitOp("brinst");
        size_t pos = buffer.length;
        branches ~= tuple(pos, target, "rel4");
        buffer.length += 4;
        return 5;
    }
    size_t brinstS(string target)
    {
        emitOp("brinst.s");
        size_t pos = buffer.length;
        branches ~= tuple(pos, target, "rel1");
        buffer.length += 1;
        return 2;
    }
    size_t brnull(string target) { return brfalse(target); }
    size_t brnullS(string target) { return brfalseS(target); }
    size_t brtrue(string target)
    {
        emitOp("brtrue");
        size_t pos = buffer.length;
        branches ~= tuple(pos, target, "rel4");
        buffer.length += 4;
        return 5;
    }
    size_t brtrueS(string target)
    {
        emitOp("brtrue.s");
        size_t pos = buffer.length;
        branches ~= tuple(pos, target, "rel1");
        buffer.length += 1;
        return 2;
    }
    size_t brzero(string target) { return brfalse(target); }
    size_t brzeroS(string target) { return brfalseS(target); }
    size_t leave(string target)
    {
        emitOp("leave");
        size_t pos = buffer.length;
        branches ~= tuple(pos, target, "rel4");
        buffer.length += 4;
        return 5;
    }
    size_t leaveS(string target)
    {
        emitOp("leave.s");
        size_t pos = buffer.length;
        branches ~= tuple(pos, target, "rel1");
        buffer.length += 1;
        return 2;
    }

    // switch: targetLabels.length targets; offsets patched in finalize
    size_t switch_(string[] targetLabels)
    {
        emitOp("switch");
        size_t opcodeStart = buffer.length - 1;  // opcode is 1 byte
        size_t n = targetLabels.length;
        uint nVal = cast(uint)n;
        buffer ~= (cast(ubyte*)&nVal)[0..uint.sizeof];
        foreach (i; 0 .. n)
        {
            int placeholder = 0;
            buffer ~= (cast(ubyte*)&placeholder)[0..int.sizeof];
        }
        switches ~= tuple(opcodeStart, n, targetLabels.dup);
        return 1 + uint.sizeof + n * int.sizeof;
    }
}

// Smoke: Block API and branch patching
unittest
{
    Block b;
    with (b)
    {
        ldcI4_0();
        br("end");
        label("end");
        ret();
    }
    auto enc = b.finalize();
    assert(enc.length >= 6);
    assert(enc[0] == 0x16);  // ldc.i4.0
    assert(enc[1] == 0x38);  // br
    // offset at enc[2..6] = end - (2+4) = 2 (ret is at 6), so offset = 0
    assert(enc[6] == 0x2A);  // ret
}

unittest
{
    Block b;
    with (b)
    {
        ldcI4_1();
        brtrueS("l");
        ldcI4_0();
        label("l");
        ret();
    }
    auto enc = b.finalize();
    assert(enc.length >= 5);
    assert(enc[0] == 0x17);  // ldc.i4.1
    assert(enc[1] == 0x2D);  // brtrue.s
    assert(enc[3] == 0x16);  // ldc.i4.0
    assert(enc[4] == 0x2A);  // ret
}
