
.data
    A: .asciz "Hello world"
    B: .asciz "g"
    C: .asciz "found"
    D: .asciz "not found"
.text
    LDR r0, =A
    LDR r1, =B
    LDRb r1, [r1]

loop:
    LDRb r2, [r0], #1
    CMP r2, #0
    BEQ end

    CMP r2, r1
    BEQ found
    B loop
    SWI 0x011

found:
    LDR r0, =C
    SWI 0x02
    SWI 0x011

end:
    LDR r0, =D
    SWI 0x02
    SWI 0x011

