% hw4p3.m4: Diode als Konstantspannungsquelle

.PS
  cct_init
  scale = 25.6
  hlf = dimen_/2
  qrt = dimen_/4
  del = dimen_/3
  sex = dimen_/6

  VX: source(up_ elen_,V); llabel( ,V_X, );
  R1: resistor(right_ elen_,E); b_current(I_X); llabel( ,R_1, ); dot;
  D1: reversed(`diode',down_ elen_); llabel( ,D_1, ); dot;
  D2: diode(right_ elen_ from R1.end); llabel( ,D_2, );
  R2: resistor(down_ 0.5*elen_,E); llabel( ,R_2, );
  VB: reversed(`battery', down_ 0.5*elen_); llabel(+,V_B,-);
      line left to VX.start;
.PE
