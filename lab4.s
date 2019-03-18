.equ SEG_A,0x80
.equ SEG_B,0x40 
.equ SEG_C,0x20 
.equ SEG_D,0x08 
.equ SEG_E,0x04 
.equ SEG_F,0x02 
.equ SEG_G,0x01 
.equ SEG_P,0x10

.equ SIX, SEG_A|SEG_G|SEG_F|SEG_E|SEG_D|SEG_C
.equ F, SEG_A|SEG_G|SEG_F|SEG_E

mov r0,#0x10 ; segment p
swi 0x200 ; light up 8-segment display

mov r0,#0x02 ; segment f
swi 0x200

mov r0,#SIX
swi 0x200

mov r0,#F
swi 0x200

mov r0,#5
mov r1,#3
ldr r2,=myString

swi 0x204 ; print string on LCD

mov r0,#5
mov r1,#2
mov r2,#27

swi 0x205 ; print number on LCD

mov r0,#0x01
swi 0x201 ; light up LED

mov r0,#0x02
swi 0x201

mov r0,#0x03
swi 0x201

Loop:

swi 0x202 ; check if a black button was pressed
cmp r0,#0x02 ; left button
moveq r1,#0x4C ; 'L'
cmp r0,#0x01 ; right button
moveq r1,#0x52 ; 'R'

swi 0x203 ; checkout if a blue button was pressed
cmp r0,#0x8000 ; button 3,3
beq Done

BAL Loop
Done:

swi 0x11

myString: .asciz "twenty-seven"