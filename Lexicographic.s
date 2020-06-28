.equ SWI_Open, 0x66 @open file
.equ SWI_Close, 0x68 @close file
.equ SWI_Exit, 0x11 @EXIT
.equ SWI_PrStr, 0x69 @Write String to file
.equ SWI_RdInt, 0x6c @Read Int from file
.equ SWI_RdStr, 0x6a @Read String from file
.global _start
.text

_start:

@Open File
ldr r0,=InFileName
mov r1,#0
swi SWI_Open
ldr r1,=InFileHandle
str r0,[r1]

@Read string_1
ldr r0,=InFileHandle
ldr r0,[r0]
ldr r1,=string_1
mov r2,#100
swi SWI_RdStr

@Read string_2
ldr r0,=InFileHandle
ldr r0,[r0]
ldr r1,=string_2
mov r2,#100
swi SWI_RdStr

/*
@Find Length of both the Strings
@------------------------------@
FindLength:
mov r4,#0					@r4 contains length of string_1	=> L1
mov r5,#0					@r5 contains length of string_2 => L2
ldr r0,=string_1			@load addresses of strings into r0,r1
ldr r1,=string_2	
Count_Loop:		
ldrb r2,[r0],#1
ldrb r3,[r1],#1
cmp r2,#0					@chk if string_1 has reached end
addne r4,r4,#1				@if not end, add to length
cmp r3,#0					@chk if string_2 has reached end
addne r5,r5,#1
adds r2,r2,r3				@set zero bit both strings have reached end
bne Count_Loop
*/

@TO PRINT : (string_1) is [equal to]/[less than]/[greater than] (string_2)
PRINT_STRING_1:
ldr r0,=string_1
swi 0x02

Compare:					@ Check Lexographic Equality
ldr r0,=string_1			@load addresses of strings into r0,r1
ldr r1,=string_2
Compare_Loop:
ldrb r2,[r0],#1
ldrb r3,[r1],#1
cmp r2,r3
bgt greaterThan
blt lessThan
cmp r2,#0					@Check end of string
bne	Compare_Loop

@Print Output if string_1 equalTo string_2
ldr r0,=str_eq
swi 0x02
bal PRINT_STRING_2

greaterThan:
@Print Output if string_1 greater than string_2
ldr r0,=str_gt
swi 0x02
bal PRINT_STRING_2

lessThan:
@Print Output if string_1 less than string_2
ldr r0,=str_lt
swi 0x02
bal PRINT_STRING_2

PRINT_STRING_2:
ldr r0,=string_2
swi 0x02

EOF:
@Close the Infile 
ldr r0, =InFileHandle @ get address of file handle
ldr r0, [r0] @ get value at address
swi SWI_Close

Exit:
swi SWI_Exit @ stop executing

.data
.align 8
string_2: .skip 100
string_1: .skip 100
InFileHandle: .skip 4
InFileName: .asciz "compareString_input.txt"
str_gt: .asciz " is greater than "
str_lt: .asciz " is less than "
str_eq: .asciz " is equal to "
.end