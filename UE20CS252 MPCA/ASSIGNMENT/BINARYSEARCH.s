.data
A: .word 10, 20, 30, 40, 50, 60, 70, 80, 90, 100
B: .word 10
F: .asciz "found"
N: .asciz "Not found"
.text
  LDR r0, =A
  MOV r2, #0
  MOV r3, #9

  LDR r1, =B
  LDR r1, [r1]

loop:
  CMP r3, r2
  BMI notfound
  ADD r4, r3, r2
  MOV r4, r4, LSR #1
  MOV r4, r4, LSL #2
  LDR r5, [r4, r0]
  CMP r5, r1
  BEQ found
  BMI egtm
  MOV r3, r4, LSR #2
  B loop

egtm:
  MOV r2, r4, LSR #2
  ADD r2, r2, #1
  B loop

found:
  LDR r0, =F
  SWI 0x02
  SWI 0x011

notfound:
  LDR r0, =N
  SWI 0x02
  SWI 0x011

