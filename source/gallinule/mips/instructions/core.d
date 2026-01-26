// MIPS32 integer ALU, shifts, mult/div, jr/jalr, syscall, break.

    @("rd", "rs", "rt")
    auto add(GPR rd, GPR rs, GPR rt) => emit(rtype(.special, rs.index, rt.index, rd.index, 0, .add));
    @("rd", "rs", "rt")
    auto addu(GPR rd, GPR rs, GPR rt) => emit(rtype(.special, rs.index, rt.index, rd.index, 0, .addu));
    @("rd", "rs", "rt")
    auto sub(GPR rd, GPR rs, GPR rt) => emit(rtype(.special, rs.index, rt.index, rd.index, 0, .sub));
    @("rd", "rs", "rt")
    auto subu(GPR rd, GPR rs, GPR rt) => emit(rtype(.special, rs.index, rt.index, rd.index, 0, .subu));
    @("rd", "rs", "rt")
    auto and_(GPR rd, GPR rs, GPR rt) => emit(rtype(.special, rs.index, rt.index, rd.index, 0, .and));
    @("rd", "rs", "rt")
    auto or_(GPR rd, GPR rs, GPR rt) => emit(rtype(.special, rs.index, rt.index, rd.index, 0, .or));
    @("rd", "rs", "rt")
    auto xor_(GPR rd, GPR rs, GPR rt) => emit(rtype(.special, rs.index, rt.index, rd.index, 0, .xor));
    @("rd", "rs", "rt")
    auto nor(GPR rd, GPR rs, GPR rt) => emit(rtype(.special, rs.index, rt.index, rd.index, 0, .nor));
    @("rd", "rs", "rt")
    auto slt(GPR rd, GPR rs, GPR rt) => emit(rtype(.special, rs.index, rt.index, rd.index, 0, .slt));
    @("rd", "rs", "rt")
    auto sltu(GPR rd, GPR rs, GPR rt) => emit(rtype(.special, rs.index, rt.index, rd.index, 0, .sltu));

    @("rt", "rs", "imm")
    auto addi(GPR rt, GPR rs, short imm16) => emit(itype(.addi, rs.index, rt.index, imm16));
    @("rt", "rs", "imm")
    auto addiu(GPR rt, GPR rs, short imm16) => emit(itype(.addiu, rs.index, rt.index, imm16));
    @("rt", "rs", "imm")
    auto andi(GPR rt, GPR rs, ushort imm16) => emit(itypeU(.andi, rs.index, rt.index, imm16));
    @("rt", "rs", "imm")
    auto ori(GPR rt, GPR rs, ushort imm16) => emit(itypeU(.ori, rs.index, rt.index, imm16));
    @("rt", "rs", "imm")
    auto xori(GPR rt, GPR rs, ushort imm16) => emit(itypeU(.xori, rs.index, rt.index, imm16));
    @("rt", "rs", "imm")
    auto slti(GPR rt, GPR rs, short imm16) => emit(itype(.slti, rs.index, rt.index, imm16));
    @("rt", "rs", "imm")
    auto sltiu(GPR rt, GPR rs, short imm16) => emit(itype(.sltiu, rs.index, rt.index, imm16));
    @("rt", "imm")
    auto lui(GPR rt, ushort imm16) => emit(itypeU(.lui, 0, rt.index, imm16));

    @("rd", "rt", "shamt")
    auto sll(GPR rd, GPR rt, ubyte shamt) => emit(rtype(.special, 0, rt.index, rd.index, shamt, 0));  // SLL funct 0
    @("rd", "rt", "shamt")
    auto srl(GPR rd, GPR rt, ubyte shamt) => emit(rtype(.special, 0, rt.index, rd.index, shamt, .srl));
    @("rd", "rt", "shamt")
    auto sra(GPR rd, GPR rt, ubyte shamt) => emit(rtype(.special, 0, rt.index, rd.index, shamt, .sra));
    @("rd", "rt", "rs")
    auto sllv(GPR rd, GPR rt, GPR rs) => emit(rtype(.special, rs.index, rt.index, rd.index, 0, .sllv));
    @("rd", "rt", "rs")
    auto srlv(GPR rd, GPR rt, GPR rs) => emit(rtype(.special, rs.index, rt.index, rd.index, 0, .srlv));
    @("rd", "rt", "rs")
    auto srav(GPR rd, GPR rt, GPR rs) => emit(rtype(.special, rs.index, rt.index, rd.index, 0, .srav));

    @("rs", "rt")
    auto mult(GPR rs, GPR rt) => emit(rtype(.special, rs.index, rt.index, 0, 0, .mult));
    @("rs", "rt")
    auto multu(GPR rs, GPR rt) => emit(rtype(.special, rs.index, rt.index, 0, 0, .multu));
    @("rs", "rt")
    auto div(GPR rs, GPR rt) => emit(rtype(.special, rs.index, rt.index, 0, 0, .div));
    @("rs", "rt")
    auto divu(GPR rs, GPR rt) => emit(rtype(.special, rs.index, rt.index, 0, 0, .divu));
    @("rd")
    auto mfhi(GPR rd) => emit(rtype(.special, 0, 0, rd.index, 0, .mfhi));
    @("rd")
    auto mflo(GPR rd) => emit(rtype(.special, 0, 0, rd.index, 0, .mflo));
    @("rs")
    auto mthi(GPR rs) => emit(rtype(.special, rs.index, 0, 0, 0, .mthi));
    @("rs")
    auto mtlo(GPR rs) => emit(rtype(.special, rs.index, 0, 0, 0, .mtlo));

    @("rd", "rs", "rt")
    auto movz(GPR rd, GPR rs, GPR rt) => emit(rtype(.special, rs.index, rt.index, rd.index, 0, .movz));
    @("rd", "rs", "rt")
    auto movn(GPR rd, GPR rs, GPR rt) => emit(rtype(.special, rs.index, rt.index, rd.index, 0, .movn));

    @("rs")
    auto jr(GPR rs) => emit(rtype(.special, rs.index, 0, 0, 0, .jr));
    @("rd", "rs")
    auto jalr(GPR rd, GPR rs) => emit(rtype(.special, rs.index, 0, rd.index, 0, .jalr));

    auto syscall() => emit(rtype(.special, 0, 0, 0, 0, .syscall));
    @("code")
    auto break_(uint code) => emit((cast(uint).special << 26) | ((code & 0xFFFFFu) << 6) | (cast(uint).brk & 63));
