module tests.mips;

import multidasm.mips;

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
