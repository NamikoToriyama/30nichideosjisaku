[FORMAT "WCOFF"]
[INSTRSET "i486p"]
[OPTIMIZE 1]
[OPTION 1]
[BITS 32]
	EXTERN	_sprintf
	EXTERN	_io_hlt
	EXTERN	_io_load_eflags
	EXTERN	_io_cli
	EXTERN	_io_out8
	EXTERN	_io_store_eflags
	EXTERN	_hankaku
	EXTERN	_load_gdtr
	EXTERN	_load_idtr
[FILE "bootpack.c"]
[SECTION .data]
LC0:
	DB	"ToriN",0x00
LC1:
	DB	"Haribote OS.",0x00
LC2:
	DB	"(%d, %d)",0x00
[SECTION .text]
	GLOBAL	_HariMain
_HariMain:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	PUSH	EBX
	LEA	EBX,DWORD [-316+EBP]
	SUB	ESP,304
	CALL	_init_palette
	MOVSX	EAX,WORD [4086]
	PUSH	EAX
	MOVSX	EAX,WORD [4084]
	PUSH	EAX
	PUSH	DWORD [4088]
	CALL	_init_screen
	MOV	ECX,2
	MOVSX	EAX,WORD [4084]
	LEA	EDX,DWORD [-16+EAX]
	MOV	EAX,EDX
	CDQ
	IDIV	ECX
	MOVSX	EDX,WORD [4086]
	SUB	EDX,44
	MOV	EDI,EAX
	MOV	EAX,EDX
	PUSH	LC0
	CDQ
	IDIV	ECX
	PUSH	7
	MOV	ESI,EAX
	PUSH	8
	PUSH	8
	MOVSX	EAX,WORD [4084]
	PUSH	EAX
	PUSH	DWORD [4088]
	CALL	_putfonts8_asc
	ADD	ESP,36
	PUSH	LC1
	PUSH	0
	PUSH	31
	PUSH	31
	MOVSX	EAX,WORD [4084]
	PUSH	EAX
	PUSH	DWORD [4088]
	CALL	_putfonts8_asc
	PUSH	LC1
	PUSH	7
	PUSH	30
	PUSH	30
	MOVSX	EAX,WORD [4084]
	PUSH	EAX
	PUSH	DWORD [4088]
	CALL	_putfonts8_asc
	ADD	ESP,48
	PUSH	14
	PUSH	EBX
	CALL	_init_mouse_cursor8
	PUSH	16
	PUSH	EBX
	LEA	EBX,DWORD [-60+EBP]
	PUSH	ESI
	PUSH	EDI
	PUSH	16
	PUSH	16
	MOVSX	EAX,WORD [4084]
	PUSH	EAX
	PUSH	DWORD [4088]
	CALL	_putblock8_8
	ADD	ESP,40
	PUSH	ESI
	PUSH	EDI
	PUSH	LC2
	PUSH	EBX
	CALL	_sprintf
	PUSH	EBX
	PUSH	7
	PUSH	50
	PUSH	50
	MOVSX	EAX,WORD [4084]
	PUSH	EAX
	PUSH	DWORD [4088]
	CALL	_putfonts8_asc
	ADD	ESP,40
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
	GLOBAL	_init_screen
