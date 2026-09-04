// MIPS32 integer core assembler; instructions stored big-endian.
// Scope: integer ALU, load/store, branches, jumps; label resolution in finalize(). MIPS64/FP later.
module multidasm.mips;

public import multidasm.mips.types;
import multidasm.mips.encoding;
import std.typecons;

// https://www.cs.cmu.edu/afs/cs/academic/class/15740-f97/public/doc/mips-isa.pdf
package:
enum
{
    s = 0b00000,
    d = 0b00001,
    q = 0b00011,
    w = 0b00100,
    l = 0b00101,
    ps = 0b01000,

    special = 0b000000,
    cop1 = 0b010001,
    cop1x = 0b010011,

    addi = 0b001000,
    addiu = 0b001001,
    add = 0b100000,
    addu = 0b100001,
    and = 0b100100,
    andi = 0b001100,
    beq = 0b000100,
    beql = 0b010100,
    bgez = 0b00001,
    regimm = 0b000001,
    bgezal = 0b10001,
    bgezall = 0b10011,
    bgezl = 0b00011,
    bgtz = 0b000111,
    bgtzl = 0b010111,
    blez = 0b000110,
    blezl = 0b010110,
    bltz = 0b00000,
    bltzal = 0b10000,
    bltzall = 0b10010,
    bltzl = 0b00010,
    bne = 0b000101,
    bnel = 0b010101,
    brk = 0b001101,
    copz = 0b010000,
    dadd = 0b101100,
    daddi = 0b011000,
    daddiu = 0b011001,
    daddu = 0b101101,
    ddiv = 0b011110,
    ddivu = 0b011111,
    div = 0b011010,
    divu = 0b011011,
    dmult = 0b011100,
    dmultu = 0b011101,
    dsll = 0b111000,
    dsll32 = 0b111100,
    dsllv = 0b010100,
    dsra = 0b111011,
    dsra32 = 0b111111,
    dsrav = 0b010111,
    dsrl = 0b111010,
    dsrl32 = 0b111110,
    dsrlv = 0b010110,
    dsub = 0b101110,
    dsubu = 0b101111,
    j = 0b000010,
    jal = 0b000011,
    jalr = 0b001001,
    jr = 0b001000,
    lb = 0b100000,
    lbu = 0b100100,
    ld = 0b110111,
    ldcz = 0b110100,
    ldl = 0b011010,
    ldr = 0b011011,
    lh = 0b100001,
    lhu = 0b100101,
    ll = 0b110000,
    lld = 0b110100,
    lui = 0b001111,
    lw = 0b100011,
    lwcz = 0b110000,
    lwl = 0b100010,
    lwr = 0b100110,
    lwu = 0b100111,
    mfhi = 0b010000,
    mflo = 0b010010,
    movn = 0b001011,
    movz = 0b001010,
    mthi = 0b010001,
    mtlo = 0b010011,
    mult = 0b011000,
    multu = 0b011001,
    nor = 0b100111,
    or = 0b100101,
    ori = 0b001101,
    pref = 0b110011,
    sb = 0b101000,
    sc = 0b111000,
    scd = 0b111100,
    sd = 0b111111,
    sdcz = 0b111100,
    sdl = 0b101100,
    sdr = 0b101101,
    sh = 0b101001,
    sllv = 0b000100,
    slt = 0b101010,
    slti = 0b001010,
    sltiu = 0b001011,
    sltu = 0b101011,
    sra = 0b000011,
    srav = 0b000111,
    srl = 0b000010,
    srlv = 0b000110,
    sub = 0b100010,
    subu = 0b100011,
    sw = 0b101011,
    swcz = 0b111000,
    swl = 0b101010,
    swr = 0b101110,
    sync = 0b001111,
    syscall = 0b001100,
    teq = 0b110100,
    teqi = 0b01100,
    tge = 0b110000,
    tgei = 0b01000,
    tgeiu = 0b01001,
    tgeu = 0b110001,
    tlt = 0b110010,
    tlti = 0b01010,
    tltiu = 0b01011,
    tltu = 0b110011,
    tne = 0b110110,
    tnei = 0b01110,
    xor = 0b100110,
    xori = 0b001110,

