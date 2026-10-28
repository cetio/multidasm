/// Arithmetic, bitwise, and shift opcodes.
module tests.cil.arithmetic;

import multidasm.cil;

import unit_threaded;

@Name("applies arithmetic")
unittest
{
    enum encoded = {
        Block block;
        with (block)
        {
            add();
            sub();
            mul();
            div();
            divUn();
            rem();
            remUn();
            neg();
        }
        return block.finalize();
    }();

    encoded.should == [
        0x58,
        0x59,
        0x5a,
        0x5b,
        0x5c,
        0x5d,
        0x5e,
        0x65
    ];
}

@Name("applies bitwise operations")
unittest
{
    enum encoded = {
        Block block;
        with (block)
        {
            and_();
            or_();
            xor_();
            not_();
        }
        return block.finalize();
    }();

    encoded.should == [
        0x5f,
        0x60,
        0x61,
        0x66
    ];
}

@Name("shifts")
unittest
{
    enum encoded = {
        Block block;
        with (block)
        {
            shl();
            shr();
            shrUn();
        }
        return block.finalize();
    }();

    encoded.should == [
        0x62,
        0x63,
        0x64
    ];
}
