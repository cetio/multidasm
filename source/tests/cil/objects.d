/// Object, token, and array opcodes.
module tests.cil.objects;

import multidasm.cil;

import unit_threaded;

@Name("boxes, unboxes, and allocates arrays")
unittest
{
    enum encoded = {
        Block block;
        with (block)
        {
            box(0x01000002);
            unboxAny(0x01000002);
            newarr(0x01000003);
            ldtoken(0x01000004);
        }
        return block.finalize();
    }();

    encoded.should == [
        0x8c, 0x02, 0x00, 0x00, 0x01,
        0xa5, 0x02, 0x00, 0x00, 0x01,
        0x8d, 0x03, 0x00, 0x00, 0x01,
        0xd0, 0x04, 0x00, 0x00, 0x01
    ];
}

@Name("takes the address of an array element")
unittest
{
    enum encoded = {
        Block block;
        with (block)
        {
            ldelema(0x01000002);
        }
        return block.finalize();
    }();

    encoded.should == [0x8f, 0x02, 0x00, 0x00, 0x01];
}

@Name("prefixes volatile and readonly access")
unittest
{
    enum encoded = {
        Block block;
        with (block)
        {
            volatile_();
            ldindI4();
            readonly_();
            ldelema(0x01000002);
        }
        return block.finalize();
    }();

    encoded.should == [
        0xfe, 0x13,
        0x4a,
        0xfe, 0x1e,
        0x8f, 0x02, 0x00, 0x00, 0x01
    ];
}
