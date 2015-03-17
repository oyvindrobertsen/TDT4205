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
	movw	r1, #:lower16:12
	movt	r1, #:upper16:12
	push	{r1}
	bl	_malloc
	mov	r1, #4
	add	sp, sp, r1
	push	{r0}
	movw	r1, #:lower16:12
	movt	r1, #:upper16:12
	push	{r1}
	bl	_malloc
	mov	r1, #4
	add	sp, sp, r1
	push	{r0}
	pop	{r2}
	pop	{r1}
	mov	r4, #0
	mov	r5, #4
	mul	r3,r4,r5
	add	r3, r1, r3
	str	r2, [r3]
	push	{r1}
	movw	r1, #:lower16:12
	movt	r1, #:upper16:12
	push	{r1}
	bl	_malloc
	mov	r1, #4
	add	sp, sp, r1
	push	{r0}
	pop	{r2}
	pop	{r1}
	mov	r4, #1
	mov	r5, #4
	mul	r3,r4,r5
	add	r3, r1, r3
	str	r2, [r3]
	push	{r1}
	movw	r1, #:lower16:12
	movt	r1, #:upper16:12
	push	{r1}
	bl	_malloc
	mov	r1, #4
	add	sp, sp, r1
	push	{r0}
	pop	{r2}
	pop	{r1}
	mov	r4, #2
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
	movw	r1, #:lower16:5
	movt	r1, #:upper16:5
	push	{r1}
#10 End CONSTANT
	pop	{r4}
