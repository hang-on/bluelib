; footer.inc
; Data.
.bank 1 slot 1
;
; -----------------------------------------------------------------------------
.section "Misc data" free
; -----------------------------------------------------------------------------
  colors:
    .db $00 $10 $12 $18 $06 $15 $2A $3F $13 $0B $0F $0C $38 $26 $27 $2F
    .db $00 $10 $12 $18 $06 $15 $2A $3F $13 $0B $0F $0C $38 $26 $27 $2F
    colors_end:
  ;
  VDPRegisterInitData:
    .db SCROLL_0_LINE_0_SPRITES_0
    .db DISPLAY_0_FRAME_0_SIZE_0
    .db $ff,$ff,$ff,$ff,$ff,$00,$00,$00,$ff
.ends