_init_screen:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	PUSH	EBX
	SUB	ESP,16
	MOV	EAX,DWORD [16+EBP]
	MOV	EDI,DWORD [12+EBP]
	SUB	EAX,29
	DEC	EDI
	PUSH	EAX
	PUSH	EDI
	PUSH	0
	PUSH	0
	PUSH	14
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	MOV	ESI,DWORD [16+EBP]
	SUB	ESI,28
	PUSH	ESI
	PUSH	EDI
	PUSH	ESI
	PUSH	0
	PUSH	8
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	MOV	EAX,DWORD [16+EBP]
	ADD	ESP,56
	SUB	EAX,27
	PUSH	EAX
	PUSH	EDI
	PUSH	EAX
	PUSH	0
	PUSH	7
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	MOV	EAX,DWORD [16+EBP]
	DEC	EAX
	PUSH	EAX
	PUSH	EDI
	PUSH	ESI
	PUSH	0
	PUSH	8
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	MOV	EAX,DWORD [16+EBP]
	ADD	ESP,56
	SUB	EAX,24
	MOV	DWORD [-16+EBP],EAX
	PUSH	EAX
	PUSH	59
	PUSH	EAX
	PUSH	3
	PUSH	7
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,4
	PUSH	EAX
	MOV	DWORD [-20+EBP],EAX
	PUSH	2
	PUSH	DWORD [-16+EBP]
	PUSH	2
	PUSH	7
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	ADD	ESP,56
	PUSH	DWORD [-20+EBP]
	PUSH	59
	PUSH	DWORD [-20+EBP]
	PUSH	3
	PUSH	15
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,5
	PUSH	EAX
	MOV	EAX,DWORD [16+EBP]
	PUSH	59
	SUB	EAX,23
	PUSH	EAX
	MOV	DWORD [-24+EBP],EAX
	PUSH	59
	PUSH	15
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	MOV	EBX,DWORD [16+EBP]
	ADD	ESP,56
	SUB	EBX,3
	PUSH	EBX
	PUSH	59
	PUSH	EBX
	PUSH	2
	PUSH	0
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	PUSH	EBX
	PUSH	60
	PUSH	DWORD [-16+EBP]
	PUSH	60
	PUSH	0
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	MOV	ESI,DWORD [12+EBP]
	ADD	ESP,56
	MOV	EAX,DWORD [12+EBP]
	PUSH	DWORD [-16+EBP]
	SUB	EAX,4
	SUB	ESI,47
	PUSH	EAX
	MOV	DWORD [-28+EBP],EAX
	PUSH	DWORD [-16+EBP]
	PUSH	ESI
	PUSH	15
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	PUSH	DWORD [-20+EBP]
	PUSH	ESI
	PUSH	DWORD [-24+EBP]
	PUSH	ESI
	PUSH	15
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	ADD	ESP,56
	PUSH	EBX
	PUSH	DWORD [-28+EBP]
	PUSH	EBX
	PUSH	ESI
	PUSH	7
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	MOV	EAX,DWORD [12+EBP]
	PUSH	EBX
	SUB	EAX,3
	PUSH	EAX
	PUSH	DWORD [-16+EBP]
	PUSH	EAX
	PUSH	7
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	LEA	ESP,DWORD [-12+EBP]
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
	JLE	L27
L29:
	MOV	EAX,DWORD [-16+EBP]
	MOV	DWORD [8+EBP],EAX
	LEA	ESP,DWORD [-12+EBP]
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	JMP	_io_store_eflags
L27:
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
	JLE	L27
	JMP	L29
	GLOBAL	_putfont8
_putfont8:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	XOR	ESI,ESI
	PUSH	EBX
	MOV	EDI,DWORD [28+EBP]
	MOV	BL,BYTE [24+EBP]
L43:
	MOV	EAX,DWORD [20+EBP]
	MOV	EDX,DWORD [16+EBP]
	ADD	EAX,ESI
	IMUL	EAX,DWORD [12+EBP]
	ADD	EAX,DWORD [8+EBP]
	LEA	ECX,DWORD [EDX+EAX*1]
	MOV	DL,BYTE [ESI+EDI*1]
	TEST	DL,DL
	JNS	L35
	MOV	BYTE [ECX],BL
L35:
	MOV	AL,DL
	AND	EAX,64
	TEST	AL,AL
	JE	L36
	MOV	BYTE [1+ECX],BL
L36:
	MOV	AL,DL
	AND	EAX,32
	TEST	AL,AL
	JE	L37
	MOV	BYTE [2+ECX],BL
L37:
	MOV	AL,DL
	AND	EAX,16
	TEST	AL,AL
	JE	L38
	MOV	BYTE [3+ECX],BL
