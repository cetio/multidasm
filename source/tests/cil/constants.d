/// Constant-loading opcodes.
module tests.cil.constants;

import multidasm.cil;

import unit_threaded;

@Name("loads integer constants")
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
        }
        return block.finalize();
    }();

    encoded.should == [
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
        0x21, 0x08, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02, 0x01
    ];
}

@Name("loads real constants")
unittest
{
    enum encoded = {
        Block block;
        with (block)
        {
            ldcR4(1.5f);
            ldcR8(-2.25);
        }
        return block.finalize();
    }();

    encoded.should == [
        0x22, 0x00, 0x00, 0xc0, 0x3f,
        0x23, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0xc0
    ];
}

@Name("loads null and string constants")
unittest
{
    enum encoded = {
        Block block;
        with (block)
        {
            ldnull();
            ldstr(0x70000005);
        }
        return block.finalize();
    }();

    encoded.should == [
        0x14,
        0x72, 0x05, 0x00, 0x00, 0x70
    ];
}
