
CON: lw a0 <spec mem add>

RELPRIME: addi sp, sp, -12
sw ra, sp, 0
sw a0, sp, 4
addi a1, x0, 2
sw a1, sp, 8
LOOP: addi a1, a1 1
sw a1, sp, 8
jal ra, GCD
lw a1, sp, 8
bne a0, 1, LOOP
lw a0, sp, 8
lw ra, sp, 0
addi sp, sp, 12
jalr a0, ra, ra #2 ras since one will be discarded anyways (rtype instr.
GCD: bne a0, x0, ENDIF1
jalr a1, ra, ra
ENDIF1: addi t0, x0, 1
LOOP2: grt t1, a0, a1
bne a0, x0, ENDIF2
sub a0, a0, a1
bne x0, t0, ENDELSE
ENDIF2: sub a1, a1, a0
ENDELSE: bne t0, x0, LOOP2
jalr a0, ra, ra
beq x0, x0, CON # continue relprime loop code
