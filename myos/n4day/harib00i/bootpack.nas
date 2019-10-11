[FORMAT "WCOFF"]
[INSTRSET "i486p"]
[OPTIMIZE 1]
[OPTION 1]
[BITS 32]
	EXTERN	_io_hlt
	EXTERN	_io_load_eflags
	EXTERN	_io_cli
	EXTERN	_io_out8
	EXTERN	_io_store_eflags
[FILE "bootpack.c"]
[SECTION .text]
	GLOBAL	_HariMain
_HariMain:
	PUSH	EBP
	MOV	EBP,ESP
	CALL	_init_palette
	PUSH	171
	PUSH	319
	PUSH	0
	PUSH	0
	PUSH	14
	PUSH	320
	PUSH	655360
	CALL	_boxfill8
	PUSH	172
	PUSH	319
	PUSH	172
	PUSH	0
	PUSH	8
	PUSH	320
	PUSH	655360
	CALL	_boxfill8
	ADD	ESP,56
	PUSH	173
	PUSH	319
	PUSH	173
	PUSH	0
	PUSH	7
	PUSH	320
	PUSH	655360
	CALL	_boxfill8
	PUSH	199
	PUSH	319
	PUSH	172
	PUSH	0
	PUSH	8
	PUSH	320
	PUSH	655360
	CALL	_boxfill8
	ADD	ESP,56
	PUSH	176
	PUSH	59
	PUSH	176
	PUSH	3
	PUSH	7
	PUSH	320
	PUSH	655360
	CALL	_boxfill8
	PUSH	196
	PUSH	2
	PUSH	176
	PUSH	2
	PUSH	7
	PUSH	320
	PUSH	655360
	CALL	_boxfill8
	ADD	ESP,56
	PUSH	196
	PUSH	59
	PUSH	196
	PUSH	3
	PUSH	15
	PUSH	320
	PUSH	655360
	CALL	_boxfill8
	PUSH	195
	PUSH	59
	PUSH	177
	PUSH	59
	PUSH	15
	PUSH	320
	PUSH	655360
	CALL	_boxfill8
	ADD	ESP,56
	PUSH	197
	PUSH	59
	PUSH	197
	PUSH	2
	PUSH	0
	PUSH	320
	PUSH	655360
	CALL	_boxfill8
	PUSH	197
	PUSH	60
	PUSH	176
	PUSH	60
	PUSH	0
	PUSH	320
	PUSH	655360
	CALL	_boxfill8
	ADD	ESP,56
	PUSH	176
	PUSH	316
	PUSH	176
	PUSH	273
	PUSH	15
	PUSH	320
	PUSH	655360
	CALL	_boxfill8
	PUSH	196
	PUSH	273
	PUSH	177
	PUSH	273
	PUSH	15
	PUSH	320
	PUSH	655360
	CALL	_boxfill8
	ADD	ESP,56
	PUSH	197
	PUSH	316
	PUSH	197
	PUSH	273
	PUSH	7
	PUSH	320
	PUSH	655360
	CALL	_boxfill8
	PUSH	197
	PUSH	317
	PUSH	176
	PUSH	317
	PUSH	7
	PUSH	320
	PUSH	655360
	CALL	_boxfill8
	ADD	ESP,56
L2:
	CALL	_io_hlt
	JMP	L2
	GLOBAL	_boxfill8
_boxfill8:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	PUSH	EBX
	PUSH	ECX
	PUSH	ECX
	MOV	AL,BYTE [16+EBP]
	MOV	ECX,DWORD [24+EBP]
	MOV	EDI,DWORD [28+EBP]
	MOV	BYTE [-13+EBP],AL
	CMP	ECX,DWORD [32+EBP]
	JG	L17
	MOV	EBX,DWORD [12+EBP]
	IMUL	EBX,ECX
L15:
	MOV	EDX,DWORD [20+EBP]
	CMP	EDX,EDI
	JG	L19
	MOV	ESI,DWORD [8+EBP]
	ADD	ESI,EBX
	ADD	ESI,EDX
	MOV	DWORD [-20+EBP],ESI
L14:
	MOV	ESI,DWORD [-20+EBP]
	MOV	AL,BYTE [-13+EBP]
	INC	EDX
	MOV	BYTE [ESI],AL
	INC	ESI
	MOV	DWORD [-20+EBP],ESI
	CMP	EDX,EDI
	JLE	L14
L19:
	INC	ECX
	ADD	EBX,DWORD [12+EBP]
	CMP	ECX,DWORD [32+EBP]
	JLE	L15
L17:
	POP	EAX
	POP	EDX
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	RET
[SECTION .data]
_table_rgb.0:
	DB	0
	DB	0
	DB	0
	DB	-1
	DB	0
	DB	0
	DB	0
	DB	-1
	DB	0
	DB	-1
	DB	-1
	DB	0
	DB	0
	DB	0
	DB	-1
	DB	-1
	DB	0
	DB	-1
	DB	0
	DB	-1
	DB	-1
	DB	-1
	DB	-1
	DB	-1
	DB	-58
	DB	-58
	DB	-58
	DB	-124
	DB	0
	DB	0
	DB	0
	DB	-124
	DB	0
	DB	-124
	DB	-124
	DB	0
	DB	0
	DB	0
	DB	-124
	DB	-124
	DB	0
	DB	-124
	DB	0
	DB	-124
	DB	-124
	DB	-124
	DB	-124
	DB	-124
[SECTION .text]
	GLOBAL	_init_palette
_init_palette:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	_table_rgb.0
	PUSH	15
	PUSH	0
	CALL	_set_palette
	LEAVE
	RET
	GLOBAL	_set_palette
_set_palette:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	PUSH	EBX
	PUSH	ECX
	MOV	EBX,DWORD [8+EBP]
	MOV	EDI,DWORD [12+EBP]
	MOV	ESI,DWORD [16+EBP]
	CALL	_io_load_eflags
	MOV	DWORD [-16+EBP],EAX
	CALL	_io_cli
	PUSH	EBX
	PUSH	968
	CALL	_io_out8
	CMP	EBX,EDI
	POP	EAX
	POP	EDX
	JLE	L26
L28:
	MOV	EAX,DWORD [-16+EBP]
	MOV	DWORD [8+EBP],EAX
	LEA	ESP,DWORD [-12+EBP]
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	JMP	_io_store_eflags
L26:
	MOV	AL,BYTE [ESI]
	INC	EBX
	SHR	AL,2
	MOVZX	EAX,AL
	PUSH	EAX
	PUSH	969
	CALL	_io_out8
	MOV	AL,BYTE [1+ESI]
	SHR	AL,2
	MOVZX	EAX,AL
	PUSH	EAX
	PUSH	969
	CALL	_io_out8
	MOV	AL,BYTE [2+ESI]
	SHR	AL,2
	ADD	ESI,3
	MOVZX	EAX,AL
	PUSH	EAX
	PUSH	969
	CALL	_io_out8
	ADD	ESP,24
	CMP	EBX,EDI
	JLE	L26
	JMP	L28
