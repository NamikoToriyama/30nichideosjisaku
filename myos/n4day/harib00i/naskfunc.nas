; naskfunc
; TAB=4

[FORMAT "WCOFF"]	;オブジェクトファイルを作るモード
[INSTRSET "i486p"]	;486命令まで使いたいという記述
[BITS 32]		;32ビットモード用の機械語を作らせる

;オブジェクトファイルのための情報
[FILE "naskfunc.nas"]	;ソースファイル名情報

;このプログラムに含まれる関数名
	GLOBAL _io_hlt, _io_cli, _io_sti, _io_stihlt
	GLOBAL _io_in8, _io_in16, _io_in32
	GLOBAL _io_out8, _io_out16, _io_out32
	GLOBAL _io_load_eflags, _io_store_eflags

;以下は実際の関数

[SECTION .text]		;オブジェクトファイルではこれを書いてからプログラムをかく

_io_hlt: 		;void io_hlt(void);
	HLT
	RET		;return

_io_cli:                ;void io_cli(void);
        CLI
        RET             ;return

_io_sti:                ;void io_sti(void);
        STI
        RET             ;return

_io_stihlt:		;void io_stihlt(void);
        STI
	HLT
        RET             ;return

_io_in8:                ;int  io_in8(void);
	MOV	EDX,[ESP+4] ;port
	MOV	EAX,0
	IN	AL,DX        
        RET             ;return

_io_in16:                ;int  io_in16(void);
        MOV     EDX,[ESP+4] ;port
        MOV     EAX,0
        IN      AX,DX
        RET             ;return

_io_in32:                ;int  io_in32(void);
        MOV     EDX,[ESP+4] ;port
        IN      EAX,DX
        RET             ;return

_io_out8:                ;int  io_out8(int port, int data);
        MOV     EDX,[ESP+4] ;port
        MOV     AL,[ESP+8]
        OUT     DX,AL
        RET             ;return

_io_out16:                ;int  io_out16(int port, int data);
        MOV     EDX,[ESP+4] ;port
        MOV     EAX,[ESP+8]
        OUT     DX,AX
        RET             ;return

_io_out32:                ;int  io_out32(int port, int data);
        MOV     EDX,[ESP+4] ;port
        MOV     EAX,[ESP+8]
        OUT      DX,EAX
        RET             ;return

_io_load_eflags:	;int io_load_eflags(void);
	PUSHFD	;PUSH EFLAGSという意味
	POP	EAX
	RET

_io_store_eflags:	;void io_store_eflags(int, eflags);
	MOV	EAX,[ESP+4]
	PUSH	EAX
	POPFD	; POP EFLAGSという意味
	RET


