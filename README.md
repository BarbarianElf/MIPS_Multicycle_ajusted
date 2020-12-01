# MIPS Multicycle 32 bit
An implementaiton of the MIPS multicycle processor 32bit using VHDL

![Picture1](https://user-images.githubusercontent.com/69726708/100778999-64c9cd00-3410-11eb-951b-e0cf526abd0a.png)

## MIPS instructions:
MIPS insructions stored in memoryfile which can be found in the file [memoryfile](./MIPS_MULTICYCLE/memoryfile.vhd)
This incructions performed square root digit-by-digit binary numeral system (base 2) with the 9th register
and the result will be in 12th register (initalized register can be found in [registersfile](./MIPS_MULTICYCLE/registersfile.vhd))
MIPS code:
```
sll $8, $8, 30
slt $10, $9, $8 (START OF loop1)
beq $10, $0 , loop2
srl $8, $8, 2
j to loop1
beq $8, $0, end (START OF loop2)
add $11, $12, $8
slt $10, $9, $11
beq $10, $0, else
srl $12, $12, 1
j to loopEnd
sub $9, $9, $11 (START OF else)
srl $12, $12, 1
add $12, $12, $8
srl $8, $8, 2 (START OF loopEnd)
j to loop2
add $2, $1, $1 (just for add)
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

