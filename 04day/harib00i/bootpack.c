void io_hlt(void);
void io_cli(void);
void io_out8(int port, int data);
int io_load_eflags(void);
void io_store_eflags(int eflags);

/* 実は同じソースファイルに書いてあってソースファイルに書いてあっても定義する前に使うなら宣言する前に使うなら宣言する前に使うなら宣言する*/

void init_palette(void);
void set_palette(int start, int end, unsigned char *rgb);

#define COL8_000000 0
#define COL8_FF0000 1
#define COL8_00FF00 2
#define COL8_FFFF00 3
#define COL8_0000FF 4
#define COL8_FF00FF 5
#define COL8_00FFFF 6
#define COL8_FFFFFF 7
#define COL8_C6C6C6 8
#define COL8_840000 9
#define COL8_008400 10
#define COL8_848400 11
#define COL8_000084 12
#define COL8_840084 13
#define COL8_008484 14
#define COL8_848484 15

void HariMain(void)
{
	char *vram; // pという変数は、BYTE[...]用の番地
	int xsize, ysize;

	init_palette(); // パレット設定
	vram = (char*)0xa0000;
	xsize = 320;
	ysize = 200;

	boxfill8(vram, xsize, COL8_008484, 0, 0, xsize - 1, ysize - 29);
        boxfill8(vram, xsize, COL8_C6C6C6, 0, ysize - 28, xsize - 1, ysize - 28);
	boxfill8(vram, xsize, COL8_FFFFFF, 0, ysize - 27, xsize - 1, ysize - 27);
	boxfill8(vram, xsize, COL8_C6C6C6, 0, ysize - 28, xsize - 1, ysize - 1);

        boxfill8(vram, xsize, COL8_FFFFFF, 3, ysize - 24, 59, ysize - 24);
        boxfill8(vram, xsize, COL8_FFFFFF, 2, ysize - 24, 2, ysize - 4);
        boxfill8(vram, xsize, COL8_848484, 3, ysize - 4, 59, ysize - 4);
        boxfill8(vram, xsize, COL8_848484, 59, ysize - 23, 59, ysize - 5);
        boxfill8(vram, xsize, COL8_000000, 2, ysize - 3, 59, ysize - 3);
        boxfill8(vram, xsize, COL8_000000, 60, ysize - 24, 60, ysize - 3);
        
	boxfill8(vram, xsize, COL8_848484, xsize - 47, ysize - 24, xsize - 4, ysize - 24);
	boxfill8(vram, xsize, COL8_848484, xsize - 47, ysize - 23, xsize - 47, ysize - 4);
	boxfill8(vram, xsize, COL8_FFFFFF, xsize - 47, ysize - 3, xsize - 4, ysize - 3);
	boxfill8(vram, xsize, COL8_FFFFFF, xsize - 3, ysize - 24, xsize - 3, ysize - 3);

	/*	for( i = 0; i <= 0xffff; i++){
		p[i] = i & 0x0f;

	//これでwrite_mem8(i,i & 0x0f);の代わりになる
	}*/

	for(;;){
		io_hlt(); // execute io_hlt in naskfunc.nas
	}
}

void boxfill8(unsigned char *vram, int xsize, unsigned char c, int x0, int y0, int x1, int y1)
{
  int x,y;
  for(y = y0; y <= y1; y++){
    for(x = x0; x <= x1; x++){
      vram[y * xsize + x] = c;
    }
  }
  return;
}

void init_palette(void)
{
	static unsigned char table_rgb[16*3] = {
		0x00, 0x00, 0x00, // black
		0xff, 0x00, 0x00, // red
		0x00, 0xff, 0x00, // green
		0xff, 0xff, 0x00, // yellow
		0x00, 0x00, 0xff, // blue
		0xff, 0x00, 0xff, // purple
		0x00, 0xff, 0xff, // light_blue
		0xff, 0xff, 0xff, // white
		0xc6, 0xc6, 0xc6, // gray
		0x84, 0x00, 0x00, // dark_red
		0x00, 0x84, 0x00, // dark_green
		0x84, 0x84, 0x00, // dark_yellow
		0x00, 0x00, 0x84, // dark_blue
		0x84, 0x00, 0x84, // dark_purple
		0x00, 0x84, 0x84, // dark_light_blue
		0x84, 0x84, 0x84, // dark_gray
	};

	set_palette(0,15,table_rgb);
	return;
}


void set_palette(int start, int end, unsigned char *rgb)
{
	int i, eflags;
	eflags = io_load_eflags();
	io_cli();
	io_out8(0x03c8, start);
	for(i = start; i <= end; i++){
		io_out8(0x03c9, rgb[0] / 4);
		io_out8(0x03c9, rgb[1] / 4);
		io_out8(0x03c9, rgb[2] / 4);
		rgb += 3;	
	}
	io_store_eflags(eflags);
	return;
}
