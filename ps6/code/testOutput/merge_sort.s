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
	movw	r0, #:lower16:400
	movt	r0, #:upper16:400
	push	{r0}
	bl	_malloc
	pop	{r1}
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
#10 Starting FOR_STATEMENT
#11 Starting ASSIGNMENT_STATEMENT
#12 Starting CONSTANT
	movw	r0, #:lower16:0
	movt	r0, #:upper16:0
	push	{r0}
#13 End CONSTANT
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-8]
	mov	fp, r1
#14 End ASSIGNMENT_STATEMENT
_start_for_0:
#15 Starting CONSTANT
	movw	r0, #:lower16:100
	movt	r0, #:upper16:100
	push	{r0}
#16 End CONSTANT
	ldr	r2, [fp, #-8]
	pop	{r3}
	cmp	r2,r3
    bge _end_for_0
#17 Starting ASSIGNMENT_STATEMENT
#18 Starting EXPRESSION of type -
#19 Starting CONSTANT
	movw	r0, #:lower16:100
	movt	r0, #:upper16:100
	push	{r0}
#20 End CONSTANT
#21 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-8]
	pop	{fp}
	push	{r0}
#22 End VARIABLE i, depth difference: 0, stack offset: -8
	pop	{r2}
	pop	{r1}
	sub	r1, r1, r2
	push	{r1}
#23 Ending EXPRESSION of type -
#24 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-4]
	pop	{fp}
	push	{r0}
#25 End VARIABLE a, depth difference: 0, stack offset: -4
#26 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-8]
	pop	{fp}
	push	{r0}
#27 End VARIABLE i, depth difference: 0, stack offset: -8
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	pop	{r1}
	str	r1, [r0]
#28 End ASSIGNMENT_STATEMENT
	ldr	r2, [fp, #-8]
	mov	r3, #1
	add	r2, r2, r3
	str	r2, [fp, #-8]
	b	_start_for_0
_end_for_0:
#29 End FOR_STATEMENT
#30 Starting EXPRESSION of type FUNC_CALL
#31 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-4]
	pop	{fp}
	push	{r0}
#32 End VARIABLE a, depth difference: 0, stack offset: -4
#33 Starting CONSTANT
	movw	r0, #:lower16:0
	movt	r0, #:upper16:0
	push	{r0}
#34 End CONSTANT
#35 Starting CONSTANT
	movw	r0, #:lower16:100
	movt	r0, #:upper16:100
	push	{r0}
#36 End CONSTANT
	bl	_merge_sort
	add	sp, sp, $4
	add	sp, sp, $4
	add	sp, sp, $4
#37 Ending EXPRESSION of type (null)
#38 Ending EXPRESSION of type FUNC_CALL
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
	str	r0, [fp, #-8]
	mov	fp, r1
#43 End ASSIGNMENT_STATEMENT
_start_for_1:
#44 Starting CONSTANT
	movw	r0, #:lower16:100
	movt	r0, #:upper16:100
	push	{r0}
#45 End CONSTANT
	ldr	r2, [fp, #-8]
	pop	{r3}
	cmp	r2,r3
    bge _end_for_1
#46 Starting PRINT_STATEMENT
	push	{r6}
	pop	{r6}
#47 Starting EXPRESSION of type ARRAY_INDEX
#48 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-4]
	pop	{fp}
	push	{r0}
#49 End VARIABLE a, depth difference: 0, stack offset: -4
#50 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-8]
	pop	{fp}
	push	{r0}
#51 End VARIABLE i, depth difference: 0, stack offset: -8
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
	ldr	r2, [fp, #-8]
	mov	r3, #1
	add	r2, r2, r3
	str	r2, [fp, #-8]
	b	_start_for_1
_end_for_1:
#54 End FOR_STATEMENT
	mov	sp, fp
	pop	{fp}
	pop	{pc}
#55 Leaving FUNCTION (main) with depth 2
#56 Starting FUNCTION (merge_sort) with depth 2
_merge_sort:
	push	{lr}
	push	{fp}
	mov	fp, sp
#57 Starting IF_STATEMENT'
#58 Starting EXPRESSION of type <=
#59 Starting EXPRESSION of type -
#60 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #8]
	pop	{fp}
	push	{r0}
#61 End VARIABLE end, depth difference: 0, stack offset: 8
#62 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #12]
	pop	{fp}
	push	{r0}
#63 End VARIABLE start, depth difference: 0, stack offset: 12
	pop	{r2}
	pop	{r1}
	sub	r1, r1, r2
	push	{r1}
#64 Ending EXPRESSION of type -
#65 Starting CONSTANT
	movw	r0, #:lower16:1
	movt	r0, #:upper16:1
	push	{r0}
#66 End CONSTANT
	pop	{r3}
	pop	{r2}
	mov	r1, #0
	cmp	r2,r3
	movle	 r1, #1
	push	{r1}
#67 Ending EXPRESSION of type <=
	mov	r1, #0
	pop	{r2}
	cmp	r1,r2
	beq	_if_0
#68 Starting RETURN_STATEMENT
#69 Starting CONSTANT
	movw	r0, #:lower16:0
	movt	r0, #:upper16:0
	push	{r0}
#70 End CONSTANT
	pop	{r0}
	mov	sp, fp
	pop	{fp}
	pop	{pc}
#71 End RETURN_STATEMENT
	b	_if_1
_if_0:
#72 Starting DECLARATION: adding space on stack
	push	{r0}
#73 Ending DECLARATION
#74 Starting ASSIGNMENT_STATEMENT
#75 Starting EXPRESSION of type +
#76 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #12]
	pop	{fp}
	push	{r0}
#77 End VARIABLE start, depth difference: 0, stack offset: 12
#78 Starting EXPRESSION of type /
#79 Starting EXPRESSION of type -
#80 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #8]
	pop	{fp}
	push	{r0}
#81 End VARIABLE end, depth difference: 0, stack offset: 8
#82 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #12]
	pop	{fp}
	push	{r0}
#83 End VARIABLE start, depth difference: 0, stack offset: 12
	pop	{r2}
	pop	{r1}
	sub	r1, r1, r2
	push	{r1}
#84 Ending EXPRESSION of type -
#85 Starting CONSTANT
	movw	r0, #:lower16:2
	movt	r0, #:upper16:2
	push	{r0}
#86 End CONSTANT
	pop	{r2}
	pop	{r1}
	sdiv	r1, r1, r2
	push	{r1}
#87 Ending EXPRESSION of type /
	pop	{r2}
	pop	{r1}
	add	r1, r1, r2
	push	{r1}
#88 Ending EXPRESSION of type +
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-4]
	mov	fp, r1
#89 End ASSIGNMENT_STATEMENT
#90 Starting EXPRESSION of type FUNC_CALL
#91 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #16]
	pop	{fp}
	push	{r0}
#92 End VARIABLE a, depth difference: 0, stack offset: 16
#93 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #12]
	pop	{fp}
	push	{r0}
#94 End VARIABLE start, depth difference: 0, stack offset: 12
#95 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-4]
	pop	{fp}
	push	{r0}
#96 End VARIABLE middle, depth difference: 0, stack offset: -4
	bl	_merge_sort
	add	sp, sp, $4
	add	sp, sp, $4
	add	sp, sp, $4
#97 Ending EXPRESSION of type (null)
#98 Ending EXPRESSION of type FUNC_CALL
#99 Starting EXPRESSION of type FUNC_CALL
#100 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #16]
	pop	{fp}
	push	{r0}
#101 End VARIABLE a, depth difference: 0, stack offset: 16
#102 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-4]
	pop	{fp}
	push	{r0}
#103 End VARIABLE middle, depth difference: 0, stack offset: -4
#104 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #8]
	pop	{fp}
	push	{r0}
#105 End VARIABLE end, depth difference: 0, stack offset: 8
	bl	_merge_sort
	add	sp, sp, $4
	add	sp, sp, $4
	add	sp, sp, $4
#106 Ending EXPRESSION of type (null)
#107 Ending EXPRESSION of type FUNC_CALL
#108 Starting EXPRESSION of type FUNC_CALL
#109 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #16]
	pop	{fp}
	push	{r0}
#110 End VARIABLE a, depth difference: 0, stack offset: 16
#111 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #12]
	pop	{fp}
	push	{r0}
#112 End VARIABLE start, depth difference: 0, stack offset: 12
#113 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-4]
	pop	{fp}
	push	{r0}
#114 End VARIABLE middle, depth difference: 0, stack offset: -4
#115 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #8]
	pop	{fp}
	push	{r0}
#116 End VARIABLE end, depth difference: 0, stack offset: 8
	bl	_merge
	add	sp, sp, $4
	add	sp, sp, $4
	add	sp, sp, $4
	add	sp, sp, $4
#117 Ending EXPRESSION of type (null)
#118 Ending EXPRESSION of type FUNC_CALL
_if_1:
#119 End IF_STATEMENT
	mov	sp, fp
	pop	{fp}
	pop	{pc}
#120 Leaving FUNCTION (merge_sort) with depth 2
#121 Starting FUNCTION (merge) with depth 2
_merge:
	push	{lr}
	push	{fp}
	mov	fp, sp
#122 Starting DECLARATION: adding space on stack
	push	{r0}
#123 Ending DECLARATION
#124 Starting ASSIGNMENT_STATEMENT
#125 Starting EXPRESSION of type NEW
	movw	r0, #:lower16:400
	movt	r0, #:upper16:400
	push	{r0}
	bl	_malloc
	pop	{r1}
	push	{r0}
#126 Ending EXPRESSION of type NEW
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-4]
	mov	fp, r1
#127 End ASSIGNMENT_STATEMENT
#128 Starting DECLARATION: adding space on stack
	push	{r0}
#129 Ending DECLARATION
#130 Starting DECLARATION: adding space on stack
	push	{r0}
#131 Ending DECLARATION
#132 Starting ASSIGNMENT_STATEMENT
#133 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #16]
	pop	{fp}
	push	{r0}
#134 End VARIABLE start, depth difference: 0, stack offset: 16
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-8]
	mov	fp, r1
#135 End ASSIGNMENT_STATEMENT
#136 Starting ASSIGNMENT_STATEMENT
#137 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #12]
	pop	{fp}
	push	{r0}
#138 End VARIABLE middle, depth difference: 0, stack offset: 12
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-12]
	mov	fp, r1
#139 End ASSIGNMENT_STATEMENT
#140 Starting DECLARATION: adding space on stack
	push	{r0}
#141 Ending DECLARATION
#142 Starting FOR_STATEMENT
#143 Starting ASSIGNMENT_STATEMENT
#144 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #16]
	pop	{fp}
	push	{r0}
#145 End VARIABLE start, depth difference: 0, stack offset: 16
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-16]
	mov	fp, r1
#146 End ASSIGNMENT_STATEMENT
_start_for_2:
#147 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #8]
	pop	{fp}
	push	{r0}
#148 End VARIABLE end, depth difference: 0, stack offset: 8
	ldr	r2, [fp, #-16]
	pop	{r3}
	cmp	r2,r3
    bge _end_for_2
#149 Starting IF_STATEMENT'
#150 Starting EXPRESSION of type >=
#151 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-8]
	pop	{fp}
	push	{r0}
#152 End VARIABLE i, depth difference: 0, stack offset: -8
#153 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #12]
	pop	{fp}
	push	{r0}
#154 End VARIABLE middle, depth difference: 0, stack offset: 12
	pop	{r3}
	pop	{r2}
	mov	r1, #0
	cmp	r2,r3
	movge	 r1, #1
	push	{r1}
#155 Ending EXPRESSION of type >=
	mov	r1, #0
	pop	{r2}
	cmp	r1,r2
	beq	_if_2
#156 Starting ASSIGNMENT_STATEMENT
#157 Starting EXPRESSION of type ARRAY_INDEX
#158 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #20]
	pop	{fp}
	push	{r0}
#159 End VARIABLE a, depth difference: 0, stack offset: 20
#160 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-12]
	pop	{fp}
	push	{r0}
#161 End VARIABLE j, depth difference: 0, stack offset: -12
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#162 Ending EXPRESSION of type ARRAY_INDEX
#163 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-4]
	pop	{fp}
	push	{r0}
#164 End VARIABLE temp, depth difference: 0, stack offset: -4
#165 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-16]
	pop	{fp}
	push	{r0}
#166 End VARIABLE k, depth difference: 0, stack offset: -16
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	pop	{r1}
	str	r1, [r0]
#167 End ASSIGNMENT_STATEMENT
#168 Starting ASSIGNMENT_STATEMENT
#169 Starting EXPRESSION of type +
#170 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-12]
	pop	{fp}
	push	{r0}
#171 End VARIABLE j, depth difference: 0, stack offset: -12
#172 Starting CONSTANT
	movw	r0, #:lower16:1
	movt	r0, #:upper16:1
	push	{r0}
#173 End CONSTANT
	pop	{r2}
	pop	{r1}
	add	r1, r1, r2
	push	{r1}
#174 Ending EXPRESSION of type +
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-12]
	mov	fp, r1
#175 End ASSIGNMENT_STATEMENT
	b	_if_3
_if_2:
#176 Starting IF_STATEMENT'
#177 Starting EXPRESSION of type >=
#178 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-12]
	pop	{fp}
	push	{r0}
#179 End VARIABLE j, depth difference: 0, stack offset: -12
#180 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #8]
	pop	{fp}
	push	{r0}
#181 End VARIABLE end, depth difference: 0, stack offset: 8
	pop	{r3}
	pop	{r2}
	mov	r1, #0
	cmp	r2,r3
	movge	 r1, #1
	push	{r1}
#182 Ending EXPRESSION of type >=
	mov	r1, #0
	pop	{r2}
	cmp	r1,r2
	beq	_if_4
#183 Starting ASSIGNMENT_STATEMENT
#184 Starting EXPRESSION of type ARRAY_INDEX
#185 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #20]
	pop	{fp}
	push	{r0}
#186 End VARIABLE a, depth difference: 0, stack offset: 20
#187 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-8]
	pop	{fp}
	push	{r0}
#188 End VARIABLE i, depth difference: 0, stack offset: -8
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#189 Ending EXPRESSION of type ARRAY_INDEX
#190 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-4]
	pop	{fp}
	push	{r0}
#191 End VARIABLE temp, depth difference: 0, stack offset: -4
#192 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-16]
	pop	{fp}
	push	{r0}
#193 End VARIABLE k, depth difference: 0, stack offset: -16
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	pop	{r1}
	str	r1, [r0]
#194 End ASSIGNMENT_STATEMENT
#195 Starting ASSIGNMENT_STATEMENT
#196 Starting EXPRESSION of type +
#197 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-8]
	pop	{fp}
	push	{r0}
#198 End VARIABLE i, depth difference: 0, stack offset: -8
#199 Starting CONSTANT
	movw	r0, #:lower16:1
	movt	r0, #:upper16:1
	push	{r0}
#200 End CONSTANT
	pop	{r2}
	pop	{r1}
	add	r1, r1, r2
	push	{r1}
#201 Ending EXPRESSION of type +
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-8]
	mov	fp, r1
#202 End ASSIGNMENT_STATEMENT
	b	_if_5
_if_4:
#203 Starting IF_STATEMENT'
#204 Starting EXPRESSION of type <
#205 Starting EXPRESSION of type ARRAY_INDEX
#206 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #20]
	pop	{fp}
	push	{r0}
#207 End VARIABLE a, depth difference: 0, stack offset: 20
#208 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-12]
	pop	{fp}
	push	{r0}
#209 End VARIABLE j, depth difference: 0, stack offset: -12
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#210 Ending EXPRESSION of type ARRAY_INDEX
#211 Starting EXPRESSION of type ARRAY_INDEX
#212 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #20]
	pop	{fp}
	push	{r0}
#213 End VARIABLE a, depth difference: 0, stack offset: 20
#214 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-8]
	pop	{fp}
	push	{r0}
#215 End VARIABLE i, depth difference: 0, stack offset: -8
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#216 Ending EXPRESSION of type ARRAY_INDEX
	pop	{r3}
	pop	{r2}
	mov	r1, #0
	cmp	r2,r3
	movlt	 r1, #1
	push	{r1}
#217 Ending EXPRESSION of type <
	mov	r1, #0
	pop	{r2}
	cmp	r1,r2
	beq	_if_6
#218 Starting ASSIGNMENT_STATEMENT
#219 Starting EXPRESSION of type ARRAY_INDEX
#220 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #20]
	pop	{fp}
	push	{r0}
#221 End VARIABLE a, depth difference: 0, stack offset: 20
#222 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-12]
	pop	{fp}
	push	{r0}
#223 End VARIABLE j, depth difference: 0, stack offset: -12
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#224 Ending EXPRESSION of type ARRAY_INDEX
#225 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-4]
	pop	{fp}
	push	{r0}
#226 End VARIABLE temp, depth difference: 0, stack offset: -4
#227 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-16]
	pop	{fp}
	push	{r0}
#228 End VARIABLE k, depth difference: 0, stack offset: -16
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	pop	{r1}
	str	r1, [r0]
#229 End ASSIGNMENT_STATEMENT
#230 Starting ASSIGNMENT_STATEMENT
#231 Starting EXPRESSION of type +
#232 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-12]
	pop	{fp}
	push	{r0}
#233 End VARIABLE j, depth difference: 0, stack offset: -12
#234 Starting CONSTANT
	movw	r0, #:lower16:1
	movt	r0, #:upper16:1
	push	{r0}
#235 End CONSTANT
	pop	{r2}
	pop	{r1}
	add	r1, r1, r2
	push	{r1}
#236 Ending EXPRESSION of type +
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-12]
	mov	fp, r1
