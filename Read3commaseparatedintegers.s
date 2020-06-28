.equ SWI_Open, 0x66 @open file
.equ SWI_Close, 0x68 @close file
.equ SWI_Exit, 0x11 @EXIT
.equ SWI_PrStr, 0x69 @Write String to file
.equ SWI_RdInt, 0x6c @Read Int from file
.equ SWI_RdStr, 0x6a @Read String from file
.equ comma,0x2c
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
mov r2,#10
swi SWI_RdStr

ldr r5,=CharArray

Loop:
ldrb r2,[r5],#1
cmp r2,#0
beq EOF
cmp r2,#0x2c
beq NL
mov r0,r2
swi 0x00
bal Loop

NL:
mov r0,#'\n'
swi 0x00
bal Loop



EOF:
@Close the Infile 
ldr r0, =InFileHandle @ get address of file handle
ldr r0, [r0] @ get value at address
swi SWI_Close

Exit:
swi SWI_Exit @ stop executing

.data
.align
InFileHandle: .skip 4
CharArray: .word 80
InFileName: .asciz "integer_input.txt"
.end