/// Argument and local variable access.
module tests.cil.variables;

import multidasm.cil;

import unit_threaded;

@Name("loads arguments")
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
        }
        return block.finalize();
    }();

    encoded.should == [
        0xfe, 0x09, 0x2c, 0x01,
        0x0e, 0x07,
        0x02,
        0x03,
        0x04,
        0x05,
        0xfe, 0x0a, 0x2d, 0x01,
        0x0f, 0x08
    ];
}

@Name("stores arguments")
unittest
{
    enum encoded = {
        Block block;
        with (block)
        {
            starg(302);
            stargS(9);
        }
        return block.finalize();
    }();

    encoded.should == [
        0xfe, 0x0b, 0x2e, 0x01,
        0x10, 0x09
    ];
}

@Name("loads locals")
unittest
{
    enum encoded = {
        Block block;
        with (block)
        {
            ldloc(303);
            ldlocS(10);
            ldloc0();
            ldloc1();
            ldloc2();
            ldloc3();
            ldloca(304);
            ldlocaS(11);
        }
        return block.finalize();
    }();

    encoded.should == [
        0xfe, 0x0c, 0x2f, 0x01,
        0x11, 0x0a,
        0x06,
        0x07,
        0x08,
        0x09,
        0xfe, 0x0d, 0x30, 0x01,
        0x12, 0x0b
    ];
}

@Name("stores locals")
unittest
{
    enum encoded = {
        Block block;
        with (block)
        {
            stloc(305);
            stlocS(12);
            stloc0();
            stloc1();
            stloc2();
            stloc3();
        }
        return block.finalize();
    }();

    encoded.should == [
        0xfe, 0x0e, 0x31, 0x01,
        0x13, 0x0c,
        0x0a,
        0x0b,
        0x0c,
        0x0d
    ];
}
