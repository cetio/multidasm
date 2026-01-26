// MIPS32 instruction encoding: R/I/J formats. All words stored big-endian (bits 31–24 first).
module gallinule.mips.encoding;

/// Append one 32-bit instruction word to buf in big-endian order (bits 31–24 first).
void appendWord(ref ubyte[] buf, uint w)
{
    buf ~= cast(ubyte)(w >> 24);
    buf ~= cast(ubyte)(w >> 16);
    buf ~= cast(ubyte)(w >> 8);
    buf ~= cast(ubyte)(w);
}

/// R-type: opcode(6) | rs(5) | rt(5) | rd(5) | shamt(5) | funct(6).
uint rtype(ubyte opcode, ubyte rs, ubyte rt, ubyte rd, ubyte shamt, ubyte funct)
{
    return (cast(uint)opcode << 26)
         | (cast(uint)(rs & 31) << 21)
         | (cast(uint)(rt & 31) << 16)
         | (cast(uint)(rd & 31) << 11)
         | (cast(uint)(shamt & 31) << 6)
         | (cast(uint)(funct & 63));
}

/// I-type: opcode(6) | rs(5) | rt(5) | imm16(16).
uint itype(ubyte opcode, ubyte rs, ubyte rt, short imm16)
{
    return (cast(uint)opcode << 26)
         | (cast(uint)(rs & 31) << 21)
         | (cast(uint)(rt & 31) << 16)
         | (cast(uint)(imm16 & 0xFFFF));
}

/// I-type with unsigned 16-bit immediate (e.g. andi, ori, xori).
uint itypeU(ubyte opcode, ubyte rs, ubyte rt, ushort imm16)
{
    return (cast(uint)opcode << 26)
         | (cast(uint)(rs & 31) << 21)
         | (cast(uint)(rt & 31) << 16)
         | (cast(uint)imm16);
}

/// J-type: opcode(6) | target26(26). target26 = (address >> 2) & 0x3FF_FFFF.
uint jtype(ubyte opcode, uint target26)
{
    return (cast(uint)opcode << 26) | (target26 & 0x3FF_FFFF);
}

/// Write 32-bit word at buf[pos..pos+4] in big-endian (for branch/jump patching).
void putWord(ubyte[] buf, size_t pos, uint w)
{
    buf[pos + 0] = cast(ubyte)(w >> 24);
    buf[pos + 1] = cast(ubyte)(w >> 16);
    buf[pos + 2] = cast(ubyte)(w >> 8);
    buf[pos + 3] = cast(ubyte)(w);
}
