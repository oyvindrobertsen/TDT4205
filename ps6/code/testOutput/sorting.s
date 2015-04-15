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
#4 Starting DECLARATION: adding space on stack
	push	{r0}
#5 Ending DECLARATION
#6 Starting ASSIGNMENT_STATEMENT
#7 Starting EXPRESSION of type NEW
	movw	r0, #:lower16:40
	movt	r0, #:upper16:40
	push	{r0}
	bl	_malloc
	pop	{r1}
	push	{r0}
#8 Ending EXPRESSION of type NEW
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-4]
	mov	fp, r1
#9 End ASSIGNMENT_STATEMENT
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
	str	r0, [fp, #-12]
	mov	fp, r1
#16 End ASSIGNMENT_STATEMENT
_start_for_0:
#17 Starting CONSTANT
	movw	r0, #:lower16:10
	movt	r0, #:upper16:10
	push	{r0}
#18 End CONSTANT
	ldr	r2, [fp, #-12]
	pop	{r3}
	cmp	r2,r3
    bge _end_for_0
#19 Starting ASSIGNMENT_STATEMENT
#20 Starting EXPRESSION of type -
#21 Starting CONSTANT
	movw	r0, #:lower16:10
	movt	r0, #:upper16:10
	push	{r0}
#22 End CONSTANT
#23 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-12]
	pop	{fp}
	push	{r0}
#24 End VARIABLE i, depth difference: 0, stack offset: -12
	pop	{r2}
	pop	{r1}
	sub	r1, r1, r2
	push	{r1}
#25 Ending EXPRESSION of type -
#26 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-4]
	pop	{fp}
	push	{r0}
#27 End VARIABLE a, depth difference: 0, stack offset: -4
#28 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-12]
	pop	{fp}
	push	{r0}
#29 End VARIABLE i, depth difference: 0, stack offset: -12
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	pop	{r1}
	str	r1, [r0]
#30 End ASSIGNMENT_STATEMENT
	ldr	r2, [fp, #-12]
	mov	r3, #1
	add	r2, r2, r3
	str	r2, [fp, #-12]
	b	_start_for_0
_end_for_0:
#31 End FOR_STATEMENT
#32 Starting ASSIGNMENT_STATEMENT
#33 Starting EXPRESSION of type FUNC_CALL
#34 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-4]
	pop	{fp}
	push	{r0}
#35 End VARIABLE a, depth difference: 0, stack offset: -4
	bl	_sort
	add	sp, sp, $4
	push	{r0}
#36 Ending EXPRESSION of type (null)
#37 Ending EXPRESSION of type FUNC_CALL
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-8]
	mov	fp, r1
#38 End ASSIGNMENT_STATEMENT
#39 Starting FOR_STATEMENT
#40 Starting ASSIGNMENT_STATEMENT
#41 Starting CONSTANT
	movw	r0, #:lower16:0
	movt	r0, #:upper16:0
	push	{r0}
#42 End CONSTANT
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-12]
	mov	fp, r1
#43 End ASSIGNMENT_STATEMENT
_start_for_1:
#44 Starting CONSTANT
	movw	r0, #:lower16:10
	movt	r0, #:upper16:10
	push	{r0}
#45 End CONSTANT
	ldr	r2, [fp, #-12]
	pop	{r3}
	cmp	r2,r3
    bge _end_for_1
#46 Starting PRINT_STATEMENT
	push	{r6}
	pop	{r6}
#47 Starting EXPRESSION of type ARRAY_INDEX
#48 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-8]
	pop	{fp}
	push	{r0}
#49 End VARIABLE b, depth difference: 0, stack offset: -8
#50 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-12]
	pop	{fp}
	push	{r0}
#51 End VARIABLE i, depth difference: 0, stack offset: -12
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#52 Ending EXPRESSION of type ARRAY_INDEX
	movw	r0, #:lower16:.INTEGER
	movt	r0, #:upper16:.INTEGER
	pop	{r1}
	bl	printf
	movw	r0, #:lower16:0x0A
	movt	r0, #:upper16:0x0A
	bl	putchar
#53 Ending PRINT_STATEMENT
	ldr	r2, [fp, #-12]
	mov	r3, #1
	add	r2, r2, r3
	str	r2, [fp, #-12]
	b	_start_for_1
_end_for_1:
#54 End FOR_STATEMENT
	mov	sp, fp
	pop	{fp}
	pop	{pc}
#55 Leaving FUNCTION (main) with depth 2
#56 Starting FUNCTION (sort) with depth 2
_sort:
	push	{lr}
	push	{fp}
	mov	fp, sp
#57 Starting DECLARATION: adding space on stack
	push	{r0}
#58 Ending DECLARATION
#59 Starting DECLARATION: adding space on stack
	push	{r0}
#60 Ending DECLARATION
#61 Starting DECLARATION: adding space on stack
	push	{r0}
#62 Ending DECLARATION
#63 Starting FOR_STATEMENT
#64 Starting ASSIGNMENT_STATEMENT
#65 Starting CONSTANT
	movw	r0, #:lower16:0
	movt	r0, #:upper16:0
	push	{r0}
#66 End CONSTANT
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-4]
	mov	fp, r1
#67 End ASSIGNMENT_STATEMENT
_start_for_2:
#68 Starting CONSTANT
	movw	r0, #:lower16:10
	movt	r0, #:upper16:10
	push	{r0}
#69 End CONSTANT
	ldr	r2, [fp, #-4]
	pop	{r3}
	cmp	r2,r3
    bge _end_for_2
#70 Starting FOR_STATEMENT
#71 Starting ASSIGNMENT_STATEMENT
#72 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-4]
	pop	{fp}
	push	{r0}
#73 End VARIABLE i, depth difference: 0, stack offset: -4
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-8]
	mov	fp, r1
#74 End ASSIGNMENT_STATEMENT
_start_for_3:
#75 Starting CONSTANT
	movw	r0, #:lower16:10
	movt	r0, #:upper16:10
	push	{r0}
#76 End CONSTANT
	ldr	r2, [fp, #-8]
	pop	{r3}
	cmp	r2,r3
    bge _end_for_3
#77 Starting IF_STATEMENT'
#78 Starting EXPRESSION of type <
#79 Starting EXPRESSION of type ARRAY_INDEX
#80 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #8]
	pop	{fp}
	push	{r0}
#81 End VARIABLE a, depth difference: 0, stack offset: 8
#82 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-8]
	pop	{fp}
	push	{r0}
#83 End VARIABLE j, depth difference: 0, stack offset: -8
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#84 Ending EXPRESSION of type ARRAY_INDEX
#85 Starting EXPRESSION of type ARRAY_INDEX
#86 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #8]
	pop	{fp}
	push	{r0}
#87 End VARIABLE a, depth difference: 0, stack offset: 8
#88 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-4]
	pop	{fp}
	push	{r0}
#89 End VARIABLE i, depth difference: 0, stack offset: -4
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#90 Ending EXPRESSION of type ARRAY_INDEX
	pop	{r3}
	pop	{r2}
	mov	r1, #0
	cmp	r2,r3
	movlt	 r1, #1
	push	{r1}
#91 Ending EXPRESSION of type <
	mov	r1, #0
	pop	{r2}
	cmp	r1,r2
	beq	_if_0
#92 Starting ASSIGNMENT_STATEMENT
#93 Starting EXPRESSION of type ARRAY_INDEX
#94 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #8]
	pop	{fp}
	push	{r0}
#95 End VARIABLE a, depth difference: 0, stack offset: 8
#96 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-4]
	pop	{fp}
	push	{r0}
#97 End VARIABLE i, depth difference: 0, stack offset: -4
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#98 Ending EXPRESSION of type ARRAY_INDEX
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-12]
	mov	fp, r1
#99 End ASSIGNMENT_STATEMENT
#100 Starting ASSIGNMENT_STATEMENT
#101 Starting EXPRESSION of type ARRAY_INDEX
#102 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #8]
	pop	{fp}
	push	{r0}
#103 End VARIABLE a, depth difference: 0, stack offset: 8
#104 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-8]
	pop	{fp}
	push	{r0}
#105 End VARIABLE j, depth difference: 0, stack offset: -8
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#106 Ending EXPRESSION of type ARRAY_INDEX
#107 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #8]
	pop	{fp}
	push	{r0}
#108 End VARIABLE a, depth difference: 0, stack offset: 8
#109 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-4]
	pop	{fp}
	push	{r0}
#110 End VARIABLE i, depth difference: 0, stack offset: -4
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	pop	{r1}
	str	r1, [r0]
#111 End ASSIGNMENT_STATEMENT
#112 Starting ASSIGNMENT_STATEMENT
#113 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-12]
	pop	{fp}
	push	{r0}
#114 End VARIABLE temp, depth difference: 0, stack offset: -12
#115 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #8]
	pop	{fp}
	push	{r0}
#116 End VARIABLE a, depth difference: 0, stack offset: 8
#117 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-8]
	pop	{fp}
	push	{r0}
#118 End VARIABLE j, depth difference: 0, stack offset: -8
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	pop	{r1}
	str	r1, [r0]
#119 End ASSIGNMENT_STATEMENT
_if_0:
#120 End IF_STATEMENT
	ldr	r2, [fp, #-8]
	mov	r3, #1
	add	r2, r2, r3
	str	r2, [fp, #-8]
	b	_start_for_3
_end_for_3:
#121 End FOR_STATEMENT
	ldr	r2, [fp, #-4]
	mov	r3, #1
	add	r2, r2, r3
	str	r2, [fp, #-4]
	b	_start_for_2
_end_for_2:
#122 End FOR_STATEMENT
#123 Starting RETURN_STATEMENT
#124 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #8]
	pop	{fp}
	push	{r0}
#125 End VARIABLE a, depth difference: 0, stack offset: 8
	pop	{r0}
	mov	sp, fp
	pop	{fp}
	pop	{pc}
#126 End RETURN_STATEMENT
	mov	sp, fp
	pop	{fp}
	pop	{pc}
#127 Leaving FUNCTION (sort) with depth 2
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
#128 End PROGRAM
	mov	sp, fp
	pop	{fp}
	bl	exit
.end
