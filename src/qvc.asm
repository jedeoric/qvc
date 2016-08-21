*=$a800

/*Disassembled QVC text editor for Oric*/

#define QVC_BUFFER_TEXT $4000
#define PTR1_QVC $f7 ; contains buffer text of qvc
#define PTR2_QVC $f5 ;contains address of the current video address
#define PTR3_QVC $f3


#define RES $00
#define RESB $02

	lda #$02
	sta $026a
	jmp start_qvc

.byt $A9,$B0,$A0,$8F,$85,$04,$84,$05
.byt $A9,$FF,$85,$03,$A0,$4F,$B1,$04,$C9,$20,$D0,$12,$88,$10,$F7,$A5
.byt $04,$38,$E9,$50,$85,$04,$B0,$02,$C6,$05,$C6,$03,$D0,$E6,$60,$00
.byt $08,$78,$8D,$01,$03,$AD,$00,$03,$29,$EF,$8D,$00,$03,$AD,$00,$03
.byt $09,$10,$8D,$00,$03,$28,$AD,$0D,$03,$29,$02,$F0,$F9,$AD,$0D,$03
.byt $60,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byt $A5,$F3,$F0,$0D,$A2,$11,$20,$C0,$A9,$C6,$F3,$A5,$F9,$F0,$02,$C6
.byt $F9,$60,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byt $A5,$F4,$F0,$23,$C6,$F4,$A5,$F7,$38,$E9,$50,$85,$F7,$B0,$02,$C6
.byt $F8,$A5,$C1,$F0,$0D,$C6,$C1,$A5,$F5,$38,$E9,$28,$85,$F5,$B0,$02
.byt $C6,$F6,$A2,$19,$20,$C0,$A9,$60,$00,$00,$00,$00,$00,$00,$00,$00
.byt $A9,$00,$85,$F9,$A9,$00,$85,$F3,$A9,$30,$8D,$91,$BB,$8D,$90,$BB
.byt $60,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
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
	lda RES
	sec
	sbc #$50
	sta $00
	bcs next
	dec RES+1
next
	dex 
.byt $D0,$F2 ; FIXME
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
.byt $A5,$F4,$C9,$FF,$F0,$27,$A5,$F7,$18,$69,$50,$85,$F7,$A5,$F8,$69
.byt $00,$85,$F8,$A5,$C1,$C9,$1A,$F0,$0D,$A5,$F5,$18,$69,$28,$85,$F5
.byt $90,$02,$E6,$F6,$E6,$C1,$E6,$F4,$A2,$19,$20,$A0,$A9,$60,$00,$00
.byt $A4,$F3,$91,$F7,$4C,$E0,$A9,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byt $A4,$F9,$B1,$F5,$49,$80,$91,$F5,$60,$00,$00,$00,$00,$00,$00,$00

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
	jsr ROUTINE2_QVC ; FIXME
	nop
	nop
	nop
	lda #$00
	sta $02df

	jsr $aac0 ; FIXME
	
.byt $C9,$1B,$D0,$03,$EA,$EA,$60,$20,$40,$AA,$4C,$95,$AA
.byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

_aac0
	lda #$00
	sta $02df
	jsr $ada0 ; FIXME
	cmp #$09
	bne compare_next


	jsr $a9e0 ; FIXME
	jmp $abf5 ; FIXME
compare_next
	cmp #$0A
	bne compare_next2
	jsr $aa10 ; FIXME
	jmp $abf5 ; FIXME
compare_next2
	cmp #$0b
	bne compare_next3
	jsr $a880  ; FIXME
	jmp $abf5  ; FIXME
compare_next3
	cmp #$08
	bne compare_next4
	jsr $a860  ; FIXME
	jmp $abf5  ; FIXME
compare_next4
_aaf0
	cmp #$0d
	bne compare_next5
	jsr $aa00
	jmp $abf5
compare_next5
	cmp #$04
	bne compare_next6
	jsr $ac00
	jmp $abf5
compare_next6
	cmp #$7f
	bne compare_next7
	jsr $ac70
	jmp $abf5
compare_next7
	cmp #$13
	bne compare_next8
	jsr $ac80
	jmp $abf5
compare_next8
	cmp #$1a
	bne compare_next9
	jsr $ac90
	jmp $abf5
compare_next9	
.byt $C9,$01,$D0,$06,$20,$E0,$AC,$4C,$F5,$AB,$C9,$17,$D0,$06
.byt $20,$30,$AD,$4C,$F5,$AB,$C9,$11,$D0,$06,$20,$50,$AD,$4C,$F5,$AB
.byt $C9,$05,$D0,$06,$20,$70,$AD,$4C,$F5,$AB,$C9,$10,$D0,$05,$68,$68
.byt $4C,$70,$AA,$C9,$41,$30,$12,$C9,$5B,$10,$0E,$AC,$09,$02,$C0,$A7
.byt $F0,$07,$C0,$A4,$F0,$03,$09,$20,$EA,$C9,$1B,$D0,$01,$60,$C9,$0F
.byt $D0,$06,$20,$80,$AB,$4C,$F5,$AB,$C9,$20,$30,$01,$60,$4C,$D0,$A8

