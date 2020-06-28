mov r0,#3
mov r1,#5
cmp r0,r1
ble else
mov r2,r0
b   endif

else:
mov r2,r1

endif:
swi 0x11