/// CET shadow-stack instructions.
module tests.amd64.cet;

import multidasm.amd64;

import unit_threaded;

@Name("restores a shadow stack pointer")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            rstorssp(qwordPtr(rbx));
        }
        return block.finalize();
    }();

    encoded.should == [0xf3, 0x48, 0x0f, 0x01, 0x2b];
}

@Name("saves the previous shadow stack pointer")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            saveprevssp();
        }
        return block.finalize();
    }();

    encoded.should == [0xf3, 0x0f, 0x01, 0xea];
}

@Name("writes shadow stack entries with wrss and wruss")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            wrssd(dwordPtr(rbx), eax);
            wrussd(dwordPtr(rbx), eax);
        }
        return block.finalize();
    }();

    encoded.should == [
        0x0f, 0x38, 0xf6, 0x03,
        0x66, 0x0f, 0x38, 0xf5, 0x03
    ];
}
