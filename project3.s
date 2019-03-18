; Programmer: Jorge Martinez
; Comp 122 - Project #3


.equ ZERO, 0x80|0x01|0x20|0x08|0x04|0x40
.equ ONE, 0x40|0x20
.equ TWO, 0x08|0x04|0x02|0x40|0x80
.equ THREE, 0x80|0x40|0x02|0x20|0x08
.equ FOUR, 0x02|0x40|0x01|0x20
.equ FIVE, 0x80|0x01|0x02|0x20|0x08
.equ SIX, 0x80|0x01|0x02|0x20|0x08|0x04
.equ SEVEN, 0x40|0x20|0x80
.equ EIGHT, 0x80|0x01|0x02|0x20|0x08|0x04|0x40
.equ NINE,  0x80|0x01|0x02|0x20|0x40
.equ ERROR, 0x80|0x01|0x02|0x04|0x08

start:

; clear the 8 segment display
	mov r0,#0
	swi 0x200

; clear the lcd screen put 0 in it
	swi 0x206

; reset counter to 0
	mov r9,#0 
	mov r0,#0
	mov r1,#0
	mov r2,r9
	swi 0x205

input:

; check if the black buttons were pressed
	swi 0x202
	cmp r0,#0x02
	beq start
	cmp r0,#0x01
	beq start

; check if any of the number buttons were pressed
	swi 0x203
	cmp r0,#0x01
	beq seven
	cmp r0,#0x02
	beq eight
	cmp r0,#0x04
	beq nine
	cmp r0,#0x10
	beq four
	cmp r0,#0x20
	beq five
	cmp r0,#0x40
	beq six
	cmp r0,#01<<8
	beq one
	cmp r0,#1<<9
	beq two
	cmp r0,#1<<10
	beq three
	cmp r0,#01<<13
	beq zero

; check if any of the unassigned buttons were pressed
	cmp r0,#0x08
	beq error
	cmp r0,#0x80
	beq error
	cmp r0,#1<<11
	beq error
	cmp r0,#1<<12
	beq error
	cmp r0,#1<<14
	beq error
	cmp r0,#1<<15
	beq error

; keep checking for input
	bal input

; when buttons are pressed

one:

	mov r0,#ONE
	swi 0x200
	add r9,r9,#1
	mov r0,#0
	mov r1,#0
	mov r2,r9
	swi 0x205
	bal input

two:

	mov r0,#TWO
	swi 0x200
	add r9,r9,#2
	mov r0,#0
	mov r1,#0
	mov r2,r9
	swi 0x205
	bal input

three:

	mov r0,#THREE
	swi 0x200
	add r9,r9,#3
	mov r0,#0
	mov r1,#0
	mov r2,r9
	swi 0x205
	bal input

four:

	mov r0,#FOUR
	swi 0x200
	add r9,r9,#4
	mov r0,#0
	mov r1,#0
	mov r2,r9
	swi 0x205
	bal input

five:

	mov r0,#FIVE
	swi 0x200
	add r9,r9,#5
	mov r0,#0
	mov r1,#0
	mov r2,r9
	swi 0x205
	bal input

six:

	mov r0,#SIX
	swi 0x200
	add r9,r9,#6
	mov r0,#0
	mov r1,#0
	mov r2,r9
	swi 0x205
	bal input

seven:

	mov r0,#SEVEN
	swi 0x200
	add r9,r9,#7
	mov r0,#0
	mov r1,#0
	mov r2,r9
	swi 0x205
	bal input

eight:

	mov r0,#EIGHT
	swi 0x200
	add r9,r9,#8
	mov r0,#0
	mov r1,#0
	mov r2,r9
	swi 0x205
	bal input

nine:

	mov r0,#NINE
	swi 0x200
	add r9,r9,#9
	mov r0,#0
	mov r1,#0
	mov r2,r9
	swi 0x205
	bal input

zero:

	mov r0,#ZERO
	swi 0x200
	add r9,r9,#0
	mov r0,#0
	mov r1,#0
	mov r2,r9
	swi 0x205
	bal input

; if not one of the programmed buttons

error:

	mov r0,#ERROR
	swi 0x200
	bal input
