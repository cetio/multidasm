module tests.cil;

import multidasm.cil;

unittest
{
    enum encoded = {
        Block block;
        with (block)
        {
            ldcI4_M1();
            ldcI4_0();
            ldcI4_1();
            ldcI4_2();
            ldcI4_3();
            ldcI4_4();
            ldcI4_5();
            ldcI4_6();
            ldcI4_7();
            ldcI4_8();
            ldcI4_S(-5);
            ldcI4(0x12345678);
            ldcI8(0x0102030405060708);
            ldcR4(1.5f);
            ldcR8(-2.25);
            add();
            sub();
            mul();
            div();
            divUn();
            rem();
            remUn();
            and_();
            or_();
            xor_();
            shl();
            shr();
            shrUn();
            neg();
            not_();
            ret();
        }
        return block.finalize();
    }();
    enum ubyte[] EXPECTED = [
        0x15,
        0x16,
        0x17,
        0x18,
        0x19,
        0x1a,
        0x1b,
        0x1c,
        0x1d,
        0x1e,
        0x1f, 0xfb,
        0x20, 0x78, 0x56, 0x34, 0x12,
        0x21, 0x08, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02, 0x01,
        0x22, 0x00, 0x00, 0xc0, 0x3f,
        0x23, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0xc0,
        0x58,
        0x59,
        0x5a,
        0x5b,
        0x5c,
        0x5d,
        0x5e,
        0x5f,
        0x60,
        0x61,
        0x62,
        0x63,
        0x64,
        0x65,
        0x66,
        0x2a
    ];
    static assert(encoded == EXPECTED);
}

unittest
{
    enum encoded = {
        Block block;
        with (block)
        {
            ldarg(300);
            ldargS(7);
            ldarg0();
            ldarg1();
            ldarg2();
            ldarg3();
            ldarga(301);
            ldargaS(8);
            starg(302);
            stargS(9);
            ldloc(303);
            ldlocS(10);
            ldloc0();
            ldloc1();
            ldloc2();
            ldloc3();
            ldloca(304);
            ldlocaS(11);
            stloc(305);
            stlocS(12);
            stloc0();
            stloc1();
            stloc2();
            stloc3();
            ret();
        }
        return block.finalize();
    }();
    enum ubyte[] EXPECTED = [
        0xfe, 0x09, 0x2c, 0x01,
        0x0e, 0x07,
        0x02,
        0x03,
        0x04,
        0x05,
        0xfe, 0x0a, 0x2d, 0x01,
        0x0f, 0x08,
        0xfe, 0x0b, 0x2e, 0x01,
        0x10, 0x09,
        0xfe, 0x0c, 0x2f, 0x01,
        0x11, 0x0a,
        0x06,
        0x07,
        0x08,
        0x09,
        0xfe, 0x0d, 0x30, 0x01,
        0x12, 0x0b,
        0xfe, 0x0e, 0x31, 0x01,
        0x13, 0x0c,
        0x0a,
        0x0b,
        0x0c,
        0x0d,
        0x2a
    ];
    static assert(encoded == EXPECTED);
}

unittest
{
    enum encoded = {
        Block block;
        with (block)
        {
            ldnull();
            box(0x01000002);
            unboxAny(0x01000002);
            newarr(0x01000003);
            ldtoken(0x01000004);
            ldstr(0x70000005);
            call(0x0a000001);
            ret();
        }
        return block.finalize();
    }();
    enum ubyte[] EXPECTED = [
        0x14,
        0x8c, 0x02, 0x00, 0x00, 0x01,
        0xa5, 0x02, 0x00, 0x00, 0x01,
        0x8d, 0x03, 0x00, 0x00, 0x01,
        0xd0, 0x04, 0x00, 0x00, 0x01,
        0x72, 0x05, 0x00, 0x00, 0x70,
        0x28, 0x01, 0x00, 0x00, 0x0a,
        0x2a
    ];
    static assert(encoded == EXPECTED);
}

