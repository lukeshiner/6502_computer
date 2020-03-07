PORTB = $6000
PORTA = $6001
DDRB = $6002
DDRA = $6003

E = %10000000
RW = %01000000
RS = %00100000

	.org $8000
reset:
	ldx #$ff
	tsx
	
	lda #%11111111 ; Set all pins on port B to output
	sta DDRB

	lda #%11100000 ; Set top three pins on port A to output
	sta DDRA
	
	lda #%00111000 ; Set 8-bit mode; 2-line display; 5x8 font
	jsr lcd_instruction
	lda #%00001110 ; Display on; cursor on; blink off
	jsr lcd_instruction
	lda #%00000110 ; Increment and shift cursor, do not scroll display
	jsr lcd_instruction
	lda #%00000001 ; Clear display
	jsr lcd_instruction

	ldx 0
	jmp memdump
	brk

memdump:
	lda $3000,x
	tay
	clc
	and #$f0
	ror
	ror
	ror
	ror
	jsr nibblehex
	jsr print_char
	tya
	and #$0f
	jsr nibblehex
	jsr print_char
	inx
	lda #$30
	jsr delay
	lda #%00000001 ; Clear display
	jsr lcd_instruction
	inx
	jmp memdump

nibblehex:
	adc #$30
	clc
	cmp #$3a
	bcc nohex
	adc #$6
	nohex:
	rts
	
delay:
	sbc #$1
	bpl delay
	rts


lcd_instruction:
	sta PORTB
	lda #0         ; Clear RS/RW/E bits
	sta PORTA
	lda #E         ; Set enable bit
	sta PORTA
	lda #0         ; Clear RS/RW/E bits
	sta PORTA
	rts

print_char:
	sta PORTB
	lda #RS        ; Set RS; Clear RW/E bits
	sta PORTA
	lda #(RS | E)  ; Set E bit to send instruction
	sta PORTA
	lda #RS        ; Clear RS/RW/E bits
	sta PORTA
	rts

	.org $fffc
	.word reset
	.word $0000