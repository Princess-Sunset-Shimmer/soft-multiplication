        .intel_syntax noprefix
        .global divide
        .text
divide: /* dividend, divisor */
        mov     rsi, 0x40                       /* initiate counter, 0x40 */
        xor     rdx, rdx                        /* initiate remainder, 0 */
divide.repeat:
        shl     rdx, 1                          /* shift remainder, 1 --left */
        shl     rax, 1                          /* shift divedend, 1 --left */
        adc     rdx, 0                          /* ahead remainder, 0 --carry */
        add     rsi, -1                         /* ahead counter, -1 */
        jz      divide.break
        cmp     rdx, rdi                        /* compare remainder, divisor */
        jb      divide.repeat
        add     rax, 1                          /* ahead quotient, 1 */
        sub     rdx, rdi                        /* back remainder, divisor */
        jmp     divide.repeat
divide.break:
        cmp     rdx, rdi                        /* compare remainder, divisor */
        jb      divide.return
        add     rax, 1                          /* ahead quotient, 1 */
        sub     rdx, rdi                        /* back remainder, divisor */
divide.return:
        jmp     r11                             /* return */