    fabs = 0b000101,
    fadd = 0b000000,
    bc = 0b01000,
    fc = 0b11,
    fceill = 0b001010,
    fceilw = 0b001110,
    cf = 0b00010,
    ct = 0b00110,
    fcvtd = 0b100001,
    fcvtl = 0b100101,
    fcvts = 0b100000,
    fcvtw = 0b100100,
    fdiv = 0b000011,
    dmf = 0b00001,
    dmt = 0b00101,
    ffloorl = 0b001011,
    ffloorw = 0b001111,
    ldc1 = 0b110101,
    ldcxc1 = 0b000001,
    lwc1 = 0b110001,
    lwxc1 = 0b000000,
    madd = 0b100,
    mf = 0b00000,
    fmov = 0b000110,
    movci = 0b000001,
    movcf = 0b010001,
    fmovn = 0b010011,
    fmovz = 0b010010,
    msub = 0b101,
    mt = 0b00100,
    fmul = 0b000010,
    fneg = 0b000111,
    nmadd = 0b110,
    nmsub = 0b111,
    prefx = 0b001111,
    recip = 0b010101,
    froundl = 0b001000,
    froundw = 0b001100,
    frsqrt = 0b010110,
    sdc1 = 0b111101,
    sdxc1 = 0b001001,
    fsqrt = 0b000100,
    fsub = 0b000001,
    swc1 = 0b111001,
    swxc1 = 0b001000,
    ftruncl = 0b001001,
    ftruncw = 0b001101,
}

struct Block
{
package:
final:
    ptrdiff_t[string] labels;
    Tuple!(size_t, string, string, ubyte, ubyte)[] branches;  // pos, label, kind, rs, rt (rt=0 for J-type)
    ubyte[] buffer;

public:
    size_t emit(uint word)
    {
        appendWord(buffer, word);
        return 4;
    }

    ubyte[] finalize()
    {
        foreach (ref br; branches)
        {
            immutable pos = br[0];
            immutable name = br[1];
            immutable kind = br[2];
            immutable rs = br[3];
            immutable rt = br[4];
            assert(name in labels, "Branch/jump label not defined: "~name);
            immutable target = labels[name];

            if (kind == "j" || kind == "jal")
            {
                immutable target26 = (target >> 2) & 0x3FF_FFFFu;
                immutable op = (kind == "j") ? .j : .jal;
                putWord(buffer, pos, jtype(cast(ubyte)op, target26));
            }
            else
            {
                immutable diff = cast(ptrdiff_t)target - cast(ptrdiff_t)(pos + 4);
                immutable offsetWords = diff / 4;
                assert(offsetWords >= -32_768 && offsetWords <= 32_767, "Branch offset out of range");
                immutable short imm16 = cast(short)offsetWords;
                uint w;
                switch (kind)
                {
                    case "beq":  w = itype(cast(ubyte).beq, rs, rt, imm16); break;
                    case "bne":  w = itype(cast(ubyte).bne, rs, rt, imm16); break;
                    case "blez": w = itype(cast(ubyte).blez, rs, rt, imm16); break;
                    case "bgtz": w = itype(cast(ubyte).bgtz, rs, rt, imm16); break;
                    case "bltz": w = itype(cast(ubyte).regimm, rs, rt, imm16); break;  // rt = .bltz
                    case "bgez": w = itype(cast(ubyte).regimm, rs, rt, imm16); break;  // rt = .bgez
                    default: assert(0, "Unknown branch kind: "~kind);
                }
                putWord(buffer, pos, w);
            }
        }
        branches = null;
        return buffer;
    }

    auto label(string name) => labels[name] = buffer.length;

    mixin(import("instructions/core.d"));
    mixin(import("instructions/loadstore.d"));
    mixin(import("instructions/branch.d"));
    mixin(import("instructions/jump.d"));
}

unittest
{
    enum encoded = {
        Block block;
        with (block)
        {
            add(rt1, rs0, rt2);
            addu(rt3, rt4, rt5);
            sub(rt6, rt7, rt8);
            subu(rt9, rk0, rk1);
            and_(ra0, ra1, ra2);
            or_(ra3, rt0, rt1);
            xor_(rt2, rt3, rt4);
            nor(rt5, rt6, rt7);
            slt(rs0, rs1, rs2);
            sltu(rs3, rs4, rs5);
        }
        return block.finalize();
    }();

    enum ubyte[] EXPECTED = [
        0x02, 0x0a, 0x48, 0x20,
        0x01, 0x8d, 0x58, 0x21,
        0x01, 0xf8, 0x70, 0x22,
        0x03, 0x5b, 0xc8, 0x23,
        0x00, 0xa6, 0x20, 0x24,
        0x01, 0x09, 0x38, 0x25,
        0x01, 0x6c, 0x50, 0x26,
        0x01, 0xcf, 0x68, 0x27,
        0x02, 0x32, 0x80, 0x2a,
        0x02, 0x95, 0x98, 0x2b
    ];

    static assert(encoded == EXPECTED);
}

