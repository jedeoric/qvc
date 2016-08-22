*=$a800

/* Disassembled QVC text editor for Oric */


#define QVC_BUFFER_TEXT $4000
#define PTR1_QVC $f7 ; contains buffer text of qvc 2 bytes
#define PTR2_QVC $f5 ;contains address of the current video address bytes
#define PTR3_QVC $f3 ; 2 bytes

#define QVC_LENGTH_COLUMNS 80

// Salut

#define RES $00 ; 2 bytes
#define RESB $02 ; 4 bytes

#define RES2 $c1 ; One byte
#define RES3 $f9 ; One byte

#define BASICFLG $026a

/*
30 PAPER0:INK7:POKE618,#23
60 CLS
*/
lda #$23
sta $268
jsr $ccce
start
.(
	lda #$02
	sta $026a ;FIXME
	jmp start_qvc
.)
_a808
.(
	LDA #$B0
	LDY #$8F
	STA RESB+2
	STY RESB+3
	LDA #$FF
	STA RESB+1
_a814
	LDY #$4F
_a816
	LDA (RESB+2),Y
	CMP #$20
	BNE _a82e
	DEY
	BPL _a816
	LDA RESB+2
	SEC
	SBC #$50
	STA RESB+2
	BCS _a82a
	DEC RESB+3
_a82a
	DEC RESB+1
	BNE _a814
_a82e
	RTS



.)
_a830
set_via_qvc
.(
	php
	sei
	sta $301 ; FIXME
	lda $300
	and #$ef
	sta $300
	lda $300
	ora #$10
	sta $300
	plp
loop7
	lda $030d
	and #$02
	beq loop7
	lda $030D
	rts
/**/

.)

_a860
.(
	lda PTR3_QVC
	beq end
	ldx #$11
	jsr _a9c0 
	dec PTR3_QVC
	lda RES3
	beq end
	dec RES3
end	
	rts

.)

_a880
.(
	lda PTR3_QVC+1
	beq end
	dec PTR3_QVC+1
	lda PTR1_QVC
	sec
	sbc #$50
	sta PTR1_QVC
	
	bcs next16
	dec PTR1_QVC+1
next16
	lda RES2
	beq next15
	dec RES2
	lda PTR2_QVC
	sec
	sbc #$28
	sta PTR2_QVC
	bcs next15
	dec PTR2_QVC+1
next15
	ldx #$19
	jsr _a9c0
end
	rts

.)	
_a8b0
.(
	lda #$00
	sta RES3
	lda #$00
	sta PTR3_QVC
	lda #$30
	sta $bb91
	sta $bb90
	rts

.)

_a8d0
.(
	CMP #$18
	BNE _a8df
	LDA $026A
	EOR #$08
	STA $026A
	JMP _abf5
_a8df
	JMP _aac0 ; 


.)
_a8f0


ROUTINE2_QVC
.(
	lda PTR1_QVC
	ldy PTR1_QVC+1
	sta RES
	sty RES+1
	
	ldx RES2 
	beq next2
loop3	
	lda RES
	sec
	sbc #$50
	sta $00
	bcs next
	dec RES+1
next
	dex
	bne loop3

next2
	lda PTR3_QVC
	sec
	sbc RES3 
	clc
	adc RES
	sta RES
	bcc next3

	inc RES+1
next3
	nop
	lda #$a8
	ldy #$bb
	sta RESB
	sty RESB+1

	ldx #$1c
loop20
	ldy #$00
loop2
	lda (RES),y
	sta (RESB),y
	iny
	cpy #$28
	bne loop2
	lda RESB
	clc
	adc #$28
	sta RESB
	bcc next4
	inc RESB+1
next4
	lda RES
	clc
	adc #$50
	sta RES
	bcc next5
	inc RES+1
next5
	dex
	bne loop20
	rts



.)

