; -----------------------------------------------------------------------------
.section "load_vdp_registers" free
; -----------------------------------------------------------------------------
  load_vdp_registers:
    ; Load all 11 vdp registers with preset values.
    ; Entry: HL pointing to init data block (11 bytes).
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
  ret
.ends
;
; -----------------------------------------------------------------------------
.section "put_string" free
; -----------------------------------------------------------------------------
  ; Put a string of multiple characters on the nametable with minimum overhead.
  ; Entry: B = Number og characters in string.
  ;        HL = Pointer to string: Nametable address (word), then pairs of
  ;             bytes [char], [flags]
  ; Exit: None
  ; Uses: AF, B, HL
  put_string:
    ld a,(hl)
    out (CONTROL_PORT),a
    inc hl
    ld a,(hl)
    or VRAM_WRITE_COMMAND
    out (CONTROL_PORT),a
    -:
      inc hl
      ld a,(hl)
      out (DATA_PORT),a
      inc hl
      ld a,(hl)
      out (DATA_PORT),a             ; Write 2nd byte to name table.
    djnz -
  ret
.ends
;
; -----------------------------------------------------------------------------
.section "set_vram_address" free
; -----------------------------------------------------------------------------
  ; Set vram address.
  ; Entry: HL = Address.
  ; Exit:
  ; Uses:
  set_vram_address:
    ld a,l
    out (CONTROL_PORT),a
    ld a,h
    or VRAM_WRITE_COMMAND
    out (CONTROL_PORT),a
  ret
.ends
