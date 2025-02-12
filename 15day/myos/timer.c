/* �^�C�}�֌W */

#include "bootpack.h"

#define PIT_CTRL	0x0043
#define PIT_CNT0	0x0040

struct TIMERCTL timerctl;

#define TIMER_FLAGS_ALLOC		1	/* 確保した状態 */
#define TIMER_FLAGS_USING		2	/* タイマ作動中 */

void init_pit(void)
{
	int i;
	struct TIMER *t;
	io_out8(PIT_CTRL, 0x34);
	io_out8(PIT_CNT0, 0x9c);
	io_out8(PIT_CNT0, 0x2e);
	timerctl.count = 0;
	for (i = 0; i < MAX_TIMER; i++) {
		timerctl.timers0[i].flags = 0; /* 未使用 */
	}
	t = timer_alloc(); /* �������Ă��� */
	t->timeout = 0xffffffff; 
	t->flags = TIMER_FLAGS_USING;
	t->next = 0; /* ��Ԃ����� */
	timerctl.t0 = t; /* ���͔ԕ��������Ȃ��̂Ő擪�ł����� */
	timerctl.next = 0xffffffff; /* 最初は作動中のタイマがないため最大値 */
	return;
}

struct TIMER *timer_alloc(void)
{
	int i;
	for (i = 0; i < MAX_TIMER; i++) {
		if (timerctl.timers0[i].flags == 0) {
			timerctl.timers0[i].flags = TIMER_FLAGS_ALLOC;
			return &timerctl.timers0[i];
		}
	}
	return 0; /* 見つからなかった */
}

void timer_free(struct TIMER *timer)
{
	timer->flags = 0; /* 未使用 */
	return;
}

void timer_init(struct TIMER *timer, struct FIFO32 *fifo, int data)
{
	timer->fifo = fifo;
	timer->data = data;
	return;
}

void timer_settime(struct TIMER *timer, unsigned int timeout)
{
	int e;
	struct TIMER *t, *s;
	timer->timeout = timeout + timerctl.count;
	timer->flags = TIMER_FLAGS_USING;
	e = io_load_eflags();
	io_cli();
	t = timerctl.t0;	
	if (timer->timeout <= t->timeout) {
		/* 先頭に入れる場合 */
		timerctl.t0 = timer;
		timer->next = t; /* 次は */
		timerctl.next = timer->timeout;
		io_store_eflags(e);
		return;
	}
	/* どこに入れればいいかを探す */
	for (;;) {
		s = t;
		t = t->next;
		if (timer->timeout <= t->timeout) {
			/* sとの間に入れる場合 */
			s->next = timer; /* sの次はtimer */
			timer->next = t; /* timerの次はt */
			io_store_eflags(e);
			return;
		}
	}
}

void inthandler20(int *esp)
{
	char ts = 0;
	struct TIMER *timer;
	io_out8(PIC0_OCW2, 0x60);	/* IRQ-00受付完了をPICに通知 */
	timerctl.count++;
	if (timerctl.next > timerctl.count) {
		return; /* まだ次の処理になっていないので、おしまい、ほぼここで終わる*/
	}
	timer = timerctl.t0;

	for (;;) {
		/* timersのタイマは全て作動中のものなので、flagを確認しない */
		if (timer->timeout > timerctl.count) {
			break;
		}
		/* タイムアウト */
		timer->flags = TIMER_FLAGS_ALLOC;
		if (timer != mt_timer) {
			fifo32_put(timer->fifo, timer->data);
		} else {
			ts = 1; /* mt_timerがタイムアウトした */
		}
		timer = timer->next; /* 次のタイマの番地をtimerに代入 */
	}
	/* 新しいずらし */
	timerctl.t0 = timer;
	/* timerctl.nextの設定 */
	timerctl.next = timerctl.t0->timeout;
	if (ts != 0) {
		mt_taskswitch();
	}
	
	return;
}