_ab80

.byt $20,$08,$A8,$A9,$00,$85,$02,$8D,$DF,$02,$85,$04,$A0,$40,$85,$00
.byt $84,$01,$A0,$00,$B1,$00,$20,$30,$A8,$C8,$AD,$DF,$02,$F0,$03,$85
.byt $02,$EA,$C0,$50,$D0,$EE,$A5,$02,$D0,$15,$A5,$00,$18,$69,$50,$85
.byt $00,$90,$02,$E6,$01,$A5,$04,$C5,$03,$F0,$04,$E6,$04,$D0,$D3,$A9

.byt $0A,$20,$30,$A8,$A9,$0D,$20,$30,$A8,$60,$00,$00,$00,$00,$00,$00
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
.byt $00,$00,$00,$00,$00,$20,$F0,$A8,$EA,$EA,$EA,$4C,$C0,$AA,$00,$00

_ac00

.byt $EA,$EA,$EA,$A0,$00,$B1,$F7,$C9,$20,$D0,$08,$C8,$C0,$50,$D0,$F5
.byt $4C,$5D,$AC,$84,$00,$A0,$4F,$B1,$F7,$C9,$20,$D0,$03,$88,$10,$F7
.byt $84,$02,$A9,$4F,$38,$E5,$02,$EA,$EA,$EA,$18,$65,$00,$4A,$85,$01
.byt $A0,$4F,$B1,$F7,$99,$30,$BB,$88,$10,$F8,$A5,$00,$D0,$04,$A5,$02
.byt $F0,$1B,$A0,$4F,$A9,$20,$91,$F7,$88,$10,$FB,$A6,$00,$A4,$01,$BD
.byt $30,$BB,$91,$F7,$E4,$02,$F0,$05,$E8,$C8,$4C,$4F,$AC,$60,$00,$00
.byt $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byt $20,$60,$A8,$A4,$F3,$A9,$20,$91,$F7,$60,$00,$00,$00,$00,$00,$00
.byt $A0,$4F,$A9,$20,$91,$F7,$88,$10,$FB,$60,$00,$00,$00,$00,$00,$00
.byt $A5,$F4,$C9,$FF,$F0,$3B,$A9,$60,$A0,$8F,$85,$00,$84,$01,$A9,$B0
.byt $A0,$8F,$85,$02,$84,$03,$A0,$4F,$B1,$00,$91,$02,$88,$10,$F9,$A5
.byt $00,$C5,$F7,$D0,$06,$A5,$01,$C5,$F8,$F0,$16,$A5,$00,$A4,$01,$85
.byt $02,$84,$03,$A5,$00,$38,$E9,$50,$85,$00,$B0,$02,$C6,$01,$4C,$A6
.byt $AC,$20,$80,$AC,$60,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byt $A5,$F4,$C9,$FF,$F0,$44,$A5,$F7,$A4,$F8,$85,$00,$84,$01,$18,$69
.byt $50,$85,$02,$98,$69,$00,$85,$03,$A0,$4F,$B1,$02,$91,$00,$88,$10
.byt $F9,$A5,$02,$A4,$03,$85,$00,$84,$01,$A5,$02,$18,$69,$50,$85,$02
.byt $90,$02,$E6,$03,$A5,$00,$C9,$B0,$D0,$DE,$A5,$01,$C9,$8F,$D0,$D8
.byt $A0,$4F,$A9,$20,$99,$B0,$8F,$88,$10,$FA,$60,$00,$00,$00,$00,$00
.byt $A4,$F3,$C0,$4F,$F0,$0D,$A0,$4F,$88,$B1,$F7,$C8,$91,$F7,$88,$C4
.byt $F3,$D0,$F5,$A9,$20,$91,$F7,$60,$00,$00,$00,$00,$00,$00,$00,$00
.byt $A4,$F3,$C0,$4F,$F0,$0F,$C8,$B1,$F7,$88,$91,$F7,$C8,$C0,$4F,$D0
.byt $F5,$A9,$20,$91,$F7,$60,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byt $AD,$80,$BB,$49,$80,$8D,$80,$BB,$60,$00,$00,$00,$00,$00,$AD,$DF
.byt $02,$10,$0B,$08,$29,$7F,$48,$A9,$00,$8D,$DF,$02,$68,$28,$60,$00
.byt $A2,$10,$A0,$00,$20,$7E,$AD,$30,$06,$88,$D0,$F8,$CA,$D0,$F3,$60
.byt $20,$60,$AA,$20,$90,$AD,$30,$09,$EA,$20,$60,$AA,$20,$90,$AD,$10
.byt $EF,$29,$7F,$60,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00