unittest
{
    enum encoded = {
        Block block;
        with (block)
        {
            addi(rat, rzero, -5);
            addiu(rv0, rat, 10);
            andi(rv1, rv0, 0x1234);
            ori(ra0, rv1, 0x8000);
            xori(ra1, ra0, 0xff);
            slti(ra2, ra1, -1);
            sltiu(ra3, ra2, 1);
            lui(rt0, 0xabcd);
            sll(rt1, rt2, 3);
            srl(rt3, rt4, 4);
            sra(rt5, rt6, 5);
            sllv(rt7, rs0, rs1);
            srlv(rs2, rs3, rs4);
            srav(rs5, rs6, rs7);
        }
        return block.finalize();
    }();

    enum ubyte[] EXPECTED = [
        0x20, 0x01, 0xff, 0xfb,
        0x24, 0x22, 0x00, 0x0a,
        0x30, 0x43, 0x12, 0x34,
        0x34, 0x64, 0x80, 0x00,
        0x38, 0x85, 0x00, 0xff,
        0x28, 0xa6, 0xff, 0xff,
        0x2c, 0xc7, 0x00, 0x01,
        0x3c, 0x08, 0xab, 0xcd,
        0x00, 0x0a, 0x48, 0xc0,
        0x00, 0x0c, 0x59, 0x02,
        0x00, 0x0e, 0x69, 0x43,
        0x02, 0x30, 0x78, 0x04,
        0x02, 0x93, 0x90, 0x06,
        0x02, 0xf6, 0xa8, 0x07
    ];

    static assert(encoded == EXPECTED);
}

unittest
{
    enum encoded = {
        Block block;
        with (block)
        {
            mult(ra0, ra1);
            multu(ra2, ra3);
            div(rt0, rt1);
            divu(rt2, rt3);
            mfhi(rt4);
            mflo(rt5);
            mthi(rt6);
            mtlo(rt7);
            movz(rs0, rs1, rs2);
            movn(rs3, rs4, rs5);
            jr(rra);
            jalr(rs6, rs7);
            syscall();
            break_(341);
        }
        return block.finalize();
    }();

    enum ubyte[] EXPECTED = [
        0x00, 0x85, 0x00, 0x18,
        0x00, 0xc7, 0x00, 0x19,
        0x01, 0x09, 0x00, 0x1a,
        0x01, 0x4b, 0x00, 0x1b,
        0x00, 0x00, 0x60, 0x10,
        0x00, 0x00, 0x68, 0x12,
        0x01, 0xc0, 0x00, 0x11,
        0x01, 0xe0, 0x00, 0x13,
        0x02, 0x32, 0x80, 0x0a,
        0x02, 0x95, 0x98, 0x0b,
        0x03, 0xe0, 0x00, 0x08,
        0x02, 0xe0, 0xb0, 0x09,
        0x00, 0x00, 0x00, 0x0c,
        0x01, 0x55, 0x00, 0x0d
    ];

    static assert(encoded == EXPECTED);
}

unittest
{
    enum encoded = {
        Block block;
        with (block)
        {
            lb(ra0, rsp, -4);
            lbu(ra1, Mem(rs0, 8));
            lh(ra2, rs1, -16);
            lhu(ra3, Mem(rs2, 32));
            lw(rt0, rs3, 64);
            sb(rt1, Mem(rs4, -8));
            sh(rt2, rs5, 12);
            sw(rt3, Mem(rs6, 128));
        }
        return block.finalize();
    }();

    enum ubyte[] EXPECTED = [
        0x83, 0xa4, 0xff, 0xfc,
        0x92, 0x05, 0x00, 0x08,
        0x86, 0x26, 0xff, 0xf0,
        0x96, 0x47, 0x00, 0x20,
        0x8e, 0x68, 0x00, 0x40,
        0xa2, 0x89, 0xff, 0xf8,
        0xa6, 0xaa, 0x00, 0x0c,
        0xae, 0xcb, 0x00, 0x80
    ];

    static assert(encoded == EXPECTED);
}

unittest
{
    enum encoded = {
        Block block;
        with (block)
        {
            beq(ra0, ra1, "target");
            bne(ra2, ra3, "target");
            blez(rt0, "target");
            bgtz(rt1, "target");
            bltz(rt2, "target");
            bgez(rt3, "target");
            label("target");
            syscall();
        }
        return block.finalize();
    }();

    enum ubyte[] EXPECTED = [
        0x10, 0x85, 0x00, 0x05,
        0x14, 0xc7, 0x00, 0x04,
        0x19, 0x00, 0x00, 0x03,
        0x1d, 0x20, 0x00, 0x02,
        0x05, 0x40, 0x00, 0x01,
        0x05, 0x61, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x0c
    ];

    static assert(encoded == EXPECTED);
}

unittest
{
    enum encoded = {
        Block block;
        with (block)
        {
            j("target");
            jal("target");
            add(rt1, rs0, rt2);
            label("target");
            syscall();
        }
        return block.finalize();
    }();

    enum ubyte[] EXPECTED = [
        0x08, 0x00, 0x00, 0x03,
        0x0c, 0x00, 0x00, 0x03,
        0x02, 0x0a, 0x48, 0x20,
        0x00, 0x00, 0x00, 0x0c
    ];
    
    static assert(encoded == EXPECTED);
}
