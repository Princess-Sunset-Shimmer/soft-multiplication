# soft-multiplication
this is the simple program made in C for understanding how does multiplication work; booth algorithm
```c
```
and this is a working multiply half in x86 assembly
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
