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
	push	{r0}
#3 Ending DECLARATION
#4 Starting ASSIGNMENT_STATEMENT
#5 Starting EXPRESSION of type NEW
	movw	r0, #:lower16:12
	movt	r0, #:upper16:12
	push	{r0}
	bl	_malloc
	pop	{r1}
	push	{r0}
	movw	r0, #:lower16:12
	movt	r0, #:upper16:12
	push	{r0}
	bl	_malloc
	pop	{r1}
	pop	{r1}
	str	r0, [r1]
	push	{r1}
	movw	r0, #:lower16:12
	movt	r0, #:upper16:12
	push	{r0}
	bl	_malloc
	pop	{r1}
	pop	{r1}
	str	r0, [r1, #4]
	push	{r1}
	movw	r0, #:lower16:12
	movt	r0, #:upper16:12
	push	{r0}
	bl	_malloc
	pop	{r1}
	pop	{r1}
	str	r0, [r1, #8]
	push	{r1}
	pop	{r0}
	push	{r0}
#6 Ending EXPRESSION of type NEW
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-4]
	mov	fp, r1
#7 End ASSIGNMENT_STATEMENT
#8 Starting DECLARATION: adding space on stack
	push	{r0}
#9 Ending DECLARATION
#10 Starting DECLARATION: adding space on stack
	push	{r0}
#11 Ending DECLARATION
#12 Starting FOR_STATEMENT
#13 Starting ASSIGNMENT_STATEMENT
#14 Starting CONSTANT
	movw	r0, #:lower16:0
	movt	r0, #:upper16:0
	push	{r0}
#15 End CONSTANT
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-8]
	mov	fp, r1
#16 End ASSIGNMENT_STATEMENT
_start_for_0:
#17 Starting CONSTANT
	movw	r0, #:lower16:3
	movt	r0, #:upper16:3
	push	{r0}
#18 End CONSTANT
	ldr	r2, [fp, #-8]
	pop	{r3}
	cmp	r2,r3
    bge _end_for_0
#19 Starting FOR_STATEMENT
#20 Starting ASSIGNMENT_STATEMENT
#21 Starting CONSTANT
	movw	r0, #:lower16:0
	movt	r0, #:upper16:0
	push	{r0}
#22 End CONSTANT
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-12]
	mov	fp, r1
#23 End ASSIGNMENT_STATEMENT
_start_for_1:
#24 Starting CONSTANT
	movw	r0, #:lower16:3
	movt	r0, #:upper16:3
	push	{r0}
