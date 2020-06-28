mov r0,#5
mov r1,#7

loop:
teq r0,r1
beq endw
cmp r0,r1
ble else
sub r0,r0,r1
b loop

else:
sub r1,r1,r0
b loop

endw:
swi 0x11