.DATA
	A:.WORD 100,200,300,400,500,600,700,800,900,1000,10,20,30,40,50,60,70,80,90,1,2,3,4
	B:.WORD 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.TEXT
	LDR R0,=A
	LDR R1,=B
	MOV R3,#3
L1:
	LDMIA R0!,{R1-R8}
	STMIA R9!,{R1-R8}
	SUB R3,R3,#1
	CMP R3,#0
	BNE L1
	SWI 0X11
