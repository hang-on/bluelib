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
    ; boot code with initialized vram and memory control registers (INIT).
    ;
    ld a,COLOR_0
    ld b,colors_end-colors
    ld hl,colors
    call load_cram
    ;
    ld bc,CHARACTER_SIZE
    ld de,SPRITE_BANK_START
    ld hl,character
    call load_vram
    ;
    ;
    ei
    halt
    halt
    xor a
    ld (vblank_counter),a
    ;
  jp main_loop
  ;
  ; ---------------------------------------------------------------------------
  main_loop:
    ;
    ; Wait until vblank interrupt handler increments counter.
    ld hl,vblank_counter
    -:
      ld a,(hl)
      cp 0
    jp z,-
    ; Reset counter.
    xor a
    ld (hl),a
    ;
    ; -------------------------------------------------------------------------
    ; Begin vblank critical code (DRAW).
    call draw_bluelib
    ;
    ; -------------------------------------------------------------------------
    ; Begin general updating (UPDATE).
    call update_bluelib
    ;
  jp main_loop
  ;
  ; ---------------------------------------------------------------------------
  ;
  ; ---------------------------------------------------------------------------
.ends
;
;
.include "footer.inc"
