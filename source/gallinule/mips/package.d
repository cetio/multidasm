// MIPS32 integer core assembler; instructions stored big-endian.
// Scope: integer ALU, load/store, branches, jumps; label resolution in finalize(). MIPS64/FP later.
module gallinule.mips;

public import gallinule.mips.types;
import gallinule.mips.encoding;
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
                assert(offsetWords >= -32768 && offsetWords <= 32767, "Branch offset out of range");
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

// Expected bytes for specific instruction sequences (MIPS32, big-endian).
unittest
{
    import std.string : toLower;
    import tern.digest;

    Block b1;
    with (b1) add(rzero, rzero, rzero);
    assert(b1.finalize().toHexString.toLower == "00000020", "add(rzero,rzero,rzero) expected 00000020");

    Block b2;
    with (b2) addiu(rat, rzero, 5);
    assert(b2.finalize().toHexString.toLower == "24010005", "addiu(rat,rzero,5) expected 24010005");

    Block b3;
    with (b3) lui(rv0, 0x1234);
    assert(b3.finalize().toHexString.toLower == "3c021234", "lui(rv0,0x1234) expected 3c021234");
}

// lw rt, offset(base): 0x8c040004 for lw $4,4($0).
unittest
{
    import tern.digest;
    Block block;
    with (block) lw(ra0, rzero, 4);
    auto enc = block.finalize();
    assert(enc.length == 4 && enc[0] == 0x8c && enc[1] == 0x04 && enc[2] == 0x00 && enc[3] == 0x04,
        "lw(ra0,rzero,4) expected 8c040004, got "~enc.toHexString);
}

// beq with label: offset patched to 0 (label immediately after), encoding 0x10000000.
unittest
{
    import tern.digest;
    Block block;
    with (block)
    {
        beq(rzero, rzero, "x");
        label("x");
    }
    auto enc = block.finalize();
    assert(enc.length == 4 && enc[0] == 0x10 && enc[1] == 0x00 && enc[2] == 0x00 && enc[3] == 0x00,
        "beq(rzero,rzero,\"x\")+label(\"x\") expected 10000000, got "~enc.toHexString);
}

// j(label): J-type patched to target26=1 (address 4 >> 2), encoding 0x08000001.
unittest
{
    import tern.digest;
    Block block;
    with (block)
    {
        j("there");
        label("there");
    }
    auto enc = block.finalize();
    assert(enc.length == 4 && enc[0] == 0x08 && enc[1] == 0x00 && enc[2] == 0x00 && enc[3] == 0x01,
        "j(\"there\")+label(\"there\") expected 08000001, got "~enc.toHexString);
}

unittest
{
    import std.string : toLower;
    import tern.digest;
    Block block;
    with (block)
    {
        add(rt1, rs0, rt2);       // 020a4820
        addiu(rt3, rzero, 10);    // 240b000a
        lui(rv0, 0x8000);         // 3c028000
        lw(ra0, rsp, -4);         // 8fa4fffc
        sw(ra0, rsp, 0);          // afa40000
        label("loop");
        beq(ra0, rzero, "loop");  // 1080ffff
        j("end");                 // 08000007
        label("end");
        syscall();                // 0000000c
    }
    auto enc = block.finalize();
    assert(enc.toHexString.toLower == "020a4820240b000a3c0280008fa4fffcafa400001080ffff080000070000000c",
        "integration: expected full 32-byte sequence, got "~enc.toHexString);
}
