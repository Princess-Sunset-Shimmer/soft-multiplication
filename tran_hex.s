        .intel_syntax noprefix
        .global tran_hex
        .text
tran_hex:       /* transformee, result_pointer */
        mov     rsi, 0x3030303030303030                 /* initiate initiater, "00000000" */
        mov     0[rdi], rsi                             /* write result_pointer(0), initiater */
        mov     8[rdi], rsi                             /* write result_pointer(8), initiater */
        cmp     rax, 0                                  /* compare transformee, ZERO */
        jz      tran_hex.done
        add     rdi, 0xF                                /* ahead result_pointer, LAST_LETTER_POSITION */
        mov     r10, 7                                  /* set offset_step, EXTRA_LETTER_FIELD_OFFSET */
tran_hex.repeat:
        xor     r9, r9                                  /* clean extra_offseter */
        mov     rcx, rax                                /* cast argument_3, transformee */
        and     rcx, 0xF                                /* and argument_3, LOW_4BIT */
        add     rcx, 0x30                               /* ahead argument_3, NUMBER_FIELD_OFFSET */
        cmp     rcx, 0x3A                               /* compare argument_3, NUMBER_FIELD_BORDER */
        cmovae  r9, r10                                 /* cast extra_offseter, offset_step --if-over-border */
        add     rcx, r9                                 /* ahead argument_3, extra_offseter */
        mov     0[rdi], cl                              /* write result_pointer(0), argument_3 --one_letter */
        add     rdi, -1                                 /* ahead result_pointer, 1_STEP */
        shr     rax, 4                                  /* shift transformee, NEXT_ONE --right */
        jnz     tran_hex.repeat
tran_hex.done:
        jmp    r11                                      /* return */
