/// Conditional branches.
module tests.mips.branch;

import multidasm.mips;

import unit_threaded;

@Name("branches to labels")
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

    encoded.should == [
        0x10, 0x85, 0x00, 0x05,
        0x14, 0xc7, 0x00, 0x04,
        0x19, 0x00, 0x00, 0x03,
        0x1d, 0x20, 0x00, 0x02,
        0x05, 0x40, 0x00, 0x01,
        0x05, 0x61, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x0c
    ];
}
