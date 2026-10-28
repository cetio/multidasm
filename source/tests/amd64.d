module tests.amd64;

import multidasm.amd64;

unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            push(rcx);
            pop(rbx);
            mov(eax, ecx);
            movsxd(rcx, eax);
            mov(ebx, 1);
            add(eax, ebx);
            sub(rdi, 10);
            test(al, bl);
            inc(eax);
            dec(rax);
        }
        return block.finalize();
    }();

    enum ubyte[] EXPECTED = [
        0x51,
        0x5b,
        0x89, 0xc8,
        0x48, 0x63, 0xc8,
        0xbb, 0x01, 0x00, 0x00, 0x00,
        0x01, 0xd8,
        0x48, 0x83, 0xef, 0x0a,
        0x84, 0xd8,
        0xff, 0xc0,
        0x48, 0xff, 0xc8
    ];
    
    static assert(encoded == EXPECTED);
}

unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            mov(eax, dwordPtr(rbx));
            mov(dwordPtr(rax, 4), ecx);
            mov(rdx, qwordPtr(rbp, 32));
            mov(bytePtr(rsi), al);
            mov(wordPtr(rdi, 16), dx);
        }
        return block.finalize();
    }();

    enum ubyte[] EXPECTED = [
        0x8b, 0x03,
        0x89, 0x48, 0x04,
        0x48, 0x8b, 0x55, 0x20,
        0x88, 0x06,
        0x66, 0x89, 0x57, 0x10
    ];

    static assert(encoded == EXPECTED);
}

unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            lock(add(dwordPtr(rax), ebx));
            xacquire_lock(sub(dwordPtr(rdi), esi));
            xrelease(mov(dwordPtr(rdx), ecx));
            stc();
            std();
            clc();
            wait();
            fwait();
            hlt();
            swapgs();
            monitor();
            lfence();
            sfence();
            pause();
            movsb();
            cmpsb();
            scasb();
            insb();
            outal(128);
            outal();
        }
        return block.finalize();
    }();

    enum ubyte[] EXPECTED = [
        0xf0, 0x01, 0x18,
        0xf2, 0xf0, 0x29, 0x37,
        0xf3, 0x89, 0x0a,
        0xf9,
        0xfd,
        0xf8,
        0x9b,
        0x9b,
        0xf4,
        0x0f, 0x01, 0xf8,
        0x0f, 0x01, 0xc8,
        0x0f, 0xae, 0xe8,
        0x0f, 0xae, 0xf8,
        0xf3, 0x90,
        0xa4,
        0xa6,
        0xae,
        0x6c,
        0xe6, 0x80,
        0xee
    ];

    static assert(encoded == EXPECTED);
}

unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            label("start");
            inc(eax);
            jne("forward");
            dec(eax);
            label("forward");
            loop("start");
            jmp("done");
            label("done");
            ret();
        }
        return block.finalize();
    }();

    enum ubyte[] EXPECTED = [
        0xff, 0xc0,
        0x75, 0x02,
        0xff, 0xc8,
        0xe2, 0xf8,
        0xeb, 0x00,
        0xc3
    ];

    static assert(encoded == EXPECTED);
}

unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            movdqa(xmm0, xmm1);
            movdqu(xmm2, xmmwordPtr(rax));
            pxor(xmm0, xmm1);
            pshufb(xmm0, xmm1);
            pshufd(xmm0, xmm1, 0);
            paddq(xmm0, xmm1);
            pblendw(xmm0, xmm1, 0);
            roundpd(xmm2, xmm3, 0);
            ptest(xmm0, xmm1);
            pcmpgtq(xmm0, xmm1);
        }
        return block.finalize();
    }();

    enum ubyte[] EXPECTED = [
        0x66, 0x0f, 0x6f, 0xc1,
        0xf3, 0x0f, 0x6f, 0x10,
        0x66, 0x0f, 0xef, 0xc1,
        0x66, 0x0f, 0x38, 0x00, 0xc1,
        0x66, 0x0f, 0x70, 0xc1, 0x00,
        0x66, 0x0f, 0xd4, 0xc1,
        0x66, 0x0f, 0x3a, 0x0e, 0xc1, 0x00,
        0x66, 0x0f, 0x3a, 0x09, 0xd3, 0x00,
        0x66, 0x0f, 0x38, 0x17, 0xc1,
        0x66, 0x0f, 0x38, 0x37, 0xc1
    ];

    static assert(encoded == EXPECTED);
}

unittest
{
    enum encoded = {
        Block!true block;
        with (block)
        {
            vpaddb(xmm0, xmm1, xmm2);
            vfmadd132pd(xmm3, xmm4, xmm5);
        }
        return block.finalize();
    }();

    enum ubyte[] EXPECTED = [
        0xc5, 0xf1, 0xfc, 0xc2,
        0xc4, 0xe2, 0xd9, 0x98, 0xdd
    ];

    static assert(encoded == EXPECTED);
}