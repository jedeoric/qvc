*=$a800

/* Disassembled QVC text editor for Oric */


#define QVC_BUFFER_TEXT $4000
#define PTR1_QVC $f7 ; contains buffer text of qvc
#define PTR2_QVC $f5 ;contains address of the current video address
#define PTR3_QVC $f3

// Salut

#define RES $00
#define RESB $02

	lda #$02
	sta $026a
	jmp start_qvc

.byt $A9,$B0,$A0,$8F,$85,$04,$84,$05
.byt $A9,$FF,$85,$03,$A0,$4F,$B1,$04,$C9,$20,$D0,$12,$88,$10,$F7,$A5


.byt $04,$38,$E9,$50,$85,$04,$B0,$02,$C6,$05,$C6,$03,$D0,$E6,$60,$00

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
.)

/**/
.byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

_a860
.(
	lda $f3
	beq end
	ldx #$11
	jsr $a9c0 ; FIXME
	dec $f3
	lda $f9
	beq end
	dec $f9
end	
	rts
.)
.byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

_a880
	lda $f4
.byt $F0,$23 ; FIXME
	dec $f4
	lda $f7
	
.byt $38,$E9,$50,$85,$F7,$B0,$02,$C6
.byt $F8,$A5,$C1,$F0,$0D,$C6,$C1,$A5,$F5,$38,$E9,$28,$85,$F5,$B0,$02
.byt $C6,$F6,$A2,$19,$20,$C0,$A9,$60,$00,$00,$00,$00,$00,$00,$00,$00
.byt $A9,$00,$85,$F9,$A9,$00,$85,$F3,$A9,$30,$8D,$91,$BB,$8D,$90,$BB
.byt $60,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

_a8d0

.byt $C9,$18,$D0,$0B,$AD,$6A,$02,$49,$08,$8D,$6A,$02,$4C,$F5,$AB,$4C
.byt $C0,$AA,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

_a8f0


ROUTINE2_QVC

	lda PTR1_QVC
	ldy PTR1_QVC+1
	sta RES
	sty RES+1
	
	ldx $c1 ; FIXME
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
	sbc $f9 ; fIXME
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
	;bne loop2
.byt $D0,$DC ; FIXME
	rts
.byt $00,$00,$00,$00,$00,$00,$00,$00

_a960

.byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byt $2A,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$58,$3A
.byt $30,$30,$20,$20,$20,$59,$3A,$30,$30,$30,$20,$20,$20,$20,$20,$20
.byt $20,$20,$20,$20,$20,$20,$20,$20,$00,$00,$00,$00,$00,$00,$00,$00

_a990
display_status_line_qvc
	ldx #$27
loop
	lda $a960,x ; FIXME
	sta $bb80,x
	dex 
	bpl loop
	rts
.byt $00,$00,$00,$00
.byt $BD,$80,$BB,$C9,$39,$F0,$07,$18,$69,$01,$9D,$80,$BB,$60,$A9,$30
.byt $9D,$80,$BB,$CA,$D0,$EA,$60,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byt $BD,$80,$BB,$C9,$30,$F0,$07,$38,$E9,$01,$9D,$80,$BB,$60,$A9,$39
.byt $9D,$80,$BB,$CA,$D0,$EA,$60,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byt $A5,$F3,$C9,$4F,$F0,$0F,$E6,$F3,$A5,$F9,$C9,$27,$F0,$02,$E6,$F9
.byt $A2,$11,$4C,$A0,$A9,$AD,$80,$BB,$10,$06,$60,$00,$00,$00,$00,$00

_aa00

.byt $20,$B0,$A8,$4C,$10,$AA,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

_aa10
	lda PTR3_QVC+1 ; FIXME
	cmp #$ff
.byt $F0,$27 ; FIXME
	lda $f7 ; FIXME
	clc
	adc #$50
	sta $f7; FIXME 
	lda $f8 ; FIXME
	adc #$00
	sta $f8
	lda $c1 ; FIXME
	cmp #$1a
.byt $F0,$0D ; FIXME
	lda PTR2_QVC ; FIXME
	clc
	adc #$28
	sta PTR2_QVC

