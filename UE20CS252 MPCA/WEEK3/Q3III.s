.DATA
        A:.WORD 10,20,30,40
        SUM:.WORD 0
.TEXT
        MOV R2,#0
        LDR R1,=A
        LDR R3,=SUM
        MOV R6,#0
        ADD R1,R1,#4
LOOP:   
        LDR R4,[R1],#8
        ADD R2,R2,R4
        ADD R6,R6,#1
        CMP R6,#2
        BNE LOOP
STR R2,[R3]
.END