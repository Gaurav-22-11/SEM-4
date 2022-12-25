;program to display  0 to F and f to 0 on the 8 segment display

.text
	begin: mov r0,#0
	mov r2,#0
	again: swi 0x202 ; check whether black button pressed or not
	cmp r0,#1; right button-upcounter
	beq loop1
	cmp r0,#2; left button- downcounter
	beq loop2
	b again
loop1:  
	mov r5,#16
	ldr r1,=zero
back1: 
	ldrb r0,[r1]
	swi 0x200 ;set 8 segment display to light up
	bl delay
	add r1,r1,#1
	sub r5,r5,#1
	cmp r5,#0
	bne back1
	b again
loop2:
	mov r5,#16
	ldr r1,=F
back2: 
	ldrb r0, [r1]
	swi 0x200 ;set 8 set 8 segment display to light up
	bl delay
	add r1,r1,#1
	sub r5,r5,#1
	cmp r5,#0
	bne back2
	b again
delay: 
	mov r4, #64000
loop3: 
	sub r4,r4,#1
	cmp r4, #0
	bge loop3
	mov pc, lr
.data
zero: .byte 0b11101101
one: .byte 0b01100000
two: .byte 0b01101110
three: .byte 0b11111010
four: .byte 0b00110011
five: .byte 0b10101011
six: .byte 0b10101111
seven: .byte 0b01110000
eight: .byte 0b11101111
nine: .byte 0b11100011
A: .byte 0b11100111
B: .byte 0b00101111
C: .byte 0b10001101
D: .byte 0b01101110
E: .byte 0b10001111
F: .byte 0b10000111