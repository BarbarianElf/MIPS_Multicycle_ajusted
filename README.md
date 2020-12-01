# MIPS Multicycle 32 bit
An implementaiton of the MIPS multicycle processor 32bit using VHDL

![Picture1](https://user-images.githubusercontent.com/69726708/100778999-64c9cd00-3410-11eb-951b-e0cf526abd0a.png)

## MIPS instructions:
MIPS insructions stored in memoryfile which can be found in the file [memoryfile](./MIPS_MULTICYCLE/memoryfile.vhd)
This incructions performed [square root digit-by-digit binary numeral system (base 2)](https://en.wikipedia.org/wiki/Methods_of_computing_square_roots#Digit-by-digit_calculation) with the 9th register
and the result will be in 12th register (initalized register can be found in [registersfile](./MIPS_MULTICYCLE/registersfile.vhd))
MIPS code:
```assembly
	sll $8, $8, 30
loop1:
	slt $10, $9, $8     
	beq $10, $0 , loop2  #if input less then $8 then $10=1
	srl $8, $8, 2        #shift $8 by 2
	j to loop1
loop2:
	beq $8, $0, end      
	add $11, $12, $8     #if $8 != zero add $8 and $12 to $11
	slt $10, $9, $11
	beq $10, $0, else
	srl $12, $12, 1      #shift $12 right by 1
	j to loopEnd
else:
	sub $9, $9, $11      #decrement $9 by $11
	srl $12, $12, 1      #shift $12 right by 1
	add $12, $12, $8     #then add $8 to $12
loopEnd:
	srl $8, $8, 2        #shift $8 right by 2
	j loop2
	add $2, $1, $1       #(checks add)
```

C code:
```C
sqrt (int input)
{
	int b = 0, output = 0;
	int tmp = pow(2,30);  # 2^30
	while (tmp >= input)
	{
		tmp = tmp / 4; shift right by 2
	}
	while (tmp != 0)
	{
		b = output + tmp;
		if(input >= b)
		{
			input = input - b;
			output = output / 2;
			output = output + tmp;
		}
		else
		{
			output = output / 4;
		}
		tmp = tmp / 4;
	}
	return output
}
```
## Supported instructions:
### R-type (ALU)
* ALU (add, sub, and, or)
* Set less than (slt)
* Shift right logical (srl)
* Shift left logical  (sll)

|0|rs|rt|rd|shamt|function|
|-|--|--|--|-----|--------|
|31-26|25-21|20-16|15-11|10-6|5-0|

#### function types

|Arith Operation|add|sub|and|or|slt|sll|srl|
|---------------|---|---|---|--|---|---|---|
|function|32|34|36|37|42|0|2|

### I-type
* Store word (sw)
* Load word  (lw)
* Branch on equal (beq)

|op|rs|rt|address|
|--|--|--|-------|
|31-26|25-21|20-16|15-0|

#### op code types

|Operation|beq|lw|sw|
|---------|---|--|--|
|opCode|4|35|43|

### Jump
* jump (j)

|2|address|
|-|-------|
|31-26|25-0|

## FSM moore
![Picture2](https://user-images.githubusercontent.com/69726708/100780489-714f2500-3412-11eb-81ad-a56b6e2bf482.png)

