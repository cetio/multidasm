// MIPS32 load/store: lb, lbu, lh, lhu, lw, sb, sh, sw.

    @("rt", "base", "offset")
    auto lb(GPR rt, GPR base, short offset) => emit(itype(.lb, base.index, rt.index, offset));
    @("rt", "mem")
    auto lb(GPR rt, Mem m) => emit(itype(.lb, m.base.index, rt.index, m.offset));

    @("rt", "base", "offset")
    auto lbu(GPR rt, GPR base, short offset) => emit(itype(.lbu, base.index, rt.index, offset));
    @("rt", "mem")
    auto lbu(GPR rt, Mem m) => emit(itype(.lbu, m.base.index, rt.index, m.offset));

    @("rt", "base", "offset")
    auto lh(GPR rt, GPR base, short offset) => emit(itype(.lh, base.index, rt.index, offset));
    @("rt", "mem")
    auto lh(GPR rt, Mem m) => emit(itype(.lh, m.base.index, rt.index, m.offset));

    @("rt", "base", "offset")
    auto lhu(GPR rt, GPR base, short offset) => emit(itype(.lhu, base.index, rt.index, offset));
    @("rt", "mem")
    auto lhu(GPR rt, Mem m) => emit(itype(.lhu, m.base.index, rt.index, m.offset));

    @("rt", "base", "offset")
    auto lw(GPR rt, GPR base, short offset) => emit(itype(.lw, base.index, rt.index, offset));
    @("rt", "mem")
    auto lw(GPR rt, Mem m) => emit(itype(.lw, m.base.index, rt.index, m.offset));

    @("rt", "base", "offset")
    auto sb(GPR rt, GPR base, short offset) => emit(itype(.sb, base.index, rt.index, offset));
    @("rt", "mem")
    auto sb(GPR rt, Mem m) => emit(itype(.sb, m.base.index, rt.index, m.offset));

    @("rt", "base", "offset")
    auto sh(GPR rt, GPR base, short offset) => emit(itype(.sh, base.index, rt.index, offset));
    @("rt", "mem")
    auto sh(GPR rt, Mem m) => emit(itype(.sh, m.base.index, rt.index, m.offset));

    @("rt", "base", "offset")
    auto sw(GPR rt, GPR base, short offset) => emit(itype(.sw, base.index, rt.index, offset));
    @("rt", "mem")
    auto sw(GPR rt, Mem m) => emit(itype(.sw, m.base.index, rt.index, m.offset));
