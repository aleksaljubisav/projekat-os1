.global _ZN5Riscv13pushRegistersEv  #da bi neko od spolja mogao da koristi pushRegisters
.type _ZN5Riscv13pushRegistersEv, @function #nije neophodno
_ZN5Riscv13pushRegistersEv:
        addi sp, sp, -256 #add immediate
        #asemblerska direktiva koja vrsi ponavljanje
        .irp index, 3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
        sd x\index, \index * 8(sp)

        #drugi nacin bi bio (sd - store data): sd x3, 3*8(sp)...
        .endr #end repeat
        ret

.global _ZN5Riscv12popRegistersEv
.type _ZN5Riscv12popRegistersEv, @function
_ZN5Riscv12popRegistersEv:
    .irp index, 3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp) #load data
    .endr
    addi sp, sp, 256
    ret
