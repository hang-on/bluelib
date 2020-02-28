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
    ;
    ; Load color values to CRAM, starting from color 0.
    ld a,COLOR_0
    ld b,colors_end-colors
    ld hl,colors
    call load_cram
    ;
    ;
    call InitializeVDPRegisters
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
;
; -----------------------------------------------------------------------------
.section "InitializeVDPRegisters" free
; -----------------------------------------------------------------------------
  ; Initialize the 11 VDP registers with the preset data block.
  ; Uses: AF, B, HL
  InitializeVDPRegisters:
    ld hl,VDPRegisterInitData
    xor b
    -:
      ld a,(hl)
      out (CONTROL_PORT),a
      inc hl
      ld a,b
      or REGISTER_WRITE_COMMAND
      out (CONTROL_PORT),a
      cp REGISTER_WRITE_COMMAND|10
      ret z
      inc b
    jr -
.ends
;
.include "footer.inc"
