/*MOV R0,#0
LOOP:
	ADD R0,R0,#1
	CMP R0,#10
	BNE LOOP
*/
/*.DATA
A:.WORD 10
B:.WORD 0
.TEXT
LDR R1,=A
LDR R2,[R1]
LDR R3,=B
STR R2,[R3]
.END
*/
.DATA
A:.WORD 10,20,30,40,50
B:.WORD 0
.TEXT
LDR R0,=A
LDR R1,[R0,#8]
LDR R2,=B
STR R1,[R2]
.END