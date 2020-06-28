.equ SWI_Timer, 0x6d @ Gets current time 
.equ Sec1, 1000 @ 1 seconds interval
.equ Point1Sec, 100 @ 0.1 seconds interval
.equ SWI_Exit,0x11
.global _start
.text


_start:
mov r3,#0
LED:
cmp r3,#30
bgt Exit
mov r0,	#0x02
swi 0x201
bl Wait
mov r0,#0x01
swi 0x201
bl Wait
adds r3,r3,#1
b LED



Wait:
ldr r2,=Point1Sec
swi SWI_Timer
mov r1,r0
WaitLoop:
swi SWI_Timer
subs r0,r0,r1
rsblt r0, r0, #0
cmp r0, r2
blt WaitLoop
bx lr
swi SWI_Exit



Exit:
swi SWI_Exit @ stop executing

.data
.align
InFileHandle: .skip 4
CharArray: .word 80
InFileName: .asciz "integer_input.txt"
.end