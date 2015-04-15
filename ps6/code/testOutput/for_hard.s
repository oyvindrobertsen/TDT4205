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
#4 Starting FOR_STATEMENT
#5 Starting ASSIGNMENT_STATEMENT
#6 Starting CONSTANT
	movw	r0, #:lower16:1
	movt	r0, #:upper16:1
	push	{r0}
#7 End CONSTANT
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-4]
	mov	fp, r1
#8 End ASSIGNMENT_STATEMENT
_start_for_0:
#9 Starting CONSTANT
	movw	r0, #:lower16:5
	movt	r0, #:upper16:5
	push	{r0}
#10 End CONSTANT
	ldr	r2, [fp, #-4]
	pop	{r3}
	cmp	r2,r3
    bge _end_for_0
#11 Starting DECLARATION: adding space on stack
	push	{r0}
#12 Ending DECLARATION
#13 Starting FOR_STATEMENT
#14 Starting ASSIGNMENT_STATEMENT
#15 Starting CONSTANT
	movw	r0, #:lower16:1
	movt	r0, #:upper16:1
	push	{r0}
#16 End CONSTANT
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-8]
	mov	fp, r1
#17 End ASSIGNMENT_STATEMENT
_start_for_1:
#18 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-4]
	pop	{fp}
	push	{r0}
#19 End VARIABLE i, depth difference: 0, stack offset: -4
	ldr	r2, [fp, #-8]
	pop	{r3}
	cmp	r2,r3
    bge _end_for_1
#20 Starting DECLARATION: adding space on stack
	push	{r0}
#21 Ending DECLARATION
#22 Starting FOR_STATEMENT
#23 Starting ASSIGNMENT_STATEMENT
#24 Starting CONSTANT
	movw	r0, #:lower16:1
	movt	r0, #:upper16:1
	push	{r0}
#25 End CONSTANT
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-12]
	mov	fp, r1
#26 End ASSIGNMENT_STATEMENT
_start_for_2:
#27 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-8]
	pop	{fp}
	push	{r0}
#28 End VARIABLE j, depth difference: 0, stack offset: -8
	ldr	r2, [fp, #-12]
	pop	{r3}
	cmp	r2,r3
    bge _end_for_2
#29 Starting EXPRESSION of type FUNC_CALL
#30 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-4]
	pop	{fp}
	push	{r0}
#31 End VARIABLE i, depth difference: 0, stack offset: -4
#32 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-8]
	pop	{fp}
	push	{r0}
#33 End VARIABLE j, depth difference: 0, stack offset: -8
#34 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-12]
	pop	{fp}
	push	{r0}
#35 End VARIABLE k, depth difference: 0, stack offset: -12
	bl	_print
	add	sp, sp, $4
	add	sp, sp, $4
	add	sp, sp, $4
#36 Ending EXPRESSION of type (null)
#37 Ending EXPRESSION of type FUNC_CALL
	ldr	r2, [fp, #-12]
	mov	r3, #1
	add	r2, r2, r3
	str	r2, [fp, #-12]
	b	_start_for_2
_end_for_2:
#38 End FOR_STATEMENT
	ldr	r2, [fp, #-8]
	mov	r3, #1
	add	r2, r2, r3
	str	r2, [fp, #-8]
	b	_start_for_1
_end_for_1:
#39 End FOR_STATEMENT
	ldr	r2, [fp, #-4]
	mov	r3, #1
	add	r2, r2, r3
	str	r2, [fp, #-4]
	b	_start_for_0
_end_for_0:
#40 End FOR_STATEMENT
	mov	sp, fp
	pop	{fp}
	pop	{pc}
#41 Leaving FUNCTION (main) with depth 2
#42 Starting FUNCTION (print) with depth 2
_print:
	push	{lr}
	push	{fp}
	mov	fp, sp
#43 Starting FOR_STATEMENT
#44 Starting ASSIGNMENT_STATEMENT
#45 Starting EXPRESSION of type UMINUS
#46 Starting CONSTANT
	movw	r0, #:lower16:1
	movt	r0, #:upper16:1
	push	{r0}
#47 End CONSTANT
	pop	{r1}
	neg	r1, r1
	push	{r1}
#48 Ending EXPRESSION of type UMINUS
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #16]
	mov	fp, r1
#49 End ASSIGNMENT_STATEMENT
_start_for_3:
#50 Starting CONSTANT
	movw	r0, #:lower16:0
	movt	r0, #:upper16:0
	push	{r0}
#51 End CONSTANT
	ldr	r2, [fp, #16]
	pop	{r3}
	cmp	r2,r3
    bge _end_for_3
#52 Starting PRINT_STATEMENT
	push	{r6}
	pop	{r6}
#53 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #12]
	pop	{fp}
	push	{r0}
#54 End VARIABLE b, depth difference: 0, stack offset: 12
	movw	r0, #:lower16:.INTEGER
	movt	r0, #:upper16:.INTEGER
	pop	{r1}
	bl	printf
#55 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #8]
	pop	{fp}
	push	{r0}
#56 End VARIABLE c, depth difference: 0, stack offset: 8
	movw	r0, #:lower16:.INTEGER
	movt	r0, #:upper16:.INTEGER
	pop	{r1}
	bl	printf
	movw	r0, #:lower16:0x0A
	movt	r0, #:upper16:0x0A
	bl	putchar
#57 Ending PRINT_STATEMENT
	ldr	r2, [fp, #16]
	mov	r3, #1
	add	r2, r2, r3
	str	r2, [fp, #16]
	b	_start_for_3
_end_for_3:
#58 End FOR_STATEMENT
	mov	sp, fp
	pop	{fp}
	pop	{pc}
#59 Leaving FUNCTION (print) with depth 2
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
#60 End PROGRAM
	mov	sp, fp
	pop	{fp}
	bl	exit
.end
