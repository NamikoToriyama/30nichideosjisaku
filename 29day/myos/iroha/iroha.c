#include "apilib.h"

void HariMain(void)
{
	static char s[9] = { 0xb2, 0xdb, 0xca, 0xc6, 0xce, 0xcd, 0xc4, 0x0a, 0x00 };
		/* 半角のいろはにほへとの文字コード+改行+0 */
	api_putstr0(s);
	api_end();
}
