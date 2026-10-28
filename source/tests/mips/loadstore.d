/// Load and store instructions.
module tests.mips.loadstore;

import multidasm.mips;

import unit_threaded;

@Name("loads bytes, halfwords, and words")
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
        }
        return block.finalize();
    }();

    encoded.should == [
        0x83, 0xa4, 0xff, 0xfc,
        0x92, 0x05, 0x00, 0x08,
        0x86, 0x26, 0xff, 0xf0,
        0x96, 0x47, 0x00, 0x20,
        0x8e, 0x68, 0x00, 0x40
    ];
}

@Name("stores bytes, halfwords, and words")
unittest
{
    enum encoded = {
        Block block;
        with (block)
        {
            sb(rt1, Mem(rs4, -8));
            sh(rt2, rs5, 12);
            sw(rt3, Mem(rs6, 128));
        }
        return block.finalize();
    }();

    encoded.should == [
        0xa2, 0x89, 0xff, 0xf8,
        0xa6, 0xaa, 0x00, 0x0c,
        0xae, 0xcb, 0x00, 0x80
    ];
}