_a960
status_line_buffer_qvc
.(
.byt "*",$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,"X:000",$20,$20,$20,"Y:000",$20,$20,$20,$20,$20,$20
.byt $20,$20,$20,$20,$20,$20,$20,$20

.)


_a990
display_status_line_qvc
.(
	ldx #$27
loop
	lda status_line_buffer_qvc,x
	sta $bb80,x
	dex 
	bpl loop
	rts

.)

_a9a0
.(
	lda $bb80,x
	cmp #$39
	beq next15
	clc
	adc #$01
	sta $bb80,x
	rts
next15
	lda #$30
	sta $bb80,x
	dex
	bne _a9a0
	rts
.)

_a9c0
.(
	lda $bb80,x
	cmp #$30
	beq next15
	sec
	sbc #$01
	sta $bb80,x
	rts
next15
	lda #$39
	sta $bb80,x
	dex
	bne _a9c0
	rts

.)

_a9e0
.(
	lda PTR3_QVC
	cmp #$4f
	beq next16
	inc PTR3_QVC
	lda RES3
	cmp #$27
	beq next15
	inc RES3
next15
	ldx #$11
	jmp _a9a0  
next16
	lda $bb80
	bpl _aa00
	rts


+_aa00
	jsr _a8b0 
	jmp _aa10 


+_aa10
	lda PTR3_QVC+1 ; 
	cmp #$ff
	beq end

	lda PTR1_QVC 
	clc
	adc #$50
	sta PTR1_QVC
	lda PTR1_QVC+1 
	adc #$00
	sta PTR1_QVC+1
	lda RES2 
	cmp #$1a
	beq next23

	lda PTR2_QVC 
	clc
	adc #$28
	sta PTR2_QVC
	bcc next22

	inc PTR2_QVC+1 
next22
	inc RES2
next23
	inc PTR3_QVC+1
	ldx #$19
	jsr _a9a0
end
	rts

.)

_aa40
.(
	ldy PTR3_QVC
	sta ($f7),y ;FIXME
	jmp _a9e0

.)

_aa60
.(
	ldy RES3 
	lda (PTR2_QVC),y
	eor #$80
	sta (PTR2_QVC),y 
	rts
.)

_aa70
start_qvc
.(
	jsr init_buffer_text_qvc
	lda #<QVC_BUFFER_TEXT
	ldy #>QVC_BUFFER_TEXT
	sta PTR1_QVC
	sty PTR1_QVC+1
	lda #$A8
	ldy #$bb
	sta PTR2_QVC
	sty PTR2_QVC+1
	lda #$00
	sta PTR3_QVC
	sta PTR3_QVC+1
	jsr display_status_line_qvc

#ifdef CPU_65C02
	stz RES3
	stz RES2
#else
	lda #$00 
	sta RES3 ; dunno yet FIXME
	sta RES2 ; DUNNO yet FIXME
#endif

	nop
	nop
	nop
_aa95
	jsr ROUTINE2_QVC
	nop
	nop
	nop
	
#ifdef CPU_65C02
	stz $02df
#else
	lda #$00
	sta $02df
#endif
	jsr _aac0 
	cmp #$1b
	bne next15

	nop
	nop
	rts
next15
	jsr _aa40 
	jmp _aa95 


.)

_aac0
#ifdef CPU_65C02
	stz $02df  ; FIXME
#else
	lda #$00
	sta $02df  ; FIXME RESET KEY PRESSED
#endif
	jsr _ada0 
	cmp #$09
	bne compare_next
	jsr _a9e0 
	jmp _abf5 
compare_next
	cmp #$0A
	bne compare_next2
	jsr _aa10 
	jmp _abf5 
compare_next2
	cmp #$0b
	bne compare_next3
	jsr _a880  
	jmp _abf5  
compare_next3
	cmp #$08
	bne compare_next4
	jsr _a860  
	jmp _abf5 
compare_next4
_aaf0
	cmp #$0d
	bne compare_next5
	jsr _aa00 
	jmp _abf5 