L38:
	MOV	AL,DL
	AND	EAX,8
	TEST	AL,AL
	JE	L39
	MOV	BYTE [4+ECX],BL
L39:
	MOV	AL,DL
	AND	EAX,4
	TEST	AL,AL
	JE	L40
	MOV	BYTE [5+ECX],BL
L40:
	MOV	AL,DL
	AND	EAX,2
	TEST	AL,AL
	JE	L41
	MOV	BYTE [6+ECX],BL
L41:
	AND	EDX,1
	TEST	DL,DL
	JE	L33
	MOV	BYTE [7+ECX],BL
L33:
	INC	ESI
	CMP	ESI,15
	JLE	L43
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	RET
	GLOBAL	_putfonts8_asc
_putfonts8_asc:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	PUSH	EBX
	PUSH	EBX
	MOV	EBX,DWORD [28+EBP]
	MOV	AL,BYTE [24+EBP]
	MOV	BYTE [-13+EBP],AL
	MOV	ESI,DWORD [16+EBP]
	MOV	EDI,DWORD [20+EBP]
	CMP	BYTE [EBX],0
	JNE	L51
L53:
	LEA	ESP,DWORD [-12+EBP]
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	RET
L51:
	MOVZX	EAX,BYTE [EBX]
	SAL	EAX,4
	INC	EBX
	ADD	EAX,_hankaku
	PUSH	EAX
	MOVSX	EAX,BYTE [-13+EBP]
	PUSH	EAX
	PUSH	EDI
	PUSH	ESI
	ADD	ESI,8
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_putfont8
	ADD	ESP,24
	CMP	BYTE [EBX],0
	JNE	L51
	JMP	L53
[SECTION .data]
_cursor.1:
	DB	"**************.."
	DB	"*ooooooooooo*..."
	DB	"*oooooooooo*...."
	DB	"*ooooooooo*....."
	DB	"*oooooooo*......"
	DB	"*ooooooo*......."
	DB	"*ooooooo*......."
	DB	"*oooooooo*......"
	DB	"*oooo**ooo*....."
	DB	"*ooo*..*ooo*...."
	DB	"*oo*....*ooo*..."
	DB	"*o*......*ooo*.."
	DB	"**........*ooo*."
	DB	"*..........*ooo*"
	DB	"............*oo*"
	DB	".............***"
[SECTION .text]
	GLOBAL	_init_mouse_cursor8
_init_mouse_cursor8:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	PUSH	EBX
	XOR	EBX,EBX
	PUSH	EDI
	XOR	EDI,EDI
	MOV	AL,BYTE [12+EBP]
	MOV	ESI,DWORD [8+EBP]
	MOV	BYTE [-13+EBP],AL
L67:
	XOR	EDX,EDX
L66:
	LEA	EAX,DWORD [EDX+EDI*1]
	CMP	BYTE [_cursor.1+EAX],42
	JE	L72
L63:
	CMP	BYTE [_cursor.1+EAX],111
	JE	L73
L64:
	CMP	BYTE [_cursor.1+EAX],46
	JE	L74
L61:
	INC	EDX
	CMP	EDX,15
	JLE	L66
	INC	EBX
	ADD	EDI,16
	CMP	EBX,15
	JLE	L67
	POP	ESI
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	RET
L74:
	MOV	CL,BYTE [-13+EBP]
	MOV	BYTE [EAX+ESI*1],CL
	JMP	L61
L73:
	MOV	BYTE [EAX+ESI*1],7
	JMP	L64
L72:
	MOV	BYTE [EAX+ESI*1],0
	JMP	L63
	GLOBAL	_putblock8_8
_putblock8_8:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	XOR	ESI,ESI
	PUSH	EBX
	SUB	ESP,12
	CMP	ESI,DWORD [20+EBP]
	JGE	L87
	XOR	EDI,EDI
