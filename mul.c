// this function multiply 2 integer numbers; return the product of signed extended low 32-bit word
int multiply_int32(register long multiplicand, register long multiplier ) {
    register long t1, t2, t3, counter, product;
    counter = 0x20;
    multiplicand <<= 0x20;
    multiplier <<= 1;
loop:
    t1 = multiplier & 3;                          // t1 saved pattern
    t2 = t1 < 3;
    t3 = 0 < t1;
    if(t2 != t3)goto done_0;
    t1 = t1 & 1;
    if(t1 == 0)goto done_1;
    product += multiplicand;                           // add multiplicand if pattern is 01
    goto done_0;
done_1:
    product -= multiplicand;                           // sub multiplicand if pattern is 10
done_0:
    multiplier >>= 1;
    product >>= 1;
    counter -= 1;
    if(counter != 0)goto loop;
    return product;
}