.byt $90,$02
	inc $f6 ; FIXME
	inc $c1
	inc PTR3_QVC+1
	ldx #$19
	jsr $a9a0
	rts


.byt $00,$00
.byt $A4,$F3,$91,$F7,$4C,$E0,$A9,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00


_aa60
.(
	ldy $f9 ; FIXME
	lda (PTR2_QVC),y ; FIXME
	eor #$80
	sta (PTR2_QVC),y ; FIXME
	rts
.byt $00,$00,$00,$00,$00,$00,$00
.)
_aa70



start_qvc
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
	stz $f9
	stz $c1
#else
	lda #$00 
	sta $f9 ; dunno yet FIXME
	sta $c1 ; DUNNO yet FIXME
#endif

	nop
	nop
	nop
	jsr ROUTINE2_QVC
	nop
	nop
	nop
	lda #$00
	sta $02df

	jsr _aac0 
	
.byt $C9,$1B,$D0,$03,$EA,$EA,$60,$20,$40,$AA,$4C,$95,$AA
.byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

_aac0
	lda #$00
	sta $02df
	jsr _ada0 
	cmp #$09
	bne compare_next


	jsr $a9e0 ; FIXME
	jmp _abf5 
compare_next
	cmp #$0A
	bne compare_next2
	jsr $aa10 ; FIXME
	jmp _abf5 
compare_next2
	cmp #$0b
	bne compare_next3
	jsr $a880  ; FIXME
	jmp _abf5  
compare_next3
	cmp #$08
	bne compare_next4
	jsr $a860  ; FIXME
	jmp _abf5 
compare_next4
_aaf0
	cmp #$0d
	bne compare_next5
	jsr $aa00 ; FIXME
	jmp _abf5 
compare_next5
	cmp #$04
	bne compare_next6
	jsr $ac00 ; FIXME
	jmp _abf5 
compare_next6
	cmp #$7f
	bne compare_next7
	jsr $ac70 ; FIXME
	jmp _abf5 
compare_next7
	cmp #$13
	bne compare_next8
	jsr $ac80 ; FIXME
	jmp _abf5 
compare_next8
	cmp #$1a
	bne compare_next9
	jsr $ac90 ; FIXME
	jmp _abf5 
compare_next9
	cmp #$01
	bne compare_next10
	jsr $ace0 ; FIXME
	jmp _abf5 
compare_next10
	cmp #$17
	bne compare_next11
	jsr $ad30 ; FIXME
	jmp _abf5 
compare_next11
	cmp #$11
	bne compare_next12
	jsr $ad50 ; FIXME
	jmp _abf5 
compare_next12
	cmp #$05
	bne compare_next13
	jsr $ad70 ; FIXME
	jmp _abf5 
compare_next13
	cmp #$10
	bne compare_next14

	pla
	pla 
	jmp $aa70 ; FIXME
compare_next14
	cmp #$41
	bmi next8
	cmp #$5b
	bpl next8
	ldy $0209 ; FIXME
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
	jsr _ab80 ;FIXME
	jmp _abf5 ;FIXME
compare_next15
	cmp #$20

	bmi next9
	rts
next9
	jmp $a8d0 ;FIXME
_ab80

	jsr $a808
	lda #$00
	sta RESB
	sta $02df ; FIXME
	sta $04 ; FIXME
	ldy #$40 ; BUFFER FIXME ?
	sta RES
	sty RES+1
	
	ldy #0
	lda (RES),y
	jsr set_via_qvc ; FIXME
	iny
	lda $02df
	beq next10
	sta RESB
	nop
next10
	cpy #$50

.byt $D0,$EE ; FIXME

	lda RESB
	bne next12


	lda RES
	clc
	adc #$50
	sta RES
	bcc next11

	inc RES+1
next11
	lda $04
	cmp RESB+1
	beq next12

	inc $04 ; FIXME
.byt $D0,$D3 ; FIXME
next12
	lda #$0a
	jsr set_via_qvc 
	lda #$0d
	jsr set_via_qvc 

	rts
