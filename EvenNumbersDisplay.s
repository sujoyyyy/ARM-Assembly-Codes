.equ SWI_Timer, 0x6d @ Gets current time 
.equ Sec1, 1000 @ 1 seconds interval
.equ Point1Sec, 100 @ 0.1 seconds interval
.equ SWI_Exit,0x11
.equ SEG_A,0x80
.equ SEG_B,0x40
.equ SEG_C,0x20
.equ SEG_D,0x08
.equ SEG_E,0x04
.equ SEG_F,0x02
.equ SEG_G,0x01
.equ SEG_P,0x10

.global _start
.text

_start:

LED:
ldr r2,=Digits
ldr r0,[r2,r3,lsl#2]

swi 0x200
bl Wait
add r3,r3,#2
cmp r3,#10
subeq r3,r3,#10 
bal LED

Wait:
ldr r2,=Sec1
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
Digits:
.word	SEG_A|SEG_B|SEG_C|SEG_D|SEG_E|SEG_G @0
.word	SEG_B|SEG_C@1
.word	SEG_A|SEG_B|SEG_D|SEG_E|SEG_F @2
.word	SEG_A|SEG_B|SEG_C|SEG_D|SEG_F @3
.word	SEG_B|SEG_C|SEG_F|SEG_G @4
.word	SEG_A|SEG_G|SEG_F|SEG_C|SEG_D @5
.word	SEG_A|SEG_G|SEG_E|SEG_D|SEG_C|SEG_F @6
.word	SEG_A|SEG_B|SEG_C @7
.word	SEG_A|SEG_B|SEG_C|SEG_D|SEG_E|SEG_F|SEG_G @8
.word	SEG_A|SEG_B|SEG_C|SEG_D|SEG_F|SEG_G @8
.word 0 @ Blank Display
.end