# MIPS Multicycle 32 bit
An implementaiton of the MIPS multicycle processor 32bit using VHDL
PIC

## MIPS instructions:
MIPS insructions can be found in the file memoryfile.vhd
## Supported instructions:
### R-type (ALU)
* ALU (add, sub, and, or, slt, sll, srl)

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
