	.org $8000
	lda #$ff
	sta $6002

reset:
	lda #$ff
	sta $6002

loop:
	lda #$aa
	sta $6000

	jmp loop

	.org $fffc
	.word reset
	.word $0000