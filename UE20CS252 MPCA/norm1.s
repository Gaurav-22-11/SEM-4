.DATA
	A: .WORD 1,3,5,7,4,2,8,1,0
	SUM: .WORD 

.TEXT

	LDR R0,=A
	LDR R9,=SUM
	MOV R1,#0 
	MOV R2,#0 
	MOV R3,#3 
	MOV R4,#0 
	MOV R8,#0 

LOOP:	
	MLA R5,R3,R1,R2
	MOV R5,R5,LSL #2
	LDR R6,[R0,R5]
	ADD R4,R4,R6
	ADD R2,R2,#1
	CMP R2,#3
	BNE LOOP
	CMP R4,R8
	MOVGT R8,R4
	ADD R1,R1,#1
	MOV R2,#0
	MOV R4,#0
	CMP R1,#3
	BNE LOOP
	STR R8,[R9]