#25 End CONSTANT
	ldr	r2, [fp, #-12]
	pop	{r3}
	cmp	r2,r3
    bge _end_for_1
#26 Starting ASSIGNMENT_STATEMENT
#27 Starting EXPRESSION of type +
#28 Starting EXPRESSION of type +
#29 Starting EXPRESSION of type *
#30 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-8]
	pop	{fp}
	push	{r0}
#31 End VARIABLE i, depth difference: 0, stack offset: -8
#32 Starting CONSTANT
	movw	r0, #:lower16:3
	movt	r0, #:upper16:3
	push	{r0}
#33 End CONSTANT
	pop	{r2}
	pop	{r1}
	mul	r1,r1,r2
	push	{r1}
#34 Ending EXPRESSION of type *
#35 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-12]
	pop	{fp}
	push	{r0}
#36 End VARIABLE j, depth difference: 0, stack offset: -12
	pop	{r2}
	pop	{r1}
	add	r1, r1, r2
	push	{r1}
#37 Ending EXPRESSION of type +
#38 Starting CONSTANT
	movw	r0, #:lower16:1
	movt	r0, #:upper16:1
	push	{r0}
#39 End CONSTANT
	pop	{r2}
	pop	{r1}
	add	r1, r1, r2
	push	{r1}
#40 Ending EXPRESSION of type +
#41 Starting EXPRESSION of type ARRAY_INDEX
#42 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-4]
	pop	{fp}
	push	{r0}
#43 End VARIABLE a, depth difference: 0, stack offset: -4
#44 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-8]
	pop	{fp}
	push	{r0}
#45 End VARIABLE i, depth difference: 0, stack offset: -8
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#46 Ending EXPRESSION of type ARRAY_INDEX
#47 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-12]
	pop	{fp}
	push	{r0}
#48 End VARIABLE j, depth difference: 0, stack offset: -12
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	pop	{r1}
	str	r1, [r0]
#49 End ASSIGNMENT_STATEMENT
	ldr	r2, [fp, #-12]
	mov	r3, #1
	add	r2, r2, r3
	str	r2, [fp, #-12]
	b	_start_for_1
_end_for_1:
#50 End FOR_STATEMENT
	ldr	r2, [fp, #-8]
	mov	r3, #1
	add	r2, r2, r3
	str	r2, [fp, #-8]
	b	_start_for_0
_end_for_0:
#51 End FOR_STATEMENT
#52 Starting DECLARATION: adding space on stack
	push	{r0}
#53 Ending DECLARATION
#54 Starting DECLARATION: adding space on stack
	push	{r0}
#55 Ending DECLARATION
#56 Starting ASSIGNMENT_STATEMENT
#57 Starting CONSTANT
	movw	r0, #:lower16:0
	movt	r0, #:upper16:0
	push	{r0}
#58 End CONSTANT
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-20]
	mov	fp, r1
#59 End ASSIGNMENT_STATEMENT
#60 Starting ASSIGNMENT_STATEMENT
#61 Starting CONSTANT
	movw	r0, #:lower16:1
	movt	r0, #:upper16:1
	push	{r0}
#62 End CONSTANT
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-16]
	mov	fp, r1
#63 End ASSIGNMENT_STATEMENT
#64 Starting FOR_STATEMENT
#65 Starting ASSIGNMENT_STATEMENT
#66 Starting CONSTANT
	movw	r0, #:lower16:0
	movt	r0, #:upper16:0
	push	{r0}
#67 End CONSTANT
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-8]
	mov	fp, r1
#68 End ASSIGNMENT_STATEMENT
_start_for_2:
#69 Starting CONSTANT
	movw	r0, #:lower16:3
	movt	r0, #:upper16:3
	push	{r0}
#70 End CONSTANT
	ldr	r2, [fp, #-8]
	pop	{r3}
	cmp	r2,r3
    bge _end_for_2
#71 Starting FOR_STATEMENT
#72 Starting ASSIGNMENT_STATEMENT
#73 Starting CONSTANT
	movw	r0, #:lower16:0
	movt	r0, #:upper16:0
	push	{r0}
#74 End CONSTANT
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-12]
	mov	fp, r1
#75 End ASSIGNMENT_STATEMENT
_start_for_3:
#76 Starting CONSTANT
	movw	r0, #:lower16:3
	movt	r0, #:upper16:3
	push	{r0}
#77 End CONSTANT
	ldr	r2, [fp, #-12]
	pop	{r3}
	cmp	r2,r3
    bge _end_for_3
#78 Starting ASSIGNMENT_STATEMENT
#79 Starting EXPRESSION of type *
#80 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-16]
	pop	{fp}
	push	{r0}
#81 End VARIABLE prod, depth difference: 0, stack offset: -16
#82 Starting EXPRESSION of type ARRAY_INDEX
#83 Starting EXPRESSION of type ARRAY_INDEX
#84 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-4]
	pop	{fp}
	push	{r0}
#85 End VARIABLE a, depth difference: 0, stack offset: -4
#86 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-8]
	pop	{fp}
	push	{r0}
#87 End VARIABLE i, depth difference: 0, stack offset: -8
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#88 Ending EXPRESSION of type ARRAY_INDEX
#89 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-12]
	pop	{fp}
	push	{r0}
#90 End VARIABLE j, depth difference: 0, stack offset: -12
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#91 Ending EXPRESSION of type ARRAY_INDEX
	pop	{r2}
	pop	{r1}
	mul	r1,r1,r2
	push	{r1}
#92 Ending EXPRESSION of type *
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-16]
	mov	fp, r1
#93 End ASSIGNMENT_STATEMENT
#94 Starting ASSIGNMENT_STATEMENT
#95 Starting EXPRESSION of type +
#96 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-20]
	pop	{fp}
	push	{r0}
#97 End VARIABLE sum, depth difference: 0, stack offset: -20
#98 Starting EXPRESSION of type ARRAY_INDEX
#99 Starting EXPRESSION of type ARRAY_INDEX
#100 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-4]
	pop	{fp}
	push	{r0}
#101 End VARIABLE a, depth difference: 0, stack offset: -4
#102 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-8]
	pop	{fp}
	push	{r0}
#103 End VARIABLE i, depth difference: 0, stack offset: -8
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#104 Ending EXPRESSION of type ARRAY_INDEX
#105 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-12]
	pop	{fp}
	push	{r0}
#106 End VARIABLE j, depth difference: 0, stack offset: -12
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#107 Ending EXPRESSION of type ARRAY_INDEX
	pop	{r2}
	pop	{r1}
	add	r1, r1, r2
	push	{r1}
#108 Ending EXPRESSION of type +
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-20]
	mov	fp, r1
#109 End ASSIGNMENT_STATEMENT
	ldr	r2, [fp, #-12]
	mov	r3, #1
	add	r2, r2, r3
	str	r2, [fp, #-12]
	b	_start_for_3
_end_for_3:
#110 End FOR_STATEMENT
	ldr	r2, [fp, #-8]
	mov	r3, #1
	add	r2, r2, r3
	str	r2, [fp, #-8]
	b	_start_for_2
_end_for_2:
#111 End FOR_STATEMENT
#112 Starting PRINT_STATEMENT
	push	{r6}
	pop	{r6}
#113 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-20]
	pop	{fp}
	push	{r0}
#114 End VARIABLE sum, depth difference: 0, stack offset: -20
	movw	r0, #:lower16:.INTEGER
	movt	r0, #:upper16:.INTEGER
	pop	{r1}
	bl	printf
#115 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-16]
	pop	{fp}
	push	{r0}
#116 End VARIABLE prod, depth difference: 0, stack offset: -16
	movw	r0, #:lower16:.INTEGER
	movt	r0, #:upper16:.INTEGER
	pop	{r1}
	bl	printf
	movw	r0, #:lower16:0x0A
	movt	r0, #:upper16:0x0A
	bl	putchar
#117 Ending PRINT_STATEMENT
	mov	sp, fp
	pop	{fp}
	pop	{pc}
#118 Leaving FUNCTION (main) with depth 2
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
#119 End PROGRAM
	mov	sp, fp
	pop	{fp}
	bl	exit
.end
