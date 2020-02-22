; header.inc
; Declare constants, global variables etc.
; -----------------------------------------------------------------------------
;
; Pico-related definitions:
  .equ PICO8_PALETTE_SIZE 16
  .equ BLACK 0
  .equ DARK_BLUE 1
  .equ DARK_PURPLE 2
  .equ DARK_GREEN 3
  .equ BROWN 4
  .equ DARK_GREY 5
  .equ LIGHT_GREY 6
  .equ WHITE 7
  .equ RED 8
  .equ ORANGE 9
  .equ YELLOW 10
  .equ GREEN 11
  .equ BLUE 12
  .equ INDIGO 13
  .equ PINK 14
  .equ PEACH 15
  ;

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
.ramsection "Main variables" slot 3
  ;
  my_byte_var db                  ; Comment.
  ;
.ends