#237 End ASSIGNMENT_STATEMENT
	b	_if_7
_if_6:
#238 Starting ASSIGNMENT_STATEMENT
#239 Starting EXPRESSION of type ARRAY_INDEX
#240 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #20]
	pop	{fp}
	push	{r0}
#241 End VARIABLE a, depth difference: 0, stack offset: 20
#242 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-8]
	pop	{fp}
	push	{r0}
#243 End VARIABLE i, depth difference: 0, stack offset: -8
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#244 Ending EXPRESSION of type ARRAY_INDEX
#245 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-4]
	pop	{fp}
	push	{r0}
#246 End VARIABLE temp, depth difference: 0, stack offset: -4
#247 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-16]
	pop	{fp}
	push	{r0}
#248 End VARIABLE k, depth difference: 0, stack offset: -16
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	pop	{r1}
	str	r1, [r0]
#249 End ASSIGNMENT_STATEMENT
#250 Starting ASSIGNMENT_STATEMENT
#251 Starting EXPRESSION of type +
#252 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-8]
	pop	{fp}
	push	{r0}
#253 End VARIABLE i, depth difference: 0, stack offset: -8
#254 Starting CONSTANT
	movw	r0, #:lower16:1
	movt	r0, #:upper16:1
	push	{r0}
#255 End CONSTANT
	pop	{r2}
	pop	{r1}
	add	r1, r1, r2
	push	{r1}
