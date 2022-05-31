.global systemCall
.type systemCall, @function
systemCall:
        mv a4, a3
        mv a3, a2
        mv a2, a1
        mv a1, a0
        mv a0, a5 # kod sistemskog poziva
        ecall

        ret