/// Atomic memory prefixes.
module tests.amd64.atomics;

import multidasm.amd64;

import unit_threaded;

@Name("prefixes locked instructions")
unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            lock(add(dwordPtr(rax), ebx));
            xacquire_lock(sub(dwordPtr(rdi), esi));
            xrelease(mov(dwordPtr(rdx), ecx));
        }
        return block.finalize();
    }();

    encoded.should == [
        0xf0, 0x01, 0x18,
        0xf2, 0xf0, 0x29, 0x37,
        0xf3, 0x89, 0x0a
    ];
}