#256 Ending EXPRESSION of type +
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-8]
	mov	fp, r1
#257 End ASSIGNMENT_STATEMENT
_if_7:
#258 End IF_STATEMENT
_if_5:
#259 End IF_STATEMENT
_if_3:
#260 End IF_STATEMENT
	ldr	r2, [fp, #-16]
	mov	r3, #1
	add	r2, r2, r3
	str	r2, [fp, #-16]
	b	_start_for_2
_end_for_2:
#261 End FOR_STATEMENT
#262 Starting DECLARATION: adding space on stack
	push	{r0}
#263 Ending DECLARATION
#264 Starting FOR_STATEMENT
#265 Starting ASSIGNMENT_STATEMENT
#266 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #16]
	pop	{fp}
	push	{r0}
#267 End VARIABLE start, depth difference: 0, stack offset: 16
	push	{fp}
	pop	{r1}
	pop	{r0}
	str	r0, [fp, #-20]
	mov	fp, r1
#268 End ASSIGNMENT_STATEMENT
_start_for_3:
#269 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #8]
	pop	{fp}
	push	{r0}
#270 End VARIABLE end, depth difference: 0, stack offset: 8
	ldr	r2, [fp, #-20]
	pop	{r3}
	cmp	r2,r3
    bge _end_for_3
#271 Starting ASSIGNMENT_STATEMENT
#272 Starting EXPRESSION of type ARRAY_INDEX
#273 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-4]
	pop	{fp}
	push	{r0}
#274 End VARIABLE temp, depth difference: 0, stack offset: -4
#275 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-20]
	pop	{fp}
	push	{r0}
#276 End VARIABLE n, depth difference: 0, stack offset: -20
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	ldr	r3, [r0]
	push	{r3}
#277 Ending EXPRESSION of type ARRAY_INDEX
#278 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #20]
	pop	{fp}
	push	{r0}
#279 End VARIABLE a, depth difference: 0, stack offset: 20
#280 Starting VARIABLE
	push	{fp}
	ldr	r0, [fp, #-20]
	pop	{fp}
	push	{r0}
#281 End VARIABLE n, depth difference: 0, stack offset: -20
	pop	{r0}
	pop	{r2}
	mov	r1, $4
	mul	r0,r0,r1
	add	r0, r0, r2
	pop	{r1}
	str	r1, [r0]
#282 End ASSIGNMENT_STATEMENT
	ldr	r2, [fp, #-20]
	mov	r3, #1
	add	r2, r2, r3
	str	r2, [fp, #-20]
	b	_start_for_3
_end_for_3:
#283 End FOR_STATEMENT
	mov	sp, fp
	pop	{fp}
	pop	{pc}
#284 Leaving FUNCTION (merge) with depth 2
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
#285 End PROGRAM
	mov	sp, fp
	pop	{fp}
	bl	exit
.end