unittest
{
    enum encoded = {
        Block block;
        with (block)
        {
            beqS("beq");
            label("beq");
            bgeS("bge");
            label("bge");
            bgeUnS("bgeUn");
            label("bgeUn");
            bgtS("bgt");
            label("bgt");
            bgtUnS("bgtUn");
            label("bgtUn");
            bleS("ble");
            label("ble");
            bleUnS("bleUn");
            label("bleUn");
            bltS("blt");
            label("blt");
            bltUnS("bltUn");
            label("bltUn");
            bneUnS("bneUn");
            label("bneUn");
            brS("br");
            label("br");
            brfalseS("brfalse");
            label("brfalse");
            brtrueS("brtrue");
            label("brtrue");
            leaveS("leave");
            label("leave");
            ret();
        }
        return block.finalize();
    }();
    enum ubyte[] EXPECTED = [
        0x2e, 0x00,
        0x2f, 0x00,
        0x34, 0x00,
        0x30, 0x00,
        0x35, 0x00,
        0x31, 0x00,
        0x36, 0x00,
        0x32, 0x00,
        0x37, 0x00,
        0x33, 0x00,
        0x2b, 0x00,
        0x2c, 0x00,
        0x2d, 0x00,
        0xde, 0x00,
        0x2a
    ];
    static assert(encoded == EXPECTED);
}

unittest
{
    enum encoded = {
        Block block;
        with (block)
        {
            beq("beq");
            label("beq");
            bge("bge");
            label("bge");
            bgeUn("bgeUn");
            label("bgeUn");
            bgt("bgt");
            label("bgt");
            bgtUn("bgtUn");
            label("bgtUn");
            ble("ble");
            label("ble");
            bleUn("bleUn");
            label("bleUn");
            blt("blt");
            label("blt");
            bltUn("bltUn");
            label("bltUn");
            bneUn("bneUn");
            label("bneUn");
            br("br");
            label("br");
            brfalse("brfalse");
            label("brfalse");
            brtrue("brtrue");
            label("brtrue");
            leave("leave");
            label("leave");
            ret();
        }
        return block.finalize();
    }();
    enum ubyte[] EXPECTED = [
        0x3b, 0x00, 0x00, 0x00, 0x00,
        0x3c, 0x00, 0x00, 0x00, 0x00,
        0x41, 0x00, 0x00, 0x00, 0x00,
        0x3d, 0x00, 0x00, 0x00, 0x00,
        0x42, 0x00, 0x00, 0x00, 0x00,
        0x3e, 0x00, 0x00, 0x00, 0x00,
        0x43, 0x00, 0x00, 0x00, 0x00,
        0x3f, 0x00, 0x00, 0x00, 0x00,
        0x44, 0x00, 0x00, 0x00, 0x00,
        0x40, 0x00, 0x00, 0x00, 0x00,
        0x38, 0x00, 0x00, 0x00, 0x00,
        0x39, 0x00, 0x00, 0x00, 0x00,
        0x3a, 0x00, 0x00, 0x00, 0x00,
        0xdd, 0x00, 0x00, 0x00, 0x00,
        0x2a
    ];
    static assert(encoded == EXPECTED);
}

unittest
{
    enum encoded = {
        Block block;
        with (block)
        {
            switch_(["case0", "case1", "case2"]);
            label("case0");
            label("case1");
            label("case2");
            volatile_();
            ldindI4();
            readonly_();
            ldelema(0x01000002);
            tail_();
            call(0x0a000001);
            ret();
        }
        return block.finalize();
    }();
    enum ubyte[] EXPECTED = [
        0x45, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0xfe, 0x13,
        0x4a,
        0xfe, 0x1e,
        0x8f, 0x02, 0x00, 0x00, 0x01,
        0xfe, 0x14,
        0x28, 0x01, 0x00, 0x00, 0x0a,
        0x2a
    ];
    static assert(encoded == EXPECTED);
}
