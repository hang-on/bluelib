; main.asm
; Main code for testing/demoing bluelib
;
.sdsctag 1.0, "bluelib", "SMS/GG library", "hang-on Entertainment"

.include "bluelib.inc"        ; General library with foundation stuff.
                              ; Includes memory map, help functions etc.
.include "testlib.inc"        ; Rudimentary unit testing (depends on bluelib).
.include "psglib.inc"         ; Stand-alone music and SFX lib (c) sverx.
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
    di
    ;
    call PSGInit
    ;
    call disable_display_and_sound
    ; Load the pico-8 palette to colors 16-31.
    ld a,SPRITE_PALETTE_START
    ld b,PICO8_PALETTE_SIZE
    ld hl,pico8_palette_sms
    call load_cram
    ; Load the pico-8 palette to colors 0-15.
    ld a,BACKGROUND_PALETTE_START
    ld b,PICO8_PALETTE_SIZE
    ld hl,pico8_palette_sms
    call load_cram
    ; Load the font tiles.
    SELECT_BANK FONT_BANK
    ld hl,font_table
    call load_vram_from_table
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
    ; Note: This loop can begin on any line - wait for vblank in the states!
    ld a,(game_state)   ; Get current game state - it will serve as JT offset.
    add a,a             ; Double it up because jump table is word-sized.
    ld h,0              ; Set up HL as the jump table offset.
    ld l,a
    ld de,game_state_jump_table ; Point to JT base address (see footer.inc).
    add hl,de           ; Apply offset to base address.
    ld a,(hl)           ; Get LSB from table.
    inc hl              ; Increment pointer.
    ld h,(hl)           ; Get MSB from table.
    ld l,a              ; HL now contains the address of the state handler.
    jp (hl)             ; Jump to this handler - note, not call!
    ;
  ; ---------------------------------------------------------------------------
  ; S E T U P  G A M E  A N D  S E T U P / R U N  L E V E L                                                        (gameplay)
  ; ---------------------------------------------------------------------------
  .include "gs_level.inc"             ; Prepare and run levels.
  ;
  ; ---------------------------------------------------------------------------
  ; D E V E L O P M E N T  M E N U
  ; ---------------------------------------------------------------------------
  .include "gs_devmenu.inc"
  ;
  ; ---------------------------------------------------------------------------
  ; T I T L E S C R E E N
  ; ---------------------------------------------------------------------------
  .include "gs_titlescreen.inc"
  ;
  ; ---------------------------------------------------------------------------
  ; H I S C O R E
  ; ---------------------------------------------------------------------------
  .include "gs_hiscore.inc"
  ;
  ; ---------------------------------------------------------------------------
  ; G A M E  O V E R
  ; ---------------------------------------------------------------------------
  .include "gs_game_over.inc"
  ;
  ; ---------------------------------------------------------------------------
  ; C O N F I R M  R E S E T
  ; ---------------------------------------------------------------------------
  .include "gs_confirm_reset_data.inc"
  ;
  ; ---------------------------------------------------------------------------
  ; W A R N I N G
  ; ---------------------------------------------------------------------------
  .include "gs_warning.inc"
  ;
  ; ---------------------------------------------------------------------------
  ; S P L A S H  S C R E E N
  ; ---------------------------------------------------------------------------
  .include "gs_splash_screen.inc"
  ;
  ; ---------------------------------------------------------------------------
  ; S A N D B O X  A N D  C O N S O L E
  ; ---------------------------------------------------------------------------
  .include "gs_sandbox.inc"
  .include "gs_console.inc"
.ends
;
.include "footer.inc"