compare_next5
	cmp #$04
	bne compare_next6
	jsr _ac00 
	jmp _abf5 
compare_next6
	cmp #$7f
	bne compare_next7
	jsr _ac70 
	jmp _abf5 
compare_next7
	cmp #$13
	bne compare_next8
	jsr _ac80 
	jmp _abf5 
compare_next8
	cmp #$1a
	bne compare_next9
	jsr _ac90 
	jmp _abf5 
compare_next9
	cmp #$01
	bne compare_next10
	jsr _ace0 
	jmp _abf5 
compare_next10
	cmp #$17
	bne compare_next11
	jsr _ad30 
	jmp _abf5 
compare_next11
	cmp #$11
	bne compare_next12
	jsr _ad50 
	jmp _abf5 
compare_next12
	cmp #$05
	bne compare_next13
	jsr _ad70 
	jmp _abf5 
compare_next13
	cmp #$10
	bne compare_next14

	pla
	pla 
	jmp _aa70 
compare_next14
	cmp #$41
	bmi next8
	cmp #$5b
	bpl next8
	ldy $0209 ; FIXME test matrix keyboard
	cpy #$a7
	beq next8
	cpy #$a4
	beq next8
	ORA #$20
	nop
next8
	cmp #$1b
	bne next7
	rts
next7
	cmp #$0f
	bne compare_next15
	jsr _ab80 
	jmp _abf5 
compare_next15
	cmp #$20

	bmi next9
	rts
next9
	jmp _a8d0 
_ab80

	jsr _a808
#ifdef CPU_65C02
	stz RESB
	stz $02df ; FIXME
	stz RESB+2 ; FIXME
#else	
	lda #$00
	sta RESB
	sta $02df ; FIXME
	sta RESB+2
#endif
	ldy #$40 ; BUFFER FIXME ?
	sta RES
	sty RES+1
new
	ldy #0
loop21
	lda (RES),y
	jsr set_via_qvc 
	iny
	lda $02df
	beq next10
	sta RESB
	nop
next10
	cpy #$50
	bne loop21

	lda RESB
	bne next12
	lda RES
	clc
	adc #$50
	sta RES
	bcc next11

	inc RES+1
next11
	lda RESB+2
	cmp RESB+1
	beq next12

	inc RESB+2 
	bne new

next12
	lda #$0a
	jsr set_via_qvc 
	lda #$0d
	jsr set_via_qvc 

	rts

_abd0



// fill QVC_BUFFER_TEXT with 00 value

init_buffer_text_qvc
.(
	lda #<QVC_BUFFER_TEXT
	ldy #>QVC_BUFFER_TEXT
	sta store_char_buf+1 ; FIXME memory 
	sty store_char_buf+2 ; FIXME
	ldx #$50
	lda #$20
	ldy #$00
store_char_buf
	sta $9000,y
	iny
	bne store_char_buf
	inc store_char_buf+2
	dex
	bne store_char_buf
	rts

.)

_abf5
.(
	jsr ROUTINE2_QVC
	nop
	nop
	nop
	jmp _aac0 

.)
_ac00
.(
	nop
	nop
	nop
	ldy #$00
loop18
	lda (PTR1_QVC),y
	cmp #$20
	bne next21

	iny
	cpy #$50
	bne loop18

	jmp end2 
next21
	sty RES
	ldy #$4f
loop19
	lda (PTR1_QVC),y
	cmp #$20
	bne next20

	dey
	bpl loop19

next20
	sty RESB
	lda #$4f
	sec
	sbc RESB
	nop
	nop
	nop
	clc
	adc RES
	lsr 
	sta RES+1
	ldy #$4f
loop17
	lda (PTR1_QVC),y
	sta $bb30,y
	dey
	bpl loop17

	lda RES
	bne next16
	lda RESB
	beq end2

next16
	ldy #$4f
	lda #$20
loop8
	sta (PTR1_QVC),y
	dey
	bpl loop8

	ldx RES

	ldy RES+1
_ac4f
	lda $bb30,x
	sta (PTR1_QVC),y
	cpx RESB
	beq end2

	inx
	iny
	jmp _ac4f
end2

	rts


.)
_ac70
.(
	jsr _a860 
	ldy PTR3_QVC
	lda #$20
	sta ($f7),y ; FIXME
	rts

.)

