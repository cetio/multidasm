/// Jumps.
module tests.mips.jump;

import multidasm.mips;

import unit_threaded;

@Name("jumps and links to labels")
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

    encoded.should == [
        0x08, 0x00, 0x00, 0x03,
        0x0c, 0x00, 0x00, 0x03,
        0x02, 0x0a, 0x48, 0x20,
        0x00, 0x00, 0x00, 0x0c
    ];
}
