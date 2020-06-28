.equ SWI_Open, 0x66 @open file
.equ SWI_Close, 0x68 @close file
.equ SWI_Exit, 0x11 @EXIT
.equ SWI_PrStr, 0x69 @Write String to file
.global _start
.text

_start:
ldr r0,=OutFileName
mov r1,#1
swi SWI_Open
ldr r1,=OutFileHandle
str r0,[r1]

ldr r0,=OutFileHandle
ldr r0,[r0]
ldr r1,=Str_Out
swi SWI_PrStr

@Close the file
ldr R0, =OutFileHandle @ get address of file handle
ldr R0, [R0] @ get value at address
swi SWI_Close



Exit:
swi SWI_Exit @ stop executing

.data
.align
OutFileHandle: .skip 4
CharArray: .skip 80
OutFileName: .asciz "test_out.txt"
Str_Out: .asciz "Hello World!!"
.end