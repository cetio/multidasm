# AMD64 (x86(_64))

```d
import multidasm.amd64;

Block!true block;  // true == 64-bit
with (block) {
    push(rcx);
    mov(eax, ecx);
    jl("done");
    add(eax, 1);
    label("done");
    pop(rcx);
    ret();
}
ubyte[] enc = block.finalize();
```

## Instructions

| Mnemonic | Supported | Flags |
|----------|-----------|-------|
| aaa | X | Base |
| aad | X | Base |
| aam | X | Base |
| aas | X | Base |
| adc | X | Base |
| adcx | X | ADX |
| add | X | Base |
| addpd | X | SSE2 |
| addps | X | SSE |
| addsd | X | SSE2 |
| addss | X | SSE |
| addsubpd | X | SSE3 |
| addsubps | X | SSE3 |
| adox | X | ADX |
| aesdec | X | AES |
| aesdec128kl | X | AES |
| aesdec256kl | X | AES |
| aesdeclast | X | AES |
| aesenc | X | AES |
| aesenc128kl | X | AES |
| aesenc256kl | X | AES |
| aesenclast | X | AES |
| aesimc | X | AES |
| aeskeygenassist | X | AES |
| and | X | Base |
| andn | X | BMI1 |
| andnpd | X | SSE2 |
| andnps | X | SSE |
| andpd |  | SSE2 |
| andps |  | SSE |
| arpl | X | Base |
| bextr |  | BMI1 |
| blendpd | X | SSE4.1 |
| blendps | X | SSE4.1 |
| blendvpd | X | SSE4.1 |
| blendvps | X | SSE4.1 |
| blsi |  | BMI1 |
| blsmsk |  | BMI1 |
| blsr |  | BMI1 |
| bndcl | X | MPX |
| bndcn | X | MPX |
| bndcu | X | MPX |
| bndldx | X | MPX |
| bndmk | X | MPX |
| bndmov | X | MPX |
| bndstx | X | MPX |
| bound | X | Base |
| bsf | X | Base |
| bsr | X | Base |
| bswap | X | Base |
| bt | X | Base |
| btc | X | Base |
| btr | X | Base |
| bts | X | Base |
| bzhi |  | BMI2 |
| call | X | Base |
| cbw | X | Base |
| cdq | X | Base |
| cdqe | X | Base |
| clac | X | SMAP |
| clc | X | Base |
| cld | X | Base |
| cldemote | X | CLDEMOTE |
| clflush | X | CLFL |
| clflushopt | X | CLFLUSHOPT |
| cli | X | Base |
| clrssbsy | X | CET |
| clts | X | Base |
| clui | X | UINTR |
| clwb | X | CLWB |
| cmc | X | Base |
| cmova | X | CMOV |
| cmovae | X | CMOV |
| cmovb | X | CMOV |
| cmovbe | X | CMOV |
| cmovc | X | CMOV |
| cmove | X | CMOV |
| cmovg | X | CMOV |
| cmovge | X | CMOV |
| cmovl | X | CMOV |
| cmovle | X | CMOV |
| cmovna | X | CMOV |
| cmovnae | X | CMOV |
| cmovnb | X | CMOV |
| cmovnbe | X | CMOV |
| cmovnc | X | CMOV |
| cmovne | X | CMOV |
| cmovng | X | CMOV |
| cmovnge | X | CMOV |
| cmovnl | X | CMOV |
| cmovnle | X | CMOV |
| cmovno | X | CMOV |
| cmovnp | X | CMOV |
| cmovns | X | CMOV |
| cmovnz | X | CMOV |
| cmovo | X | CMOV |
| cmovp | X | CMOV |
| cmovpe | X | CMOV |
| cmovpo | X | CMOV |
| cmovs | X | CMOV |
| cmovz | X | CMOV |
| cmp | X | Base |
| cmppd | X | SSE2 |
| cmpps | X | SSE |
| cmpsb | X | Base |
| cmpsd | X | Base |
| cmpsd | X | SSE2 |
| cmpsq | X | Base |
| cmpss |  | SSE |
| cmpsw | X | Base |
| cmpxchg | X | Base |
| cmpxchg16b | X | CX16 |
| cmpxchg8b | X | CX8 |
| comisd | X | SSE2 |
| comiss | X | SSE |
| cpuid | X | Base |
| cqo | X | Base |
| crc32 | X | SSE4.2 |
| cvtdq2pd |  | SSE2 |
| cvtdq2ps |  | SSE2 |
| cvtpd2dq |  | SSE2 |
| cvtpd2pi |  | SSE2 |
| cvtpd2ps |  | SSE2 |
| cvtpi2pd |  | SSE2 |
| cvtpi2ps |  | SSE |
| cvtps2dq |  | SSE2 |
| cvtps2pd |  | SSE2 |
| cvtps2pi |  | SSE |
| cvtsd2si |  | SSE2 |
| cvtsd2ss |  | SSE2 |
| cvtsi2sd |  | SSE2 |
| cvtsi2ss |  | SSE |
| cvtss2sd |  | SSE2 |
| cvtss2si |  | SSE |
| cvttpd2dq |  | SSE2 |
| cvttpd2pi |  | SSE2 |
| cvttps2dq |  | SSE2 |
| cvttps2pi |  | SSE |
| cvttsd2si |  | SSE2 |
| cvttss2si |  | SSE |
| cwd | X | Base |
| cwde | X | Base |
| daa | X | Base |
| das | X | Base |
| dec | X | Base |
| div | X | Base |
| divpd | X | SSE2 |
| divps | X | SSE |
| divsd |  | SSE2 |
| divss |  | SSE |
| dppd | X | SSE4.1 |
| dpps | X | SSE4.1 |
| emms |  | MMX |
| encls | X | SGX |
| enclu | X | SGX |
| enclv | X | SGX |
| endbr32 | X | CET |
| endbr64 | X | CET |
| enqcmd | X | ENQCMD |
| enter | X | Base |
| extractps | X | SSE4.1 |
| fabs | X | FPU |
| fadd | X | FPU |
| faddp | X | FPU |
| fbld | X | FPU |
| fbstp | X | FPU |
| fchs | X | FPU |
| fclex | X | FPU |
| fcmovb | X | FPU |
| fcmovbe | X | FPU |
| fcmove | X | FPU |
| fcmovnb | X | FPU |
| fcmovnbe | X | FPU |
| fcmovne | X | FPU |
| fcmovnu | X | FPU |
| fcmovu | X | FPU |
| fcom | X | FPU |
| fcomi | X | FPU |
| fcomip | X | FPU |
| fcomp | X | FPU |
| fcompp | X | FPU |
| fcos | X | FPU |
| fdecstp | X | FPU |
| fdiv | X | FPU |
| fdivp | X | FPU |
| fdivr | X | FPU |
| fdivrp | X | FPU |
| ffree | X | FPU |
| fiadd | X | FPU |
| ficom | X | FPU |
| ficomp | X | FPU |
| fidiv | X | FPU |
| fidivr | X | FPU |
| fild | X | FPU |
| fimul | X | FPU |
| fincstp | X | FPU |
| finit | X | FPU |
| fist | X | FPU |
| fistp | X | FPU |
| fisttp | X | FPU |
| fisttp | X | SSE3 |
| fisub | X | FPU |
| fisubr | X | FPU |
| fld | X | FPU |
| fld1 | X | FPU |
| fldcw | X | FPU |
| fldenv | X | FPU |
| fldl2e | X | FPU |
| fldl2t | X | FPU |
| fldlg2 | X | FPU |
| fldln2 | X | FPU |
| fldpi | X | FPU |
| fldz | X | FPU |
| fmul | X | FPU |
| fmulp | X | FPU |
| fnclex | X | FPU |
| fninit | X | FPU |
| fnop | X | FPU |
| fnsave | X | FPU |
| fnstcw | X | FPU |
| fnstenv | X | FPU |
| fnstsw | X | FPU |
| fpatan | X | FPU |
| fprem | X | FPU |
| fprem1 | X | FPU |
| fptan | X | FPU |
| frndint | X | FPU |
| frstor | X | FPU |
| fsave | X | FPU |
| fscale | X | FPU |
| fsin | X | FPU |
| fsincos | X | FPU |
| fsqrt | X | FPU |
| fst | X | FPU |
| fstcw | X | FPU |
| fstenv | X | FPU |
| fstp | X | FPU |
| fstsw | X | FPU |
| fsub | X | FPU |
| fsubp | X | FPU |
| fsubr | X | FPU |
| fsubrp | X | FPU |
| ftst | X | FPU |
| fucom | X | FPU |
| fucomi | X | FPU |
| fucomip | X | FPU |
| fucomp | X | FPU |
| fucompp | X | FPU |
| fwait | X | Base |
| fwait | X | FPU |
| fxam |  | FPU |
| fxch | X | FPU |
| fxrstor | X | FPU |
| fxsave | X | FPU |
| fxtract | X | FPU |
| fyl2x | X | FPU |
| fyl2xp1 | X | FPU |
| getsec | X | SMX |
| haddpd |  | SSE3 |
| haddps |  | SSE3 |
| hlt | X | Base |
| hreset | X | HRESET |
| hsubpd |  | SSE3 |
| hsubps |  | SSE3 |
| idiv |  | Base |
| imul | X | Base |
| in |  | Base |
| inal | X | Base |
| inc | X | Base |
| incsspd | X | CET |
| incsspq | X | CET |
| insb | X | Base |
| insd | X | Base |
| insertps | X | SSE4.1 |
| insw | X | Base |
| int |  | Base |
| int1 | X | Base |
| int3 | X | Base |
| into | X | Base |
| invd | X | Base |
| invept | X | VMX |
| invlpg | X | Base |
| invpcid | X | INVPCID |
| invvpid | X | VMX |
| iret | X | Base |
| iretd | X | Base |
| iretq | X | Base |
| ja | X | Base |
| jae | X | Base |
| jb | X | Base |
| jbe | X | Base |
| jc | X | Base |
| jcxz | X | Base |
| je | X | Base |
| jecxz | X | Base |
| jg | X | Base |
| jge | X | Base |
| jl | X | Base |
| jle | X | Base |
| jmp | X | Base |
| jna | X | Base |
| jnae | X | Base |
| jnb | X | Base |
| jnbe | X | Base |
| jnc | X | Base |
| jne | X | Base |
| jng | X | Base |
| jnge | X | Base |
| jnl | X | Base |
| jnle | X | Base |
| jno | X | Base |
| jnp | X | Base |
| jns | X | Base |
| jnz | X | Base |
| jo | X | Base |
| jp | X | Base |
| jpe | X | Base |
| jpo | X | Base |
| jrcxz | X | Base |
| js | X | Base |
| jz | X | Base |
| lahf | X | Base |
| lar | X | Base |
| lddqu |  | SSE3 |
| ldmxcsr |  | SSE |
| lds | X | Base |
| lea | X | Base |
| leave | X | Base |
| les | X | Base |
| lfence | X | SSE2 |
| lfs | X | Base |
| lgdt | X | Base |
| lgs | X | Base |
| lidt | X | Base |
| lldt | X | Base |
| lmsw | X | Base |
| lodsb | X | Base |
| lodsd | X | Base |
| lodsq | X | Base |
| lodsw | X | Base |
| loop | X | Base |
| loope | X | Base |
| loopne | X | Base |
| lsl | X | Base |
| lss | X | Base |
| ltr | X | Base |
| lzcnt | X | BMI1 |
| maxpd | X | SSE2 |
| maxps | X | SSE |
| maxsd |  | SSE2 |
| maxss |  | SSE |
| mfence | X | SSE2 |
| minpd | X | SSE2 |
| minps | X | SSE |
| minsd |  | SSE2 |
| minss |  | SSE |
| monitor | X | MON |
| mov | X | Base |
| movapd | X | SSE2 |
| movaps |  | SSE |
| movd | X | MMX |
| movd | X | SSE2 |
| movddup |  | SSE3 |
| movdq2q |  | SSE2 |
| movdqa | X | SSE2 |
| movdqu | X | SSE2 |
| movhlps |  | SSE |
| movhpd |  | SSE2 |
| movhps |  | SSE |
| movlhps |  | SSE |
| movlpd |  | SSE2 |
| movlps |  | SSE |
| movmskpd | X | SSE2 |
| movmskps | X | SSE |
| movntdq |  | SSE2 |
| movntdqa | X | SSE4.1 |
| movnti |  | SSE2 |
| movntpd |  | SSE2 |
| movq | X | MMX |
| movq | X | SSE2 |
| movq2dq |  | SSE2 |
| movsb | X | Base |
| movsd | X | Base |
| movsd | X | SSE2 |
| movshdup |  | SSE3 |
| movsldup |  | SSE3 |
| movsq | X | Base |
| movss |  | SSE |
| movsw | X | Base |
| movsx | X | Base |
| movsxd | X | Base |
| movupd | X | SSE2 |
| movups |  | SSE |
| movzx | X | Base |
| mpsadbw | X | SSE4.1 |
| mul | X | Base |
| mulpd | X | SSE2 |
| mulps | X | SSE |
| mulsd |  | SSE2 |
| mulss |  | SSE |
| mulx |  | BMI2 |
| mwait | X | MON |
| neg | X | Base |
| nop | X | Base |
| not | X | Base |
| or | X | Base |
| orpd | X | SSE2 |
| orps | X | SSE |
| out |  | Base |
| outal | X | Base |
| outsb | X | Base |
| outsd | X | Base |
| outsw | X | Base |
| pabsb | X | SSSE3 |
| pabsd | X | SSSE3 |
| pabsw | X | SSSE3 |
| packssdw | X | MMX |
| packssdw | X | SSE2 |
| packsswb | X | MMX |
| packsswb | X | SSE2 |
| packusdw | X | SSE4.1 |
| packuswb | X | MMX |
| packuswb | X | SSE2 |
| paddb | X | MMX |
| paddb | X | SSE2 |
| paddd | X | MMX |
| paddd | X | SSE2 |
| paddq | X | SSE2 |
| paddsb |  | MMX |
| paddsw |  | MMX |
| paddusb |  | MMX |
| paddusw |  | MMX |
| paddw | X | MMX |
| paddw | X | SSE2 |
| palignr | X | SSSE3 |
| pand | X | MMX |
| pand | X | SSE2 |
| pandn | X | MMX |
| pandn | X | SSE2 |
| pause | X | SSE2 |
| pavgb |  | SSE2 |
| pavgw |  | SSE2 |
| pblendvb | X | SSE4.1 |
| pblendw | X | SSE4.1 |
| pcmpeqb | X | MMX |
| pcmpeqb | X | SSE2 |
| pcmpeqd | X | MMX |
| pcmpeqd | X | SSE2 |
| pcmpeqq |  | SSE4.1 |
| pcmpeqw | X | MMX |
| pcmpeqw | X | SSE2 |
| pcmpestri | X | SSE4.2 |
| pcmpestrm | X | SSE4.2 |
| pcmpgtb | X | MMX |
| pcmpgtb | X | SSE2 |
| pcmpgtd | X | MMX |
| pcmpgtd | X | SSE2 |
| pcmpgtq | X | SSE4.2 |
| pcmpgtw | X | MMX |
| pcmpgtw | X | SSE2 |
| pcmpistri | X | SSE4.2 |
| pcmpistrm | X | SSE4.2 |
| pconfig | X | PCONFIG |
| pdep |  | BMI2 |
| pext |  | BMI2 |
| pextrb | X | SSE4.1 |
| pextrd | X | SSE4.1 |
| pextrq | X | SSE4.1 |
| pextrw | X | SSE2 |
| phaddd | X | SSSE3 |
| phaddsw |  | SSSE3 |
| phaddw | X | SSSE3 |
| phminposuw | X | SSE4.1 |
| phsubd | X | SSSE3 |
| phsubsw |  | SSSE3 |
| phsubw | X | SSSE3 |
| pinsrb | X | SSE4.1 |
| pinsrd | X | SSE4.1 |
| pinsrq | X | SSE4.1 |
| pinsrw | X | SSE2 |
| pmaddubsw | X | SSSE3 |
| pmaddwd |  | MMX |
| pmaddwd |  | SSE2 |
| pmaxsb | X | SSE4.1 |
| pmaxsd | X | SSE4.1 |
| pmaxsw |  | SSE2 |
| pmaxub |  | SSE2 |
| pmaxud | X | SSE4.1 |
| pmaxuw | X | SSE4.1 |
| pminsb | X | SSE4.1 |
| pminsd | X | SSE4.1 |
| pminsw |  | SSE2 |
| pminub |  | SSE2 |
| pminud | X | SSE4.1 |
| pminuw | X | SSE4.1 |
| pmovmskb | X | SSE2 |
| pmovsxbd | X | SSE4.1 |
| pmovsxbq | X | SSE4.1 |
| pmovsxbw | X | SSE4.1 |
| pmovsxdq | X | SSE4.1 |
| pmovsxwd | X | SSE4.1 |
| pmovsxwq | X | SSE4.1 |
| pmovzxbd | X | SSE4.1 |
| pmovzxbq | X | SSE4.1 |
| pmovzxbw | X | SSE4.1 |
| pmovzxdq | X | SSE4.1 |
| pmovzxwd | X | SSE4.1 |
| pmovzxwq | X | SSE4.1 |
| pmuldq | X | SSE4.1 |
| pmulhrsw | X | SSSE3 |
| pmulhuw | X | SSE2 |
| pmulhw | X | MMX |
| pmulhw | X | SSE2 |
| pmullw | X | MMX |
| pmullw | X | SSE2 |
| pmuludq | X | SSE2 |
| pop | X | Base |
| popa | X | Base |
| popad | X | Base |
| popcnt | X | POPCNT |
| popds | X | Base |
| popes | X | Base |
| popf | X | Base |
| popfd | X | Base |
| popfq | X | Base |
| popfs | X | Base |
| popgs | X | Base |
| popss | X | Base |
| por | X | MMX |
| por | X | SSE2 |
| psadbw |  | SSE2 |
| pshufb | X | SSSE3 |
| pshufd | X | SSE2 |
| pshufhw | X | SSE2 |
| pshuflw | X | SSE2 |
| psignb |  | SSSE3 |
| psignd |  | SSSE3 |
| psignw |  | SSSE3 |
| pslld |  | MMX |
| pslld |  | SSE2 |
| psllq |  | MMX |
| psllq |  | SSE2 |
| psllw |  | MMX |
| psllw |  | SSE2 |
| psrad |  | MMX |
| psrad |  | SSE2 |
| psraw |  | MMX |
| psraw |  | SSE2 |
| psrld |  | MMX |
| psrld |  | SSE2 |
| psrlq |  | MMX |
| psrlq |  | SSE2 |
| psrlw |  | MMX |
| psrlw |  | SSE2 |
| psubb | X | MMX |
| psubb | X | SSE2 |
| psubd | X | MMX |
| psubd | X | SSE2 |
| psubq | X | SSE2 |
| psubsb |  | MMX |
| psubsw |  | MMX |
| psubusb |  | MMX |
| psubusw |  | MMX |
| psubw | X | MMX |
| psubw | X | SSE2 |
| ptest | X | SSE4.1 |
| ptwrite | X | PT |
| punpckhbw |  | MMX |
| punpckhbw |  | SSE2 |
| punpckhdq |  | MMX |
| punpckhdq |  | SSE2 |
| punpckhqdq |  | SSE2 |
| punpckhwd |  | MMX |
| punpckhwd |  | SSE2 |
| punpcklbw |  | MMX |
| punpcklbw |  | SSE2 |
| punpckldq |  | MMX |
| punpckldq |  | SSE2 |
| punpcklqdq |  | SSE2 |
| punpcklwd |  | MMX |
| punpcklwd |  | SSE2 |
| push | X | Base |
| pusha | X | Base |
| pushad | X | Base |
| pushcs | X | Base |
| pushds | X | Base |
| pushes | X | Base |
| pushf | X | Base |
| pushfd | X | Base |
| pushfq | X | Base |
| pushfs | X | Base |
| pushgs | X | Base |
| pushss | X | Base |
| pxor | X | MMX |
| pxor | X | SSE2 |
| rcl | X | Base |
| rcpps |  | SSE |
| rcpss |  | SSE |
| rcr | X | Base |
| rdfsbase | X | FSGSBASE |
| rdgsbase | X | FSGSBASE |
| rdmsr | X | MSR |
| rdpid | X | RDPID |
| rdpkru | X | OSPKE |
| rdpmc | X | Base |
| rdrand | X | RDRAND |
| rdseed | X | RDSEED |
| rdsspd | X | CET |
| rdsspq | X | CET |
| rdtsc | X | TSC |
| rdtscp | X | TSC |
| ret | X | Base |
| retf | X | Base |
| rol | X | Base |
| ror | X | Base |
| rorx |  | BMI2 |
| roundpd | X | SSE4.1 |
| roundps | X | SSE4.1 |
| roundsd | X | SSE4.1 |
| roundss | X | SSE4.1 |
| rsqrtps |  | SSE |
| rsqrtss |  | SSE |
| rstorssp | X | CET |
| sahf | X | Base |
| sal | X | Base |
| sar | X | Base |
| sarx | X | BMI2 |
| saveprevssp | X | CET |
| sbb | X | Base |
| scasb | X | Base |
| scasd | X | Base |
| scasq | X | Base |
| scasw | X | Base |
| senduipi | X | UINTR |
| serialize | X | SERIALIZE |
| seta | X | Base |
| setae | X | Base |
| setb | X | Base |
| setbe | X | Base |
| setc | X | Base |
| sete | X | Base |
| setg | X | Base |
| setge | X | Base |
| setl | X | Base |
| setle | X | Base |
| setna | X | Base |
| setnae | X | Base |
| setnb | X | Base |
| setnbe | X | Base |
| setnc | X | Base |
| setne | X | Base |
| setng | X | Base |
| setnge | X | Base |
| setnl | X | Base |
| setnle | X | Base |
| setno | X | Base |
| setnp | X | Base |
| setns | X | Base |
| setnz | X | Base |
| seto | X | Base |
| setp | X | Base |
| setpe | X | Base |
| setpo | X | Base |
| sets | X | Base |
| setssbsy | X | CET |
| setz | X | Base |
| sfence | X | SSE2 |
| sgdt | X | Base |
| sha1msg1 | X | SHA |
| sha1msg2 | X | SHA |
| sha1nexte | X | SHA |
| sha1rnds4 | X | SHA |
| sha256msg1 | X | SHA |
| sha256rnds2 | X | SHA |
| shl | X | Base |
| shld |  | Base |
| shlx | X | BMI2 |
| shr | X | Base |
| shrd |  | Base |
| shrx | X | BMI2 |
| shufpd | X | SSE2 |
| shufps | X | SSE |
| sidt | X | Base |
| sldt | X | Base |
| smsw | X | Base |
| sqrtpd | X | SSE2 |
| sqrtps | X | SSE |
| sqrtsd |  | SSE2 |
| sqrtss |  | SSE |
| stac | X | SMAP |
| stc | X | Base |
| std | X | Base |
| sti | X | Base |
| stmxcsr |  | SSE |
| stosb | X | Base |
| stosd | X | Base |
| stosq | X | Base |
| stosw | X | Base |
| str | X | Base |
| stui | X | UINTR |
| sub | X | Base |
| subpd | X | SSE2 |
| subps | X | SSE |
| subsd |  | SSE2 |
| subss |  | SSE |
| swapgs | X | Base |
| syscall | X | SEP |
| sysenter | X | SEP |
| sysexit | X | SEP |
| sysret | X | SEP |
| test | X | Base |
| testui | X | UINTR |
| tpause | X | WAITPKG |
| tzcnt | X | BMI1 |
| ucomisd | X | SSE2 |
| ucomiss | X | SSE |
| ud0 | X | Base |
| ud1 | X | Base |
| ud2 | X | Base |
| uiret | X | UINTR |
| umonitor | X | WAITPKG |
| umwait | X | WAITPKG |
| unpckhpd |  | SSE2 |
| unpckhps |  | SSE |
| unpcklpd |  | SSE2 |
| unpcklps |  | SSE |
| vaddpd | X | AVX |
| vaddps | X | AVX |
| vaddsd | X | AVX |
| vaddss | X | AVX |
| vaddsubpd | X | AVX |
| vaddsubps | X | AVX |
| vaesdec | X | AES |
| vaesdeclast | X | AES |
| vaesenc | X | AES |
| vaesenclast | X | AES |
| vaesimc | X | AES |
| vaeskeygenassist | X | AES |
| vandnpd |  | AVX |
| vandnps |  | AVX |
| vandpd |  | AVX |
| vandps |  | AVX |
| vblendpd |  | AVX |
| vblendps |  | AVX |
| vblendvpd |  | AVX |
| vblendvps |  | AVX |
| vbroadcasti128 | X | AVX2 |
| vbroadcastsd |  | AVX2 |
| vbroadcastss |  | AVX2 |
| vcmppd |  | AVX |
| vcmpps |  | AVX |
| vcmpsd |  | AVX |
| vcmpss |  | AVX |
| vcomisd |  | AVX |
| vcomiss |  | AVX |
| vdivpd |  | AVX |
| vdivps |  | AVX |
| vdivsd |  | AVX |
| vdivss |  | AVX |
| verr | X | Base |
| verw | X | Base |
| vextracti128 |  | AVX2 |
| vfmadd132pd | X | FMA |
| vfmadd132ps | X | FMA |
| vfmadd132sd | X | FMA |
| vfmadd132ss | X | FMA |
| vfmadd213pd | X | FMA |
| vfmadd213ps | X | FMA |
| vfmadd213sd |  | FMA |
| vfmadd213ss |  | FMA |
| vfmadd231pd | X | FMA |
| vfmadd231ps | X | FMA |
| vfmadd231sd |  | FMA |
| vfmadd231ss |  | FMA |
| vinserti128 |  | AVX2 |
| vmcall | X | VMX |
| vmclear | X | VMX |
| vmfunc | X | VMX |
| vmlaunch | X | VMX |
| vmovd | X | AVX |
| vmovdqa |  | AVX |
| vmovdqu |  | AVX |
| vmovq | X | AVX |
| vmptrld | X | VMX |
| vmptrst | X | VMX |
| vmread | X | VMX |
| vmresume | X | VMX |
| vmulpd |  | AVX |
| vmulps |  | AVX |
| vmulsd |  | AVX |
| vmulss |  | AVX |
| vmwrite | X | VMX |
| vmxoff | X | VMX |
| vmxon | X | VMX |
| vpaddb | X | AVX2 |
| vpaddd | X | AVX2 |
| vpaddq | X | AVX2 |
| vpaddw | X | AVX2 |
| vpermpd | X | AVX2 |
| vpermq | X | AVX2 |
| vpmulld | X | AVX2 |
| vpsubb | X | AVX2 |
| vpsubd | X | AVX2 |
| vpsubq | X | AVX2 |
| vpsubw | X | AVX2 |
| vsubpd |  | AVX |
| vsubps |  | AVX |
| vsubsd |  | AVX |
| vsubss |  | AVX |
| vzeroall | X | AVX |
| vzeroupper | X | AVX |
| wait | X | Base |
| wbinvd | X | Base |
| wbnoinvd | X | Base |
| wrfsbase | X | FSGSBASE |
| wrgsbase | X | FSGSBASE |
| wrmsr | X | MSR |
| wrpkru | X | OSPKE |
| wrssd | X | CET |
| wrssq | X | CET |
| wrussd | X | CET |
| wrussq | X | CET |
| xabort | X | RTM |
| xadd | X | Base |
| xbegin | X | RTM |
| xchg | X | Base |
| xend | X | RTM |
| xgetbv | X | XSAVE |
| xlat | X | Base |
| xlatb | X | Base |
| xor | X | Base |
| xorpd | X | SSE2 |
| xorps | X | SSE |
| xresldtrk | X | TSXLDTRK |
| xrstor | X | XSAVE |
| xrstors | X | XSAVE |
| xsave | X | XSAVE |
| xsavec | X | XSAVE |
| xsaveopt | X | XSAVE |
| xsaves | X | XSAVE |
| xsetbv | X | XSAVE |
| xsusldtrk | X | TSXLDTRK |
| xtest | X | RTM |
