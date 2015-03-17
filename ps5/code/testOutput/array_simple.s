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
#1 Starting FUNCTION (arrayTest) with depth 2
_arrayTest:
	push	{lr}
	push	{fp}
	mov	fp, sp
#2 Starting DECLARATION: adding space on stack
	push	{r1}
#3 Ending DECLARATION
#4 Starting DECLARATION: adding space on stack
	push	{r1}
#5 Ending DECLARATION
#6 Starting ASSIGNMENT_STATEMENT
#7 Starting CONSTANT
	movw	r1, #:lower16:66
	movt	r1, #:upper16:66
	push	{r1}
#8 End CONSTANT
	pop	{r4}
	str	r4, [fp, #-4]
#9 End ASSIGNMENT_STATEMENT
#10 Starting ASSIGNMENT_STATEMENT
#11 Starting CONSTANT
	movw	r1, #:lower16:44
	movt	r1, #:upper16:44
	push	{r1}
#12 End CONSTANT
	pop	{r4}
	str	r4, [fp, #-8]
#13 End ASSIGNMENT_STATEMENT
#14 Starting DECLARATION: adding space on stack
	push	{r1}
#15 Ending DECLARATION
#16 Starting ASSIGNMENT_STATEMENT
#17 Starting EXPRESSION of type NEW
	movw	r1, #:lower16:8
	movt	r1, #:upper16:8
	push	{r1}
	bl	_malloc
	mov	r1, #4
	add	sp, sp, r1
	push	{r0}
#18 Ending EXPRESSION of type NEW
	pop	{r4}
	str	r4, [fp, #-12]
#19 End ASSIGNMENT_STATEMENT
#20 Starting ASSIGNMENT_STATEMENT
#21 Starting VARIABLE
	ldr	r1, [fp, #-4]
	push	{r1}
#22 End VARIABLE a, depth difference: 0, stack offset: -4
	pop	{r4}
#23 Starting VARIABLE
	ldr	r1, [fp, #-12]
	push	{r1}
#24 End VARIABLE array, depth difference: 0, stack offset: -12
#25 Starting CONSTANT
	movw	r1, #:lower16:0
	movt	r1, #:upper16:0
	push	{r1}
#26 End CONSTANT
	pop	{r2}
	pop	{r1}
	mov	r3, #4
	mul	r2,r2,r3
	add	r1, r1, r2
	str	r4, [r1]
#27 End ASSIGNMENT_STATEMENT
#28 Starting ASSIGNMENT_STATEMENT
#29 Starting VARIABLE
	ldr	r1, [fp, #-8]
	push	{r1}
#30 End VARIABLE b, depth difference: 0, stack offset: -8
	pop	{r4}
#31 Starting VARIABLE
	ldr	r1, [fp, #-12]
	push	{r1}
#32 End VARIABLE array, depth difference: 0, stack offset: -12
#33 Starting CONSTANT
	movw	r1, #:lower16:1
	movt	r1, #:upper16:1
	push	{r1}
#34 End CONSTANT
	pop	{r2}
	pop	{r1}
	mov	r3, #4
	mul	r2,r2,r3
	add	r1, r1, r2
	str	r4, [r1]
#35 End ASSIGNMENT_STATEMENT
#36 Starting PRINT_STATEMENT
	push	{r6}
	pop	{r6}
#37 Starting EXPRESSION of type ARRAY_INDEX
#38 Starting VARIABLE
	ldr	r1, [fp, #-12]
	push	{r1}
#39 End VARIABLE array, depth difference: 0, stack offset: -12
#40 Starting CONSTANT
	movw	r1, #:lower16:0
	movt	r1, #:upper16:0
	push	{r1}
#41 End CONSTANT
	pop	{r2}
	pop	{r1}
	mov	r3, #4
	mul	r2,r2,r3
	add	r1, r1, r2
	ldr	r1, [r1]
	push	{r1}
#42 Ending EXPRESSION of type ARRAY_INDEX
	movw  r0, #:lower16:.INTEGER
	movt  r0, #:upper16:.INTEGER
	pop	{r1}
	bl	printf
#43 Starting EXPRESSION of type ARRAY_INDEX
#44 Starting VARIABLE
	ldr	r1, [fp, #-12]
	push	{r1}
#45 End VARIABLE array, depth difference: 0, stack offset: -12
#46 Starting CONSTANT
	movw	r1, #:lower16:1
	movt	r1, #:upper16:1
	push	{r1}
#47 End CONSTANT
	pop	{r2}
	pop	{r1}
	mov	r3, #4
	mul	r2,r2,r3
	add	r1, r1, r2
	ldr	r1, [r1]
	push	{r1}
#48 Ending EXPRESSION of type ARRAY_INDEX
	movw  r0, #:lower16:.INTEGER
	movt  r0, #:upper16:.INTEGER
	pop	{r1}
	bl	printf
	movw	r0, #:lower16:0x0A
	movt	r0, #:upper16:0x0A
	bl	putchar
#49 Ending PRINT_STATEMENT
	mov	sp, fp
	pop	{fp}
	pop	{pc}
#50 Leaving FUNCTION (arrayTest) with depth 2
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
	bl	_arrayTest
#51 End PROGRAM
	mov	sp, fp
	pop	{fp}
	bl	exit
.end
