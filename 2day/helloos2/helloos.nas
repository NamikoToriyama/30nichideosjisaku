; hello-os
; TAB=4

	ORG	0x7c00		;このプログラムがどこに読み込まれるか

; 以下は標準的なFAT12フォーマットフロッピーのための記述

	JMP	entry
	DB	0x90
	DB	0xeb, 0x4e, 0x90
	DB	"HELLOIPL"	;ブートセクタの名前を自由に書いて良い（８バイト）
	DW	512		;1セクタの大きさ（512にしなければならない）
	DB	1		;クラスタの大きさ
	DW	1		;FATがどこから始まるか(普通は１セクタ目から)
	DB	2		;FATの個数(2にしなければならない)
	DW	224		;ルートディレクトリ領域の大きさ
	DW	2880		;このドライブの大きさ
	DB	0xf0		;メディアのタイプ
	DW	9		;FAT領域の長さ
	DW	18		;1トラックに幾つのセクタがあるか
	DW	2		;ヘッドの数
	DD	0		;パーティションを使ってるかどうか
	DD	2880		;このドライブの大きさ
	DB	0,0,0x29	;?
	DD	0xffffffff	;シリアル番号
	DB	"HELLO-OS   "	;ディスクの名前
	DB	"FAT12   " 	;フォーマットの名前
	RESB    18	  	;とりあえず空けておく

;プログラム本体

entry:
	MOV	AX,0		;レジスタ初期化
	MOV	SS,AX
	MOV	SP,0x7c00
	MOV	DS,AX
	MOV	ES,AX

	MOV	SI,msg

putloop:
	MOV	AL,[SI]
	ADD	SI,1
	CMP	AL,0
	JE	fin
	MOV	AH,0x0e		;一文字表示ファンクション
	MOV	BX,15		;カラーコード
	INT	0x10		;ビデオBIOS呼び出し
	JMP	putloop

fin:
	HLT			;何かあるまでCPUを停止させる
	JMP	fin		;無限ループ

;メッセージ部分
msg:
	DB	0x0a, 0x0a	;改行を２つ
	DB	"hello! world"
	DB	0x0a
	DB	0

        RESB    0x7dfe-$         ;0x001feまで0x00を埋める命令

        DB      0x55, 0xaa

;以下はブートセクタ以外の部分の記述
        DB      0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
        RESB    4600
        DB      0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
        RESB    1469432
