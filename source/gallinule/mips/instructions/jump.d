// MIPS32 jumps: j, jal (string label). Record and emit placeholder; finalize() patches.

    @("jump")
    auto j(string name) { branches ~= tuple(cast(size_t)buffer.length, name, "j", cast(ubyte)0, cast(ubyte)0); return emit(0); }
    @("jump")
    auto jal(string name) { branches ~= tuple(cast(size_t)buffer.length, name, "jal", cast(ubyte)0, cast(ubyte)0); return emit(0); }
