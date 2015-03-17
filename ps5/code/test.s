.syntax unified
.cpu cortex-a15
.fpu vfpv3-d16
.data
.align	2
.DEBUG: .ascii "Hit Debug\n\000"
.DEBUGINT: .ascii "Hit Debug, r0 was: %d\n\000"
.INTEGER: .ascii "%d \000"
.FLOAT: .ascii "%f \000"
.NEWLINE: .ascii "\n \000"
.globl main
.align	2
.text
#0 Starting PROGRAM
#1 Starting FUNCTION (main) with depth 2
_main:
	push	{lr}
	push	{fp}
	mov	fp, sp
#2 Starting DECLARATION: adding space on stack
	push	{r1}
#3 Ending DECLARATION
#4 Starting ASSIGNMENT_STATEMENT
#5 Starting EXPRESSION of type NEW
	movw	r1, #:lower16:8
	movt	r1, #:upper16:8
	push	{r1}
	bl	_malloc
	push	{r0}
	movw	r1, #:lower16:8
	movt	r1, #:upper16:8
	push	{r1}
	bl	_malloc
	push	{r0}
	pop	{r2}
	pop	{r1}
	mov	r4, #0
	mov	r5, #4
	mul	r3,r4,r5
	add	r3, r1, r3
	str	r2, [r3]
	push	{r1}
	movw	r1, #:lower16:8
	movt	r1, #:upper16:8
	push	{r1}
	bl	_malloc
	push	{r0}
	pop	{r2}
	pop	{r1}
	mov	r4, #1
	mov	r5, #4
	mul	r3,r4,r5
	add	r3, r1, r3
	str	r2, [r3]
	push	{r1}
#6 Ending EXPRESSION of type NEW
	pop	{r4}
	str	r4, [fp, #-4]
#7 End ASSIGNMENT_STATEMENT
#8 Starting ASSIGNMENT_STATEMENT
#9 Starting CONSTANT
	movw	r1, #:lower16:4
	movt	r1, #:upper16:4
	push	{r1}
#10 End CONSTANT
	pop	{r4}
#11 Starting EXPRESSION of type ARRAY_INDEX
#12 Starting VARIABLE
	ldr	r1, [fp, #-4]
	push	{r1}
#13 End VARIABLE b, depth difference: 0, stack offset: -4
#14 Starting CONSTANT
	movw	r1, #:lower16:1
	movt	r1, #:upper16:1
	push	{r1}
#15 End CONSTANT
	pop	{r2}
	pop	{r1}
	mov	r3, #4
	mul	r2,r2,r3
	add	r1, r1, r2
	ldr	r1, [r1]
	push	{r1}
#16 Ending EXPRESSION of type ARRAY_INDEX
#17 Starting CONSTANT
	movw	r1, #:lower16:2
	movt	r1, #:upper16:2
	push	{r1}
#18 End CONSTANT
	pop	{r2}
	pop	{r1}
	mov	r3, #4
	mul	r2,r2,r3
	add	r1, r1, r2
	str	r4, [r1]
#19 End ASSIGNMENT_STATEMENT
#20 Starting PRINT_STATEMENT
	push	{r6}
	pop	{r6}
#21 Starting EXPRESSION of type ARRAY_INDEX
#22 Starting EXPRESSION of type ARRAY_INDEX
#23 Starting VARIABLE
	ldr	r1, [fp, #-4]
	push	{r1}
#24 End VARIABLE b, depth difference: 0, stack offset: -4
#25 Starting CONSTANT
	movw	r1, #:lower16:1
	movt	r1, #:upper16:1
	push	{r1}
#26 End CONSTANT
	pop	{r2}
	pop	{r1}
	mov	r3, #4
	mul	r2,r2,r3
	add	r1, r1, r2
	ldr	r1, [r1]
	push	{r1}
#27 Ending EXPRESSION of type ARRAY_INDEX
#28 Starting CONSTANT
	movw	r1, #:lower16:2
	movt	r1, #:upper16:2
	push	{r1}
#29 End CONSTANT
	pop	{r2}
	pop	{r1}
	mov	r3, #4
	mul	r2,r2,r3
	add	r1, r1, r2
	ldr	r1, [r1]
	push	{r1}
#30 Ending EXPRESSION of type ARRAY_INDEX
	movw  r0, #:lower16:.INTEGER
	movt  r0, #:upper16:.INTEGER
	pop	{r1}
	bl	printf
	movw	r0, #:lower16:0x0A
	movt	r0, #:upper16:0x0A
	bl	putchar
#31 Ending PRINT_STATEMENT
	mov	sp, fp
	pop	{fp}
	pop	{pc}
#32 Leaving FUNCTION (main) with depth 2
debugprint:
	push {r0-r11, lr}
	movw	r0, #:lower16:.DEBUG
	movt	r0, #:upper16:.DEBUG
	bl	printf
	pop {r0-r11, pc}
debugprint_r0:
	push {r0-r11, lr}
	mov	r1, r0
	movw	r0, #:lower16:.DEBUGINT
	movt	r0, #:upper16:.DEBUGINT
	bl	printf
	pop {r0-r11, pc}
_malloc:
	push	{lr}
	push	{fp}
	ldr	r0, [sp, #8]
	bl	malloc
	pop	{fp}
	pop {pc}
main:
	push	{lr}
	push	{fp}
	mov	fp, sp
	mov	r5, r0
	sub	r5, r5, #1
	cmp	r5,#0
	beq	noargs
	mov	r6, r1
pusharg:
	ldr	r0, [r6, #4]
	add	r6, r6, #4
	mov	r1, #0
	mov	r2, #10
	bl	strtol
	push	{r0}
	sub	r5, r5, #1
	cmp	r5,#0
	bne	pusharg
noargs:
	bl	_main
#33 End PROGRAM
	mov	sp, fp
	pop	{fp}
	bl	exit
.end