L85:
	XOR	EBX,EBX
	CMP	EBX,DWORD [16+EBP]
	JGE	L89
	MOV	EAX,DWORD [32+EBP]
	ADD	EAX,EDI
	MOV	DWORD [-20+EBP],EAX
L84:
	MOV	EAX,DWORD [28+EBP]
	MOV	EDX,DWORD [24+EBP]
	ADD	EAX,ESI
	ADD	EDX,EBX
	IMUL	EAX,DWORD [12+EBP]
	ADD	EAX,EDX
	MOV	ECX,DWORD [8+EBP]
	MOV	EDX,DWORD [-20+EBP]
	INC	EBX
	MOV	DL,BYTE [EDX]
	MOV	BYTE [EAX+ECX*1],DL
	INC	DWORD [-20+EBP]
	CMP	EBX,DWORD [16+EBP]
	JL	L84
L89:
	INC	ESI
	ADD	EDI,DWORD [36+EBP]
	CMP	ESI,DWORD [20+EBP]
	JL	L85
L87:
	ADD	ESP,12
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	RET
	GLOBAL	_init_gdtidt
_init_gdtidt:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	ESI
	PUSH	EBX
	MOV	ESI,2555904
	MOV	EBX,8191
L95:
	PUSH	0
	PUSH	0
	PUSH	0
	PUSH	ESI
	ADD	ESI,8
	CALL	_set_segmdesc
	ADD	ESP,16
	DEC	EBX
	JNS	L95
	PUSH	16530
	MOV	ESI,2553856
	PUSH	0
	MOV	EBX,255
	PUSH	-1
	PUSH	2555912
	CALL	_set_segmdesc
	PUSH	16538
	PUSH	2621440
	PUSH	524287
	PUSH	2555920
	CALL	_set_segmdesc
	ADD	ESP,32
	PUSH	2555904
	PUSH	65535
	CALL	_load_gdtr
	POP	EAX
	POP	EDX
L100:
	PUSH	0
	PUSH	0
	PUSH	0
	PUSH	ESI
	ADD	ESI,8
	CALL	_set_gatedesc
	ADD	ESP,16
	DEC	EBX
	JNS	L100
	PUSH	2553856
	PUSH	2047
	CALL	_load_idtr
	LEA	ESP,DWORD [-8+EBP]
	POP	EBX
	POP	ESI
	POP	EBP
	RET
	GLOBAL	_set_segmdesc
_set_segmdesc:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EBX
	MOV	EDX,DWORD [12+EBP]
	MOV	ECX,DWORD [16+EBP]
	MOV	EBX,DWORD [8+EBP]
	MOV	EAX,DWORD [20+EBP]
	CMP	EDX,1048575
	JBE	L106
	SHR	EDX,12
	OR	EAX,32768
L106:
	MOV	WORD [EBX],DX
	MOV	BYTE [5+EBX],AL
	SHR	EDX,16
	SAR	EAX,8
	AND	EDX,15
	MOV	WORD [2+EBX],CX
	AND	EAX,-16
	SAR	ECX,16
	OR	EDX,EAX
	MOV	BYTE [4+EBX],CL
	MOV	BYTE [6+EBX],DL
	SAR	ECX,8
	MOV	BYTE [7+EBX],CL
	POP	EBX
	POP	EBP
	RET
	GLOBAL	_set_gatedesc
_set_gatedesc:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EBX
	MOV	EDX,DWORD [8+EBP]
	MOV	EAX,DWORD [16+EBP]
	MOV	EBX,DWORD [20+EBP]
	MOV	ECX,DWORD [12+EBP]
	MOV	WORD [2+EDX],AX
	MOV	BYTE [5+EDX],BL
	MOV	WORD [EDX],CX
	MOV	EAX,EBX
	SAR	EAX,8
	SAR	ECX,16
	MOV	BYTE [4+EDX],AL
	MOV	WORD [6+EDX],CX
	POP	EBX
	POP	EBP
	RET
