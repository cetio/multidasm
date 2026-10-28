/// Conditional and unconditional branches.
module tests.cil.branches;

import multidasm.cil;

import unit_threaded;

@Name("branches with a one-byte offset")
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
        }
        return block.finalize();
    }();

    encoded.should == [
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
        0xde, 0x00
    ];
}

@Name("branches with a four-byte offset")
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
        }
        return block.finalize();
    }();

    encoded.should == [
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
        0xdd, 0x00, 0x00, 0x00, 0x00
    ];
}

@Name("builds a switch table")
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
        }
        return block.finalize();
    }();

    encoded.should == [
        0x45, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    ];
}
