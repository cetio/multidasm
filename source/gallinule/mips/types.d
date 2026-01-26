// Types and register aliases for gallinule.mips (MIPS32 integer core; GPR, Mem, rzero–rra).
module gallinule.mips.types;

/// 5-bit general-purpose register (0–31).
public struct GPR
{
    ubyte index;
    this(ubyte i) { assert(i < 32); index = i; }
}

/// Memory operand for load/store: base register + 16-bit signed offset.
public struct Mem
{
    GPR base;
    short offset;
    this(GPR b, short o) { base = b; offset = o; }
    this(GPR b, int o) { base = b; offset = cast(short)o; assert(o >= short.min && o <= short.max); }
}

public:
enum rzero = GPR(0);
enum rat   = GPR(1);
enum rv0   = GPR(2);
enum rv1   = GPR(3);
enum ra0   = GPR(4);
enum ra1   = GPR(5);
enum ra2   = GPR(6);
enum ra3   = GPR(7);
enum rt0   = GPR(8);
enum rt1   = GPR(9);
enum rt2   = GPR(10);
enum rt3   = GPR(11);
enum rt4   = GPR(12);
enum rt5   = GPR(13);
enum rt6   = GPR(14);
enum rt7   = GPR(15);
enum rs0   = GPR(16);
enum rs1   = GPR(17);
enum rs2   = GPR(18);
enum rs3   = GPR(19);
enum rs4   = GPR(20);
enum rs5   = GPR(21);
enum rs6   = GPR(22);
enum rs7   = GPR(23);
enum rt8   = GPR(24);
enum rt9   = GPR(25);
enum rk0   = GPR(26);
enum rk1   = GPR(27);
enum rgp   = GPR(28);
enum rsp   = GPR(29);
enum rfp   = GPR(30);
enum rra   = GPR(31);
