.extern _ZN5Riscv17handleExcAndEcallEv
.extern _ZN5Riscv20handleInterruptTimerEv
.extern _ZN5Riscv23handleInterruptHardwareEv

.align 4
.global _ZN5Riscv9jumpTableEv
#.type _ZN5Riscv9jumpTableEv, @function
_ZN5Riscv9jumpTableEv:

j _ZN5Riscv17handleExcAndEcallEv
j _ZN5Riscv20handleInterruptTimerEv
NOP #addi x0, x0, 0 ili add x0, x0, x0
NOP
NOP
NOP
NOP
NOP
NOP
j _ZN5Riscv23handleInterruptHardwareEv
