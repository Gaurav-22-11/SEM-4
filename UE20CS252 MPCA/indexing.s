/*PREINDEXING WITHOUT WRITEBACK 
.DATA
 A:.WORD 10,20,30,40,50
.TEXT
LDR R1,=A
LDR R2,[R1,#4]
*/
/*PREINDEXING WITH WRITEBACK
.DATA
 A:.WORD 10,20,30,40,50
.TEXT
LDR R1,=A
LDR R2,[R1,#4]!
*/
/*POSTINDEXING
.DATA
 A:.WORD 10,20,30,40,50
.TEXT
LDR R1,=A
LDR R2,[R1],#4*/
/*WAP TO FIND SUM OF N NUMBERS AND STORE THE VALUES TO A MEMORY LOCATION USING 
PREINDEX WITHOUT WRITEBACK
PREINDEX WITH WRITEBACK
POSTINDEX*/
/*.DATA
A:.WORD 10,20,30,40,50
SUM:.WORD 0
.TEXT
LDR R1,=A
LDR R2,=SUM
;MOV R4,#0
LDR R4,[R1]
MOV R5,#1
LOOP:
LDR R3,[R1,#4]
ADD R4,R4,R3
ADD R1,R1,#4
ADD R5,R5,#1
CMP R5,#5
BNE LOOP
STR R4,[R2]
*/
/*A:.WORD 10,20,30,40,50
SUM:.WORD 0
.TEXT
LDR R1,=A
LDR R2,=SUM
;MOV R4,#0
LDR R4,[R1]
MOV R5,#1
LOOP:
LDR R3,[R1,#4]!
ADD R4,R4,R3
/*ADD R1,R1,#4*/
ADD R5,R5,#1
CMP R5,#5
BNE LOOP
STR R4,[R2]
.END*/
A:.WORD 10,20,30,40,50
SUM:.WORD 0
.TEXT
LDR R1,=A
LDR R2,=SUM
MOV R4,#0
MOV R5,#1
LOOP:
LDR R3,[R1],#4
ADD R4,R4,R3
ADD R1,R1,#4
ADD R5,R5,#1
CMP R5,#6
BNE LOOP
STR R4,[R2]
.END