// this function multiply 2 integer numbers; return the product of signed extended low 32-bit word
long mulw(register long multiplicand, register long multiplier ) {
    register long t1, t2, t3, t4, a0;       /* a0 is product */
    t4 = 0x20;                              /* t4 is counter */
    multiplicand <<= 0x20;
    multiplier <<= 0x1;
loop:
    t1 = multiplier & 0x3;                          // t1 saved pattern
    t2 = t1 < 0x3;
    t3 = 0 < t1;
    if(t2 != t3)goto done_0;
    t1 = t1 & 0x1;
    if(t1 == 0)goto done_1;
    a0 += multiplicand;                           // add multiplicand if pattern is 01
    goto done_0;
done_1:
    a0 -= multiplicand;                           // sub multiplicand if pattern is 10
done_0:
    multiplier >>= 0x1;
    a0 = a0 >> 0x1;
    t4 = t4 + (char signed)0xff;
    if(t4 != 0)goto loop;
    return (int)a0;
}
