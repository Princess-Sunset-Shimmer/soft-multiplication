# soft-multiplication
this is the simple program made in C for understanding how does multiplication work; booth algorithm
```c
```
and this is a working half multiply in x86 assembly
```asm
multiply.half:  /* multiplicand, multiplier */
        cmp     rax, 0
        jz      multiply.half.done
        xor     rcx, rcx                /* initiate previous_number, ZERO */
        mov     rdx, rdi                /* cast next_number, multiplier */
multiply.half.repeat:
        mov     rsi, rax                /* cast argument_3, multiplicand */
        and     rsi, 1                  /* and argument_2, LOWEST_BIT */
        jz      multiply.half.zero
        add     rcx, rdx                /* ahead previous_number, next_number */
multiply.half.zero:
        shl     rdx, 1
        shr     rax, 1
        jnz     multiply.half.repeat
        mov     rax, rcx                /* cast return_value, half_product */
multiply.half.done:
        jmp     r11                     /* return */
```
and this is a working full multiply in x86 assembly
```asm
multiply.full:  /* multiplicand, multiplier */
        xor     rdx, rdx                /* initiate return_value.high, 0 */
        cmp     rax, 0                  /* compare multiplicand, 0 */
        jz      multiply.full.done
        xor     rsi, rsi                /* initiate previous_number.low, 0 */
        mov     r9, rdi                 /* cast next_number.low, multiplier */
        mov     r10, rdi                /* cast next_number.high, multiplier */
        shr     r10, 0x3F               /* shift next_number.high, 0x3F --arithmaticly */
        mov     rcx, 0x3F               /* initiate next_position.high, 0x3F */
multiply.full.repeat:
        mov     r8, rax                 /* cast argument_5, multiplicand */
        and     r8, 1                   /* and argument_5, LOWEST_BIT */
        jz      multiply.full.zero
        add     rsi, r9                 /* ahead previous_number.low, next_number.low */
        adc     rdx, r10                /* ahead previous_number.high, next_number.high --carry */
multiply.full.zero:
        shl     r9, 1                   /* shift next_number.low, NEXT_POSITION --left */
        mov     r10, rdi                /* cast next_number.high, multiplier */
        shr     r10, cl                 /* shift next_number.high, next_position.high --arithmaticly */
        add     rcx, -1                 /* back next_position.high, 1 */
        shr     rax, 1                  /* shift unsign_multipliicand, NEXT_BIT --right */
        jnz     multiply.full.repeat
        mov     rax, rsi                /* cast return_value.low, previous_number.low */
multiply.full.done:
        jmp     r11                     /* return */
```
and this is a working full multiply unsign sign in x86 assembly
```asm
multiply.unsign_sign:   /* unsign_multiplicand, sign_multiplier */
        xor     rdx, rdx                /* initiate return_value.high, 0 */
        cmp     rax, 0                  /* compare unsign_multiplicand, 0 */
        jz      multiply.unsign_sign.done
        xor     rsi, rsi                /* initiate previous_number.low, 0 */
        mov     r9, rdi                 /* cast next_number.low, sign_multiplier */
        mov     r10, rdi                /* cast next_number.high, sign_multiplier */
        sar     r10, 0x3F               /* shift next_number.high, 0x3F --arithmaticly */
        mov     rcx, 0x3F               /* initiate next_position.high, 0x3F */
multiply.unsign_sign.repeat:
        mov     r8, rax                 /* cast argument_5, unsign_multiplicand */
        and     r8, 1                   /* and argument_5, LOWEST_BIT */
        jz      multiply.unsign_sign.zero
        add     rsi, r9                 /* ahead previous_number.low, next_number.low */
        adc     rdx, r10                /* ahead previous_number.high, next_number.high --carry */
multiply.unsign_sign.zero:
        shl     r9, 1                   /* shift next_number.low, NEXT_POSITION --left */
        mov     r10, rdi                /* cast next_number.high, sign_multiplier */
        sar     r10, cl                 /* shift next_number.high, next_position.high --arithmaticly */
        add     rcx, -1                 /* back next_position.high, 1 */
        shr     rax, 1                  /* shift unsign_multipliicand, NEXT_BIT --right */
        jnz     multiply.unsign_sign.repeat
        mov     rax, rsi                /* cast return_value.low, previous_number.low */
multiply.unsign_sign.done:
        jmp     r11                     /* return */
```
base on multiply unsign sign, we can do multiply both sign
```asm
multiply.sign:  /* sign_multiplicand, sign_multiplier */
        lea     rsi, multiply.sign.both_sign[rip]
        lea     rcx, multiply.unsign_sign[rip]
        mov     -8[rsp], rcx            /* write stack(table.jump_address.0), jump_address.unsign_sign */
        mov     -0x10[rsp], rsi         /* write stack(table.jump_address.1), jump_address.sign_sign */
        mov     r10, rsp                /* cast pointer.jump_address, stack_pointer */
        mov     rsi, rax                /* cast sign_checker, sign_multiplicand */
        sar     rsi, 0x3F               /* shift sign_checker, 0x3F --arithmatically */
        shl     rsi, 3                  /* shift jump_offset, 3 --left */
        add     r10, rsi                /* ahead pointer.jump_address, jump_offset */
        mov     r10, -8[r10]            /* fetch jump_address, pointer.jump_address(-8) */
        jmp     r10                     /* go jump_address */
multiply.sign.both_sign:
        mov     -8[rsp], r11            /* write stack(BACKUP), return_address */
        add     rsp, -8                 /* ahead stack_pointer, -8 */
        lea     r11, multiply.sign.return_point.0[rip]
        jmp     multiply.unsign_sign    /* go multiply.unsign_sign */
multiply.sign.return_point.0:
        mov     r9, rdi                 /* cast next_sign_high, sign_multiplier */
multiply.sign.repeat_high:
        add     rdx, r9                 /* ahead sign_high, next_sigh_high */
        shl     r9, 1                   /* shift next_sign_high, 1 --left */
        jnz     multiply.sign.repeat_high
        mov     r11, 0[rsp]             /* read return_address, stack(BACKUP) */
        add     rsp, 8                  /* ahead stack_pointer, 8 */
        jmp     r11                     /* return */
```

