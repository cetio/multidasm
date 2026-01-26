// MIPS32 branches: beq, bne, blez, bgtz, bltz, bgez. Record branch, emit placeholder; finalize() patches.

    @("jump")
    auto beq(GPR rs, GPR rt, string name) { branches ~= tuple(cast(size_t)buffer.length, name, "beq", rs.index, rt.index); return emit(0); }
    @("jump")
    auto bne(GPR rs, GPR rt, string name) { branches ~= tuple(cast(size_t)buffer.length, name, "bne", rs.index, rt.index); return emit(0); }
    @("jump")
    auto blez(GPR rs, string name) { branches ~= tuple(cast(size_t)buffer.length, name, "blez", rs.index, cast(ubyte)0); return emit(0); }
    @("jump")
    auto bgtz(GPR rs, string name) { branches ~= tuple(cast(size_t)buffer.length, name, "bgtz", rs.index, cast(ubyte)0); return emit(0); }
    @("jump")
    auto bltz(GPR rs, string name) { branches ~= tuple(cast(size_t)buffer.length, name, "bltz", rs.index, cast(ubyte).bltz); return emit(0); }
    @("jump")
    auto bgez(GPR rs, string name) { branches ~= tuple(cast(size_t)buffer.length, name, "bgez", rs.index, cast(ubyte).bgez); return emit(0); }