_ac80
.(
	ldy #$4f
	lda #$20
loop7
	sta (PTR1_QVC),y
	dey
	bpl loop7
	rts
.)



_ac90
.(
	lda PTR3_QVC+1
	cmp #$ff
	beq end

	lda #$60
	ldy #$8f
	sta RES
	sty RES+1
	lda #$b0
	ldy #$8f
	sta RESB
	sty RESB+1
_aca6
	ldy #$4f
loop9
	lda (RES),y
	sta (RESB),y
	dey
	bpl loop9

	lda RES
	cmp PTR1_QVC

	bne next19
	lda RES+1
	cmp PTR1_QVC+1

	beq end
next19
	lda RES
	ldy RES+1
	sta RESB
	sty RESB+1
	lda RES
	sec
	sbc #$50
	sta RES
	bcs next18

	dec RES+1
next18
	jmp _aca6 
end
	jsr _ac80
	rts


.)
_ace0
.(
	LDA PTR3_QVC+1
	CMP #$FF
	BEQ _ad2a
	LDA PTR1_QVC
	LDY PTR1_QVC+1
	STA RES
	STY RES+1
	CLC
	ADC #$50
	STA RESB
	TYA
	ADC #$00
	STA RESB+1
_acf8
	LDY #$4F
_acfa
	LDA (RESB),Y
	STA (RES),Y
	DEY
	BPL _acfa
	LDA RESB
	LDY RESB+1
	STA RES
	STY RES+1
	LDA RESB
	CLC
	ADC #$50
	STA RESB
	BCC _ad14
	INC RESB+1
_ad14
	LDA RES
	CMP #$B0
	BNE _acf8
	LDA $01
	CMP #$8F
	BNE _acf8
	LDY #$4F
	LDA #$20
_AD24
	STA $8FB0,Y ; FIXME
	DEY
	BPL _AD24
_ad2a
	RTS
.)



_ad30
.(
	LDY PTR3_QVC
	CPY #$4F
	BEQ _ad43
	LDY #$4F
_ad38
	DEY
	LDA (PTR1_QVC),Y
	INY
	STA (PTR1_QVC),Y
	DEY
	CPY PTR3_QVC
	BNE _ad38
_ad43
	LDA #$20
	STA (PTR1_QVC),Y
	RTS

.)


_ad50
.(
	LDY PTR3_QVC
	CPY #$4F
	BEQ _ad65
_ad56	
	INY
	LDA (PTR1_QVC),Y
	DEY
	STA (PTR1_QVC),Y
	INY
	CPY #$4F
	BNE _ad56
	LDA #$20
	STA (PTR1_QVC),Y
_ad65
	RTS


.)

_ad70
.(
	lda $bb80
	eor #$80
	sta $bb80
	rts

.)
_ad7e
.(
	lda $02df ; fixme get last key pressed
	bpl end
	php
	and #$7f
	pha
	lda #$00
	sta $02df ; FIXME reset key pressed
	pla
	plp
end
	rts

.)
	


_ad90
.(
	ldx #$10
loop5
	ldy #$00
loop4
	jsr _ad7e ;
	bmi next14

	dey
	bne loop4
	dex 
	bne loop5
next14
	rts
.)
_ada0
.(
	jsr _aa60 
	jsr _ad90
	bmi next13
	nop
	jsr _aa60 
	jsr _ad90 
	bpl _ada0

next13
	and #$7f
	rts

.)

