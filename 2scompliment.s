LDR R0, =Word1 ; @load the address
LDR R1, [R0] ; @load the data
LDR R2, =0XFFFFFFFF ; @complement using this
EOR R1, R1, R2 ; @Exclusive OR
STR R1, [R0] ; @Store the result
LDR R0,[R0]
ADD R0,R0,#0x0000001
MOV R1,R0
MOV R0,#1
SWI 0x6b
SWI 0x11


.data
.align
Word1: .Word 0XFFFFFFFF ; @test data