// this function multiply 2 integer numbers; return the product of signed extended low 32-bit word
int multiply_int32(register long multiplicand, register long multiplier ) {
    register long pattern, t2, t3, counter, product;
    counter = 0x20;
    multiplicand <<= 0x20;
    multiplier <<= 1;
loop:
    pattern = multiplier & 3;
    t2 = pattern < 3;
    t3 = 0 < pattern;
    if(t2 == t3){
        pattern &= 1;
        if(pattern != 0)goto {
            product += multiplicand;                           // add multiplicand if pattern is 01
            goto done_0;
        }
        product -= multiplicand;   
        done_0:                                                // sub multiplicand if pattern is 10
    }
    multiplier >>= 1;
    product >>= 1;
    counter -= 1;
    if(counter != 0)goto loop;
    return product;
}
