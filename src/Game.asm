.include "Header.inc"
.include "Snes_Init.asm"

; Needed to satisfy interrupt definition in "Header.inc".
VBlank:
  RTI

.bank 0
.section "MainCode"

Start:
  ; Initialize the SNES.
  Snes_Init
  jsr Graphics_Init

  ; Set the background color to green.
  sep     #$20        ; Set the A register to 8-bit.
  lda     #%10000000  ; Force VBlank by turning off the screen.
  sta     $2100
  lda     #%11100000  ; Load the low byte of the green color.
  sta     $2122
  lda     #%00000000  ; Load the high byte of the green color.
  sta     $2122
  lda     #%00001111  ; End VBlank, setting brightness to 15 (100%).
  sta     $2100
  lda #$ff
  sta $0002

    ; Loop forever.
    ; Make the screen update with crazy colors
Forever:
  lda #%10000000
  sta $2100
  lda $0000
  sta $2122
  lda $0001
  sta $2122
  lda #%00001111
  sta $2100
  inc $0000
  lda $0000
  cmp $0002
  beq inc1
  jmp Forever

inc1:
  inc $0001
  jmp Forever
.ends

Graphics_Init:
  SEP #$20
  LDA #%00000000 ; 16x16 sprites
  STA $2101
  LDA #%00100010 ; mode 2 (2 bgs: 1 8x8 and 1 16x16)
  rts
