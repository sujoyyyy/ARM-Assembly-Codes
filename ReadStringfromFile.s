.equ SWI_Open, 0x66 @open file
.equ SWI_Close, 0x68 @close file
.equ SWI_Exit, 0x11 @EXIT
.global _start
.text

_start:

ldr r0,=InFileName
mov r1,#0
swi SWI_Open
ldr r1,=InFileHandle
str r0,[r1]

ldr r0,=InFileHandle
ldr r0,[r0]
ldr r1,=CharArray
mov r2,#80
swi 0x6a

ldr r0,=CharArray
swi 0x02



@Close the file
ldr R0, =InFileHandle @ get address of file handle
ldr R0, [R0] @ get value at address
swi SWI_Close

Exit:
swi SWI_Exit @ stop executing

.data
.align
InFileHandle: .skip 4
CharArray: .skip 80
InFileName: .asciz "test_out.txt"
.end
