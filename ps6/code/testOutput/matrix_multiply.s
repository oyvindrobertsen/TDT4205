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
#10 Starting ASSIGNMENT_STATEMENT
#11 Starting EXPRESSION of type NEW
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
#12 Ending EXPRESSION of type NEW
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-8]
	mov	fp, r1
#13 End ASSIGNMENT_STATEMENT
#14 Starting DECLARATION: adding space on stack
	push	{r0}
#15 Ending DECLARATION
#16 Starting DECLARATION: adding space on stack
	push	{r0}
#17 Ending DECLARATION
#18 Starting FOR_STATEMENT
#19 Starting ASSIGNMENT_STATEMENT
#20 Starting CONSTANT
	movw	r0, #:lower16:0
	movt	r0, #:upper16:0
	push	{r0}
#21 End CONSTANT
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-12]
	mov	fp, r1
#22 End ASSIGNMENT_STATEMENT
_start_for_0:
#23 Starting CONSTANT
	movw	r0, #:lower16:3
	movt	r0, #:upper16:3
	push	{r0}
#24 End CONSTANT
	ldr	r2, [fp, #-12]
	pop	{r3}
	cmp	r2,r3
    bge _end_for_0
#25 Starting FOR_STATEMENT
#26 Starting ASSIGNMENT_STATEMENT
#27 Starting CONSTANT
	movw	r0, #:lower16:0
	movt	r0, #:upper16:0
	push	{r0}
#28 End CONSTANT
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-16]
	mov	fp, r1
#29 End ASSIGNMENT_STATEMENT
_start_for_1:
#30 Starting CONSTANT
	movw	r0, #:lower16:3
	movt	r0, #:upper16:3
	push	{r0}
