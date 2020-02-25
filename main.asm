; main.asm
; Main code for testing/demoing bluelib
;
.sdsctag 1.0, "bluelib", "SMS/GG library", "hang-on Entertainment"
;
.include "bluelib.inc"        ; General library with foundation stuff.
;
.include "header.inc"         ; Constants and struct instantiations.
;
;
;
; -----------------------------------------------------------------------------
.section "main" free
; -----------------------------------------------------------------------------
  init:
    ; Run this function once (on game load). Assume we come here from bluelib
    ; boot code with ram, vram, mappers and registers initialized.
    ; Load the pico-8 palette to colors 16-31.
    ; Note: We can also come here from reset!
    ;
    ;
    ;
    ;
    ; Load the pico-8 palette to colors 0-31.
    ld a,CRAM_FIRST_COLOR
    ld b,CRAM_MAX_COLORS
    ld hl,pico8_palette_sms
    call load_cram
    ;
    ; Blank left column.
    ld a,SCROLL_0__LCB_1_LINE_0_SPRITES_0
    ld b,REGISTER_0
    call set_register
    ;
  jp main_loop
  ;
  ; ---------------------------------------------------------------------------
  main_loop:
    ;
  jp main_loop
  ;
  ; ---------------------------------------------------------------------------
  ;
  ; ---------------------------------------------------------------------------
.ends
;
.include "footer.inc"