.byt $00,$00,$00,$00,$00,$00
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



.byt $00,$00,$00
_abf0
.byt $00,$00,$00,$00,$00

_abf5
	jsr ROUTINE2_QVC
	nop
	nop
	nop
	jmp _aac0 
.byt $00,$00

_ac00

.byt $EA,$EA,$EA,$A0,$00,$B1,$F7,$C9,$20,$D0,$08,$C8,$C0,$50,$D0,$F5
.byt $4C,$5D,$AC,$84,$00,$A0,$4F,$B1,$F7,$C9,$20,$D0,$03,$88,$10,$F7
.byt $84,$02,$A9,$4F,$38,$E5,$02,$EA,$EA,$EA,$18,$65,$00,$4A,$85,$01
.byt $A0,$4F,$B1,$F7,$99,$30,$BB,$88,$10,$F8,$A5,$00,$D0,$04,$A5,$02

.byt $F0,$1B,$A0,$4F,$A9,$20,$91,$F7,$88,$10,$FB,$A6,$00,$A4,$01,$BD
.byt $30,$BB,$91,$F7,$E4,$02,$F0,$05,$E8,$C8,$4C,$4F,$AC,$60,$00,$00
.byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

_ac70
	jsr $a860 ; FIXME
	ldy $f3
	lda #$20
.byt $91,$F7 ; FIXME
	rts
.byt $00,$00,$00,$00,$00,$00

_ac80

.byt $A0,$4F,$A9,$20,$91,$F7,$88,$10,$FB,$60,$00,$00,$00,$00,$00,$00
.byt $A5,$F4,$C9,$FF,$F0,$3B,$A9,$60,$A0,$8F,$85,$00,$84,$01,$A9,$B0
.byt $A0,$8F,$85,$02,$84,$03,$A0,$4F,$B1,$00,$91,$02,$88,$10,$F9,$A5
.byt $00,$C5,$F7,$D0,$06,$A5,$01,$C5,$F8,$F0,$16,$A5,$00,$A4,$01,$85
.byt $02,$84,$03,$A5,$00,$38,$E9,$50,$85,$00,$B0,$02,$C6,$01,$4C,$A6
.byt $AC,$20,$80,$AC,$60,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byt $A5,$F4,$C9,$FF,$F0,$44,$A5,$F7,$A4,$F8,$85,$00,$84,$01,$18,$69
.byt $50,$85,$02,$98,$69,$00,$85,$03,$A0,$4F,$B1,$02,$91,$00,$88,$10

_ad00

.byt $F9,$A5,$02,$A4,$03,$85,$00,$84,$01,$A5,$02,$18,$69,$50,$85,$02
.byt $90,$02,$E6,$03,$A5,$00,$C9,$B0,$D0,$DE,$A5,$01,$C9,$8F,$D0,$D8
.byt $A0,$4F,$A9,$20,$99,$B0,$8F,$88,$10,$FA,$60,$00,$00,$00,$00,$00
.byt $A4,$F3,$C0,$4F,$F0,$0D,$A0,$4F,$88,$B1,$F7,$C8,$91,$F7,$88,$C4
.byt $F3,$D0,$F5,$A9,$20,$91,$F7,$60,$00,$00,$00,$00,$00,$00,$00,$00
.byt $A4,$F3,$C0,$4F,$F0,$0F,$C8,$B1,$F7,$88,$91,$F7,$C8,$C0,$4F,$D0
.byt $F5,$A9,$20,$91,$F7,$60,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

_ad70
	lda $bb80
	eor #$80
	sta $bb80
	rts
.byt $00,$00,$00,$00,$00
_ad7e
.(
	lda $02df ; fixme
	bpl end
	php
	and #$7f
	pha
	lda #$00
	sta $02df ; FIXME
	pla
	plp
end
	rts
.)
	
.byt $00

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
	jsr $aa60 ; FIXME
	jsr _ad90 ; FIXME
	bmi next13
	nop
	jsr $aa60 ; FIXME
	jsr _ad90 ; FIXME
	bpl _ada0

next13
	and #$7f
	rts
.byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00


