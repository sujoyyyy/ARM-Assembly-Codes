mov r0,#5
mov r1,#1
mov r2,#1
Loop:
cmp r1,r0
bge end
mul r3,r2,r1
mov r2,r3
add r1,r1,#1
b Loop

end:
mul r2,r3,r0
mov r1,r2
mov r0,#1
swi 0x6b
swi 0x11