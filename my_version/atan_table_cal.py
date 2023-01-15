#!/usr/bin/python3
import math

# // arctan table
# // values in the table is represented in a 32 bit format
# // atan(2^0) = 45 deg = 45/360 * 2^32
# // atan(2^1) = 26.565 deg = 26.565/360 * 2^32

for i in range(0,31):
    val = math.pow(2,-i)
    deg = math.degrees(math.atan(val))
    eqv = deg * (math.pow(2,32) / 360)
    print("assign atan_table[{0}] = ".format(i), end="")
    print('32\'b{:032b} ;'.format(int(eqv)))