#31 End CONSTANT
	ldr	r2, [fp, #-16]
	pop	{r3}
	cmp	r2,r3
    bge _end_for_1
#32 Starting ASSIGNMENT_STATEMENT
#33 Starting EXPRESSION of type +
#34 Starting EXPRESSION of type *
#35 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-12]
	pop	{fp}
	push	{r0}
#36 End VARIABLE i, depth difference: 0, stack offset: -12
#37 Starting CONSTANT
	movw	r0, #:lower16:3
	movt	r0, #:upper16:3
	push	{r0}
#38 End CONSTANT
	pop	{r2}
	pop	{r1}
	mul	r1,r1,r2
	push	{r1}
#39 Ending EXPRESSION of type *
#40 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-16]
	pop	{fp}
	push	{r0}
#41 End VARIABLE j, depth difference: 0, stack offset: -16
	pop	{r2}
	pop	{r1}
	add	r1, r1, r2
	push	{r1}
#42 Ending EXPRESSION of type +
#43 Starting EXPRESSION of type ARRAY_INDEX
#44 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-4]
	pop	{fp}
	push	{r0}
#45 End VARIABLE a, depth difference: 0, stack offset: -4
#46 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-12]
	pop	{fp}
	push	{r0}
#47 End VARIABLE i, depth difference: 0, stack offset: -12
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#48 Ending EXPRESSION of type ARRAY_INDEX
#49 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-16]
	pop	{fp}
	push	{r0}
#50 End VARIABLE j, depth difference: 0, stack offset: -16
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	pop	{r1}
	str	r1, [r0]
#51 End ASSIGNMENT_STATEMENT
#52 Starting ASSIGNMENT_STATEMENT
#53 Starting EXPRESSION of type -
#54 Starting CONSTANT
	movw	r0, #:lower16:8
	movt	r0, #:upper16:8
	push	{r0}
#55 End CONSTANT
#56 Starting EXPRESSION of type +
#57 Starting EXPRESSION of type *
#58 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-12]
	pop	{fp}
	push	{r0}
#59 End VARIABLE i, depth difference: 0, stack offset: -12
#60 Starting CONSTANT
	movw	r0, #:lower16:3
	movt	r0, #:upper16:3
	push	{r0}
#61 End CONSTANT
	pop	{r2}
	pop	{r1}
	mul	r1,r1,r2
	push	{r1}
#62 Ending EXPRESSION of type *
#63 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-16]
	pop	{fp}
	push	{r0}
#64 End VARIABLE j, depth difference: 0, stack offset: -16
	pop	{r2}
	pop	{r1}
	add	r1, r1, r2
	push	{r1}
#65 Ending EXPRESSION of type +
	pop	{r2}
	pop	{r1}
	sub	r1, r1, r2
	push	{r1}
#66 Ending EXPRESSION of type -
#67 Starting EXPRESSION of type ARRAY_INDEX
#68 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-8]
	pop	{fp}
	push	{r0}
#69 End VARIABLE b, depth difference: 0, stack offset: -8
#70 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-12]
	pop	{fp}
	push	{r0}
#71 End VARIABLE i, depth difference: 0, stack offset: -12
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#72 Ending EXPRESSION of type ARRAY_INDEX
#73 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-16]
	pop	{fp}
	push	{r0}
#74 End VARIABLE j, depth difference: 0, stack offset: -16
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	pop	{r1}
	str	r1, [r0]
#75 End ASSIGNMENT_STATEMENT
	ldr	r2, [fp, #-16]
	mov	r3, #1
	add	r2, r2, r3
	str	r2, [fp, #-16]
	b	_start_for_1
_end_for_1:
#76 End FOR_STATEMENT
	ldr	r2, [fp, #-12]
	mov	r3, #1
	add	r2, r2, r3
	str	r2, [fp, #-12]
	b	_start_for_0
_end_for_0:
#77 End FOR_STATEMENT
#78 Starting DECLARATION: adding space on stack
	push	{r0}
#79 Ending DECLARATION
#80 Starting ASSIGNMENT_STATEMENT
#81 Starting EXPRESSION of type NEW
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
#82 Ending EXPRESSION of type NEW
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-20]
	mov	fp, r1
#83 End ASSIGNMENT_STATEMENT
#84 Starting DECLARATION: adding space on stack
	push	{r0}
#85 Ending DECLARATION
#86 Starting FOR_STATEMENT
#87 Starting ASSIGNMENT_STATEMENT
#88 Starting CONSTANT
	movw	r0, #:lower16:0
	movt	r0, #:upper16:0
	push	{r0}
#89 End CONSTANT
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-12]
	mov	fp, r1
#90 End ASSIGNMENT_STATEMENT
_start_for_2:
#91 Starting CONSTANT
	movw	r0, #:lower16:3
	movt	r0, #:upper16:3
	push	{r0}
#92 End CONSTANT
	ldr	r2, [fp, #-12]
	pop	{r3}
	cmp	r2,r3
    bge _end_for_2
#93 Starting FOR_STATEMENT
#94 Starting ASSIGNMENT_STATEMENT
#95 Starting CONSTANT
	movw	r0, #:lower16:0
	movt	r0, #:upper16:0
	push	{r0}
#96 End CONSTANT
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-16]
	mov	fp, r1
#97 End ASSIGNMENT_STATEMENT
_start_for_3:
#98 Starting CONSTANT
	movw	r0, #:lower16:3
	movt	r0, #:upper16:3
	push	{r0}
#99 End CONSTANT
	ldr	r2, [fp, #-16]
	pop	{r3}
	cmp	r2,r3
    bge _end_for_3
#100 Starting ASSIGNMENT_STATEMENT
#101 Starting CONSTANT
	movw	r0, #:lower16:0
	movt	r0, #:upper16:0
	push	{r0}
#102 End CONSTANT
#103 Starting EXPRESSION of type ARRAY_INDEX
#104 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-20]
	pop	{fp}
	push	{r0}
#105 End VARIABLE c, depth difference: 0, stack offset: -20
#106 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-12]
	pop	{fp}
	push	{r0}
#107 End VARIABLE i, depth difference: 0, stack offset: -12
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#108 Ending EXPRESSION of type ARRAY_INDEX
#109 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-16]
	pop	{fp}
	push	{r0}
#110 End VARIABLE j, depth difference: 0, stack offset: -16
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	pop	{r1}
	str	r1, [r0]
#111 End ASSIGNMENT_STATEMENT
#112 Starting FOR_STATEMENT
#113 Starting ASSIGNMENT_STATEMENT
#114 Starting CONSTANT
	movw	r0, #:lower16:0
	movt	r0, #:upper16:0
	push	{r0}
#115 End CONSTANT
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-24]
	mov	fp, r1
#116 End ASSIGNMENT_STATEMENT
_start_for_4:
#117 Starting CONSTANT
	movw	r0, #:lower16:3
	movt	r0, #:upper16:3
	push	{r0}
#118 End CONSTANT
	ldr	r2, [fp, #-24]
	pop	{r3}
	cmp	r2,r3
    bge _end_for_4
#119 Starting ASSIGNMENT_STATEMENT
#120 Starting EXPRESSION of type +
#121 Starting EXPRESSION of type ARRAY_INDEX
#122 Starting EXPRESSION of type ARRAY_INDEX
#123 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-20]
	pop	{fp}
	push	{r0}
#124 End VARIABLE c, depth difference: 0, stack offset: -20
#125 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-12]
	pop	{fp}
	push	{r0}
#126 End VARIABLE i, depth difference: 0, stack offset: -12
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#127 Ending EXPRESSION of type ARRAY_INDEX
#128 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-16]
	pop	{fp}
	push	{r0}
#129 End VARIABLE j, depth difference: 0, stack offset: -16
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#130 Ending EXPRESSION of type ARRAY_INDEX
#131 Starting EXPRESSION of type *
#132 Starting EXPRESSION of type ARRAY_INDEX
#133 Starting EXPRESSION of type ARRAY_INDEX
#134 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-4]
	pop	{fp}
	push	{r0}
#135 End VARIABLE a, depth difference: 0, stack offset: -4
#136 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-12]
	pop	{fp}
	push	{r0}
#137 End VARIABLE i, depth difference: 0, stack offset: -12
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#138 Ending EXPRESSION of type ARRAY_INDEX
#139 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-24]
	pop	{fp}
	push	{r0}
#140 End VARIABLE k, depth difference: 0, stack offset: -24
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#141 Ending EXPRESSION of type ARRAY_INDEX
#142 Starting EXPRESSION of type ARRAY_INDEX
#143 Starting EXPRESSION of type ARRAY_INDEX
#144 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-8]
	pop	{fp}
	push	{r0}
#145 End VARIABLE b, depth difference: 0, stack offset: -8
#146 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-24]
	pop	{fp}
	push	{r0}
#147 End VARIABLE k, depth difference: 0, stack offset: -24
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#148 Ending EXPRESSION of type ARRAY_INDEX
#149 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-16]
	pop	{fp}
	push	{r0}
#150 End VARIABLE j, depth difference: 0, stack offset: -16
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#151 Ending EXPRESSION of type ARRAY_INDEX
	pop	{r2}
	pop	{r1}
	mul	r1,r1,r2
	push	{r1}
#152 Ending EXPRESSION of type *
	pop	{r2}
	pop	{r1}
	add	r1, r1, r2
	push	{r1}
#153 Ending EXPRESSION of type +
#154 Starting EXPRESSION of type ARRAY_INDEX
#155 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-20]
	pop	{fp}
	push	{r0}
#156 End VARIABLE c, depth difference: 0, stack offset: -20
#157 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-12]
	pop	{fp}
	push	{r0}
#158 End VARIABLE i, depth difference: 0, stack offset: -12
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#159 Ending EXPRESSION of type ARRAY_INDEX
#160 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-16]
	pop	{fp}
	push	{r0}
#161 End VARIABLE j, depth difference: 0, stack offset: -16
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	pop	{r1}
	str	r1, [r0]
#162 End ASSIGNMENT_STATEMENT
	ldr	r2, [fp, #-24]
	mov	r3, #1
	add	r2, r2, r3
	str	r2, [fp, #-24]
	b	_start_for_4
_end_for_4:
#163 End FOR_STATEMENT
	ldr	r2, [fp, #-16]
	mov	r3, #1
	add	r2, r2, r3
	str	r2, [fp, #-16]
	b	_start_for_3
_end_for_3:
#164 End FOR_STATEMENT
	ldr	r2, [fp, #-12]
	mov	r3, #1
	add	r2, r2, r3
	str	r2, [fp, #-12]
	b	_start_for_2
_end_for_2:
#165 End FOR_STATEMENT
#166 Starting PRINT_STATEMENT
	push	{r6}
	pop	{r6}
#167 Starting EXPRESSION of type ARRAY_INDEX
#168 Starting EXPRESSION of type ARRAY_INDEX
#169 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-20]
	pop	{fp}
	push	{r0}
#170 End VARIABLE c, depth difference: 0, stack offset: -20
#171 Starting CONSTANT
	movw	r0, #:lower16:0
	movt	r0, #:upper16:0
	push	{r0}
#172 End CONSTANT
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#173 Ending EXPRESSION of type ARRAY_INDEX
#174 Starting CONSTANT
	movw	r0, #:lower16:0
	movt	r0, #:upper16:0
	push	{r0}
#175 End CONSTANT
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#176 Ending EXPRESSION of type ARRAY_INDEX
	movw	r0, #:lower16:.INTEGER
	movt	r0, #:upper16:.INTEGER
	pop	{r1}
	bl	printf
#177 Starting EXPRESSION of type ARRAY_INDEX
#178 Starting EXPRESSION of type ARRAY_INDEX
#179 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-20]
	pop	{fp}
	push	{r0}
#180 End VARIABLE c, depth difference: 0, stack offset: -20
#181 Starting CONSTANT
	movw	r0, #:lower16:0
	movt	r0, #:upper16:0
	push	{r0}
#182 End CONSTANT
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#183 Ending EXPRESSION of type ARRAY_INDEX
#184 Starting CONSTANT
	movw	r0, #:lower16:1
	movt	r0, #:upper16:1
	push	{r0}
#185 End CONSTANT
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#186 Ending EXPRESSION of type ARRAY_INDEX
	movw	r0, #:lower16:.INTEGER
	movt	r0, #:upper16:.INTEGER
	pop	{r1}
	bl	printf
#187 Starting EXPRESSION of type ARRAY_INDEX
#188 Starting EXPRESSION of type ARRAY_INDEX
#189 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-20]
	pop	{fp}
	push	{r0}
#190 End VARIABLE c, depth difference: 0, stack offset: -20
#191 Starting CONSTANT
	movw	r0, #:lower16:0
	movt	r0, #:upper16:0
	push	{r0}
#192 End CONSTANT
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#193 Ending EXPRESSION of type ARRAY_INDEX
#194 Starting CONSTANT
	movw	r0, #:lower16:2
	movt	r0, #:upper16:2
	push	{r0}
#195 End CONSTANT
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#196 Ending EXPRESSION of type ARRAY_INDEX
	movw	r0, #:lower16:.INTEGER
	movt	r0, #:upper16:.INTEGER
	pop	{r1}
	bl	printf
	movw	r0, #:lower16:0x0A
	movt	r0, #:upper16:0x0A
	bl	putchar
#197 Ending PRINT_STATEMENT
#198 Starting PRINT_STATEMENT
	push	{r6}
	pop	{r6}
#199 Starting EXPRESSION of type ARRAY_INDEX
#200 Starting EXPRESSION of type ARRAY_INDEX
#201 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-20]
	pop	{fp}
	push	{r0}
#202 End VARIABLE c, depth difference: 0, stack offset: -20
#203 Starting CONSTANT
	movw	r0, #:lower16:1
	movt	r0, #:upper16:1
	push	{r0}
#204 End CONSTANT
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#205 Ending EXPRESSION of type ARRAY_INDEX
#206 Starting CONSTANT
	movw	r0, #:lower16:0
	movt	r0, #:upper16:0
	push	{r0}
#207 End CONSTANT
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#208 Ending EXPRESSION of type ARRAY_INDEX
	movw	r0, #:lower16:.INTEGER
	movt	r0, #:upper16:.INTEGER
	pop	{r1}
	bl	printf
#209 Starting EXPRESSION of type ARRAY_INDEX
#210 Starting EXPRESSION of type ARRAY_INDEX
#211 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-20]
	pop	{fp}
	push	{r0}
#212 End VARIABLE c, depth difference: 0, stack offset: -20
#213 Starting CONSTANT
	movw	r0, #:lower16:1
	movt	r0, #:upper16:1
	push	{r0}
#214 End CONSTANT
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#215 Ending EXPRESSION of type ARRAY_INDEX
#216 Starting CONSTANT
	movw	r0, #:lower16:1
	movt	r0, #:upper16:1
	push	{r0}
#217 End CONSTANT
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#218 Ending EXPRESSION of type ARRAY_INDEX
	movw	r0, #:lower16:.INTEGER
	movt	r0, #:upper16:.INTEGER
	pop	{r1}
	bl	printf
#219 Starting EXPRESSION of type ARRAY_INDEX
#220 Starting EXPRESSION of type ARRAY_INDEX
#221 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-20]
	pop	{fp}
	push	{r0}
#222 End VARIABLE c, depth difference: 0, stack offset: -20
#223 Starting CONSTANT
	movw	r0, #:lower16:1
	movt	r0, #:upper16:1
	push	{r0}
#224 End CONSTANT
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#225 Ending EXPRESSION of type ARRAY_INDEX
#226 Starting CONSTANT
	movw	r0, #:lower16:2
	movt	r0, #:upper16:2
	push	{r0}
#227 End CONSTANT
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#228 Ending EXPRESSION of type ARRAY_INDEX
	movw	r0, #:lower16:.INTEGER
	movt	r0, #:upper16:.INTEGER
	pop	{r1}
	bl	printf
	movw	r0, #:lower16:0x0A
	movt	r0, #:upper16:0x0A
	bl	putchar
#229 Ending PRINT_STATEMENT
#230 Starting PRINT_STATEMENT
	push	{r6}
	pop	{r6}
#231 Starting EXPRESSION of type ARRAY_INDEX
#232 Starting EXPRESSION of type ARRAY_INDEX
#233 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-20]
	pop	{fp}
	push	{r0}
#234 End VARIABLE c, depth difference: 0, stack offset: -20
#235 Starting CONSTANT
	movw	r0, #:lower16:2
	movt	r0, #:upper16:2
	push	{r0}
#236 End CONSTANT
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#237 Ending EXPRESSION of type ARRAY_INDEX
#238 Starting CONSTANT
	movw	r0, #:lower16:0
	movt	r0, #:upper16:0
	push	{r0}
#239 End CONSTANT
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#240 Ending EXPRESSION of type ARRAY_INDEX
	movw	r0, #:lower16:.INTEGER
	movt	r0, #:upper16:.INTEGER
	pop	{r1}
	bl	printf
#241 Starting EXPRESSION of type ARRAY_INDEX
#242 Starting EXPRESSION of type ARRAY_INDEX
#243 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-20]
	pop	{fp}
	push	{r0}
#244 End VARIABLE c, depth difference: 0, stack offset: -20
#245 Starting CONSTANT
	movw	r0, #:lower16:2
	movt	r0, #:upper16:2
	push	{r0}
#246 End CONSTANT
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#247 Ending EXPRESSION of type ARRAY_INDEX
#248 Starting CONSTANT
	movw	r0, #:lower16:1
	movt	r0, #:upper16:1
	push	{r0}
#249 End CONSTANT
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#250 Ending EXPRESSION of type ARRAY_INDEX
	movw	r0, #:lower16:.INTEGER
	movt	r0, #:upper16:.INTEGER
	pop	{r1}
	bl	printf
#251 Starting EXPRESSION of type ARRAY_INDEX
#252 Starting EXPRESSION of type ARRAY_INDEX
#253 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-20]
	pop	{fp}
	push	{r0}
#254 End VARIABLE c, depth difference: 0, stack offset: -20
#255 Starting CONSTANT
	movw	r0, #:lower16:2
	movt	r0, #:upper16:2
	push	{r0}
#256 End CONSTANT
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#257 Ending EXPRESSION of type ARRAY_INDEX
#258 Starting CONSTANT
	movw	r0, #:lower16:2
	movt	r0, #:upper16:2
	push	{r0}
#259 End CONSTANT
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#260 Ending EXPRESSION of type ARRAY_INDEX
	movw	r0, #:lower16:.INTEGER
	movt	r0, #:upper16:.INTEGER
	pop	{r1}
	bl	printf
	movw	r0, #:lower16:0x0A
	movt	r0, #:upper16:0x0A
	bl	putchar
#261 Ending PRINT_STATEMENT
	mov	sp, fp
	pop	{fp}
	pop	{pc}
#262 Leaving FUNCTION (main) with depth 2
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
#263 End PROGRAM
	mov	sp, fp
	pop	{fp}
	bl	exit
.end