#11 Starting EXPRESSION of type ARRAY_INDEX
#12 Starting VARIABLE
	ldr	r1, [fp, #-4]
	push	{r1}
#13 End VARIABLE a, depth difference: 0, stack offset: -4
#14 Starting CONSTANT
	movw	r1, #:lower16:2
	movt	r1, #:upper16:2
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
#24 End VARIABLE a, depth difference: 0, stack offset: -4
#25 Starting CONSTANT
	movw	r1, #:lower16:2
	movt	r1, #:upper16:2
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
#32 Starting DECLARATION: adding space on stack
	push	{r1}
#33 Ending DECLARATION
#34 Starting ASSIGNMENT_STATEMENT
#35 Starting EXPRESSION of type NEW
	movw	r1, #:lower16:16
	movt	r1, #:upper16:16
	push	{r1}
	bl	_malloc
	mov	r1, #4
	add	sp, sp, r1
	push	{r0}
	movw	r1, #:lower16:16
	movt	r1, #:upper16:16
	push	{r1}
	bl	_malloc
	mov	r1, #4
	add	sp, sp, r1
	push	{r0}
	movw	r1, #:lower16:16
	movt	r1, #:upper16:16
	push	{r1}
	bl	_malloc
	mov	r1, #4
	add	sp, sp, r1
	push	{r0}
	pop	{r2}
	pop	{r1}
	mov	r4, #0
	mov	r5, #4
	mul	r3,r4,r5
	add	r3, r1, r3
	str	r2, [r3]
	push	{r1}
	movw	r1, #:lower16:16
	movt	r1, #:upper16:16
	push	{r1}
	bl	_malloc
	mov	r1, #4
	add	sp, sp, r1
	push	{r0}
	pop	{r2}
	pop	{r1}
	mov	r4, #1
	mov	r5, #4
	mul	r3,r4,r5
	add	r3, r1, r3
	str	r2, [r3]
	push	{r1}
	movw	r1, #:lower16:16
	movt	r1, #:upper16:16
	push	{r1}
	bl	_malloc
	mov	r1, #4
	add	sp, sp, r1
	push	{r0}
	pop	{r2}
	pop	{r1}
	mov	r4, #2
	mov	r5, #4
	mul	r3,r4,r5
	add	r3, r1, r3
	str	r2, [r3]
	push	{r1}
	movw	r1, #:lower16:16
	movt	r1, #:upper16:16
	push	{r1}
	bl	_malloc
	mov	r1, #4
	add	sp, sp, r1
	push	{r0}
	pop	{r2}
	pop	{r1}
	mov	r4, #3
	mov	r5, #4
	mul	r3,r4,r5
	add	r3, r1, r3
	str	r2, [r3]
	push	{r1}
	pop	{r2}
	pop	{r1}
	mov	r4, #0
	mov	r5, #4
	mul	r3,r4,r5
	add	r3, r1, r3
	str	r2, [r3]
	push	{r1}
	movw	r1, #:lower16:16
	movt	r1, #:upper16:16
	push	{r1}
	bl	_malloc
	mov	r1, #4
	add	sp, sp, r1
	push	{r0}
	movw	r1, #:lower16:16
	movt	r1, #:upper16:16
	push	{r1}
	bl	_malloc
	mov	r1, #4
	add	sp, sp, r1
	push	{r0}
	pop	{r2}
	pop	{r1}
	mov	r4, #0
	mov	r5, #4
	mul	r3,r4,r5
	add	r3, r1, r3
	str	r2, [r3]
	push	{r1}
	movw	r1, #:lower16:16
	movt	r1, #:upper16:16
	push	{r1}
	bl	_malloc
	mov	r1, #4
	add	sp, sp, r1
	push	{r0}
	pop	{r2}
	pop	{r1}
	mov	r4, #1
	mov	r5, #4
	mul	r3,r4,r5
	add	r3, r1, r3
	str	r2, [r3]
	push	{r1}
	movw	r1, #:lower16:16
	movt	r1, #:upper16:16
	push	{r1}
	bl	_malloc
	mov	r1, #4
	add	sp, sp, r1
	push	{r0}
	pop	{r2}
	pop	{r1}
	mov	r4, #2
	mov	r5, #4
	mul	r3,r4,r5
	add	r3, r1, r3
	str	r2, [r3]
	push	{r1}
	movw	r1, #:lower16:16
	movt	r1, #:upper16:16
	push	{r1}
	bl	_malloc
	mov	r1, #4
	add	sp, sp, r1
	push	{r0}
	pop	{r2}
	pop	{r1}
	mov	r4, #3
	mov	r5, #4
	mul	r3,r4,r5
	add	r3, r1, r3
	str	r2, [r3]
	push	{r1}
	pop	{r2}
	pop	{r1}
	mov	r4, #1
	mov	r5, #4
	mul	r3,r4,r5
	add	r3, r1, r3
	str	r2, [r3]
	push	{r1}
	movw	r1, #:lower16:16
	movt	r1, #:upper16:16
	push	{r1}
	bl	_malloc
	mov	r1, #4
	add	sp, sp, r1
	push	{r0}
	movw	r1, #:lower16:16
	movt	r1, #:upper16:16
	push	{r1}
	bl	_malloc
	mov	r1, #4
	add	sp, sp, r1
	push	{r0}
	pop	{r2}
	pop	{r1}
	mov	r4, #0
	mov	r5, #4
	mul	r3,r4,r5
	add	r3, r1, r3
	str	r2, [r3]
	push	{r1}
	movw	r1, #:lower16:16
	movt	r1, #:upper16:16
	push	{r1}
	bl	_malloc
	mov	r1, #4
	add	sp, sp, r1
	push	{r0}
	pop	{r2}
	pop	{r1}
	mov	r4, #1
	mov	r5, #4
	mul	r3,r4,r5
	add	r3, r1, r3
	str	r2, [r3]
	push	{r1}
	movw	r1, #:lower16:16
	movt	r1, #:upper16:16
	push	{r1}
	bl	_malloc
	mov	r1, #4
	add	sp, sp, r1
	push	{r0}
	pop	{r2}
	pop	{r1}
	mov	r4, #2
	mov	r5, #4
	mul	r3,r4,r5
	add	r3, r1, r3
	str	r2, [r3]
	push	{r1}
	movw	r1, #:lower16:16
	movt	r1, #:upper16:16
	push	{r1}
	bl	_malloc
	mov	r1, #4
	add	sp, sp, r1
	push	{r0}
	pop	{r2}
	pop	{r1}
	mov	r4, #3
	mov	r5, #4
	mul	r3,r4,r5
	add	r3, r1, r3
	str	r2, [r3]
	push	{r1}
	pop	{r2}
	pop	{r1}
	mov	r4, #2
	mov	r5, #4
	mul	r3,r4,r5
	add	r3, r1, r3
	str	r2, [r3]
	push	{r1}
	movw	r1, #:lower16:16
	movt	r1, #:upper16:16
	push	{r1}
	bl	_malloc
	mov	r1, #4
	add	sp, sp, r1
	push	{r0}
	movw	r1, #:lower16:16
	movt	r1, #:upper16:16
	push	{r1}
	bl	_malloc
	mov	r1, #4
	add	sp, sp, r1
	push	{r0}
	pop	{r2}
	pop	{r1}
	mov	r4, #0
	mov	r5, #4
	mul	r3,r4,r5
	add	r3, r1, r3
	str	r2, [r3]
	push	{r1}
	movw	r1, #:lower16:16
	movt	r1, #:upper16:16
	push	{r1}
	bl	_malloc
	mov	r1, #4
	add	sp, sp, r1
	push	{r0}
	pop	{r2}
	pop	{r1}
	mov	r4, #1
	mov	r5, #4
	mul	r3,r4,r5
	add	r3, r1, r3
	str	r2, [r3]
	push	{r1}
	movw	r1, #:lower16:16
	movt	r1, #:upper16:16
	push	{r1}
	bl	_malloc
	mov	r1, #4
	add	sp, sp, r1
	push	{r0}
	pop	{r2}
	pop	{r1}
	mov	r4, #2
	mov	r5, #4
	mul	r3,r4,r5
	add	r3, r1, r3
	str	r2, [r3]
	push	{r1}
	movw	r1, #:lower16:16
	movt	r1, #:upper16:16
	push	{r1}
	bl	_malloc
	mov	r1, #4
	add	sp, sp, r1
	push	{r0}
	pop	{r2}
	pop	{r1}
	mov	r4, #3
	mov	r5, #4
	mul	r3,r4,r5
	add	r3, r1, r3
	str	r2, [r3]
	push	{r1}
	pop	{r2}
	pop	{r1}
	mov	r4, #3
	mov	r5, #4
	mul	r3,r4,r5
	add	r3, r1, r3
	str	r2, [r3]
	push	{r1}
#36 Ending EXPRESSION of type NEW
	pop	{r4}
	str	r4, [fp, #-8]
#37 End ASSIGNMENT_STATEMENT
#38 Starting ASSIGNMENT_STATEMENT
#39 Starting CONSTANT
	movw	r1, #:lower16:10
	movt	r1, #:upper16:10
	push	{r1}
#40 End CONSTANT
	pop	{r4}
#41 Starting EXPRESSION of type ARRAY_INDEX
#42 Starting EXPRESSION of type ARRAY_INDEX
#43 Starting VARIABLE
	ldr	r1, [fp, #-8]
	push	{r1}
#44 End VARIABLE b, depth difference: 0, stack offset: -8
#45 Starting CONSTANT
	movw	r1, #:lower16:1
	movt	r1, #:upper16:1
	push	{r1}
#46 End CONSTANT
	pop	{r2}
	pop	{r1}
	mov	r3, #4
	mul	r2,r2,r3
	add	r1, r1, r2
	ldr	r1, [r1]
	push	{r1}
#47 Ending EXPRESSION of type ARRAY_INDEX
#48 Starting CONSTANT
	movw	r1, #:lower16:0
	movt	r1, #:upper16:0
	push	{r1}
#49 End CONSTANT
	pop	{r2}
	pop	{r1}
	mov	r3, #4
	mul	r2,r2,r3
	add	r1, r1, r2
	ldr	r1, [r1]
	push	{r1}
#50 Ending EXPRESSION of type ARRAY_INDEX
#51 Starting CONSTANT
	movw	r1, #:lower16:2
	movt	r1, #:upper16:2
	push	{r1}
#52 End CONSTANT
	pop	{r2}
	pop	{r1}
	mov	r3, #4
	mul	r2,r2,r3
	add	r1, r1, r2
	str	r4, [r1]
#53 End ASSIGNMENT_STATEMENT
#54 Starting PRINT_STATEMENT
	push	{r6}
	pop	{r6}
#55 Starting EXPRESSION of type ARRAY_INDEX
#56 Starting EXPRESSION of type ARRAY_INDEX
#57 Starting EXPRESSION of type ARRAY_INDEX
#58 Starting VARIABLE
	ldr	r1, [fp, #-8]
	push	{r1}
#59 End VARIABLE b, depth difference: 0, stack offset: -8
#60 Starting CONSTANT
	movw	r1, #:lower16:1
	movt	r1, #:upper16:1
	push	{r1}
#61 End CONSTANT
	pop	{r2}
	pop	{r1}
	mov	r3, #4
	mul	r2,r2,r3
	add	r1, r1, r2
	ldr	r1, [r1]
	push	{r1}
#62 Ending EXPRESSION of type ARRAY_INDEX
#63 Starting CONSTANT
	movw	r1, #:lower16:0
	movt	r1, #:upper16:0
	push	{r1}
#64 End CONSTANT
	pop	{r2}
	pop	{r1}
	mov	r3, #4
	mul	r2,r2,r3
	add	r1, r1, r2
	ldr	r1, [r1]
	push	{r1}
#65 Ending EXPRESSION of type ARRAY_INDEX
#66 Starting CONSTANT
	movw	r1, #:lower16:2
	movt	r1, #:upper16:2
	push	{r1}
#67 End CONSTANT
	pop	{r2}
	pop	{r1}
	mov	r3, #4
	mul	r2,r2,r3
	add	r1, r1, r2
	ldr	r1, [r1]
	push	{r1}
#68 Ending EXPRESSION of type ARRAY_INDEX
	movw  r0, #:lower16:.INTEGER
	movt  r0, #:upper16:.INTEGER
	pop	{r1}
	bl	printf
	movw	r0, #:lower16:0x0A
	movt	r0, #:upper16:0x0A
	bl	putchar
#69 Ending PRINT_STATEMENT
#70 Starting DECLARATION: adding space on stack
	push	{r1}
#71 Ending DECLARATION
#72 Starting ASSIGNMENT_STATEMENT
#73 Starting EXPRESSION of type FUNC_CALL
	bl	_create
	push	{r0}
#74 Ending EXPRESSION of type FUNC_CALL
	pop	{r4}
	str	r4, [fp, #-12]
#75 End ASSIGNMENT_STATEMENT
#76 Starting PRINT_STATEMENT
	push	{r6}
	pop	{r6}
#77 Starting EXPRESSION of type ARRAY_INDEX
#78 Starting VARIABLE
	ldr	r1, [fp, #-12]
	push	{r1}
#79 End VARIABLE c, depth difference: 0, stack offset: -12
#80 Starting CONSTANT
	movw	r1, #:lower16:1
	movt	r1, #:upper16:1
	push	{r1}
#81 End CONSTANT
	pop	{r2}
	pop	{r1}
	mov	r3, #4
	mul	r2,r2,r3
	add	r1, r1, r2
	ldr	r1, [r1]
	push	{r1}
#82 Ending EXPRESSION of type ARRAY_INDEX
	movw  r0, #:lower16:.INTEGER
	movt  r0, #:upper16:.INTEGER
	pop	{r1}
	bl	printf
	movw	r0, #:lower16:0x0A
	movt	r0, #:upper16:0x0A
	bl	putchar
#83 Ending PRINT_STATEMENT
	mov	sp, fp
	pop	{fp}
	pop	{pc}
#84 Leaving FUNCTION (main) with depth 2
#85 Starting FUNCTION (create) with depth 2
_create:
	push	{lr}
	push	{fp}
	mov	fp, sp
#86 Starting DECLARATION: adding space on stack
	push	{r1}
#87 Ending DECLARATION
#88 Starting ASSIGNMENT_STATEMENT
#89 Starting EXPRESSION of type NEW
	movw	r1, #:lower16:12
	movt	r1, #:upper16:12
	push	{r1}
	bl	_malloc
	mov	r1, #4
	add	sp, sp, r1
	push	{r0}
#90 Ending EXPRESSION of type NEW
	pop	{r4}
	str	r4, [fp, #-4]
#91 End ASSIGNMENT_STATEMENT
#92 Starting ASSIGNMENT_STATEMENT
#93 Starting CONSTANT
	movw	r1, #:lower16:1
	movt	r1, #:upper16:1
	push	{r1}
#94 End CONSTANT
	pop	{r4}
#95 Starting VARIABLE
	ldr	r1, [fp, #-4]
	push	{r1}
#96 End VARIABLE a, depth difference: 0, stack offset: -4
#97 Starting CONSTANT
	movw	r1, #:lower16:0
	movt	r1, #:upper16:0
	push	{r1}
#98 End CONSTANT
	pop	{r2}
	pop	{r1}
	mov	r3, #4
	mul	r2,r2,r3
	add	r1, r1, r2
	str	r4, [r1]
#99 End ASSIGNMENT_STATEMENT
#100 Starting ASSIGNMENT_STATEMENT
#101 Starting CONSTANT
	movw	r1, #:lower16:2
	movt	r1, #:upper16:2
	push	{r1}
#102 End CONSTANT
	pop	{r4}
#103 Starting VARIABLE
	ldr	r1, [fp, #-4]
	push	{r1}
#104 End VARIABLE a, depth difference: 0, stack offset: -4
#105 Starting CONSTANT
	movw	r1, #:lower16:1
	movt	r1, #:upper16:1
	push	{r1}
#106 End CONSTANT
	pop	{r2}
	pop	{r1}
	mov	r3, #4
	mul	r2,r2,r3
	add	r1, r1, r2
	str	r4, [r1]
#107 End ASSIGNMENT_STATEMENT
#108 Starting ASSIGNMENT_STATEMENT
#109 Starting CONSTANT
	movw	r1, #:lower16:3
	movt	r1, #:upper16:3
	push	{r1}
#110 End CONSTANT
	pop	{r4}
#111 Starting VARIABLE
	ldr	r1, [fp, #-4]
	push	{r1}
#112 End VARIABLE a, depth difference: 0, stack offset: -4
#113 Starting CONSTANT
	movw	r1, #:lower16:2
	movt	r1, #:upper16:2
	push	{r1}
#114 End CONSTANT
	pop	{r2}
	pop	{r1}
	mov	r3, #4
	mul	r2,r2,r3
	add	r1, r1, r2
	str	r4, [r1]
#115 End ASSIGNMENT_STATEMENT
#116 Starting RETURN_STATEMENT
#117 Starting VARIABLE
	ldr	r1, [fp, #-4]
	push	{r1}
#118 End VARIABLE a, depth difference: 0, stack offset: -4
	pop	{r0}
#119 End RETURN_STATEMENT
	mov	sp, fp
	pop	{fp}
	pop	{pc}
#120 Leaving FUNCTION (create) with depth 2
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
#121 End PROGRAM
	mov	sp, fp
	pop	{fp}
	bl	exit
.end
