.equ SWI_Timer, 0x6d @ Gets current time 
.equ Sec1, 10000 @ 10 seconds interval
.equ Point1Sec, 100 @ 0.1 seconds interval

.global _start
.text

_start:

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


Exit:
swi 0x11 @ stop executing

