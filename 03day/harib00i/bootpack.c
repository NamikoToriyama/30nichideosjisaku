void io_hlt(void);

void HariMain(void)
{

 fin:
  io_hlt(); // execute io_hlt in naskfunc.nas
  goto fin;
}
