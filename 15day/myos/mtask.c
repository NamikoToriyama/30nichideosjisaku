/* �}���`�^�X�N�֌W */

#include "bootpack.h"

struct TIMER *mt_timer;
int mt_tr;

void mt_init(void)
{
	mt_timer = timer_alloc();
	/* timer_initは必要ないのでもうやらない */
	timer_settime(mt_timer, 2);
	mt_tr = 3 * 8;
	return;
}

void mt_taskswitch(void)
{
	if (mt_tr == 3 * 8) {
		mt_tr = 4 * 8;
	} else {
		mt_tr = 3 * 8;
	}
	// 0.02秒後にタイマーを用意
	timer_settime(mt_timer, 2);
	farjmp(0, mt_tr);
	return;
}
