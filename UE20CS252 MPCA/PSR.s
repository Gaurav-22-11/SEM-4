.TEXT
	MOVS R1,#-10
	MRS R0,CPSR
	AND R0,R0,#0000
	MSR CPSR,R0
.END