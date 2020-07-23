SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 

ST st; st  @=>ST @  last;
SndBuf buf => PitShift p => st.mono_in;
"../../_SAMPLES/Aborigines/aboscream5.wav" => buf.read;
.25 => buf.gain;
0 => buf.pos;
//buf.samples() => buf.pos;
//147./105. => buf.rate;
//1./buf.rate() => p.shift;
//.65 => p.shift;
//1. => p.mix;

STEQ steq;
//steq.connect(last $ ST, HW.lpd8.potar[1][1] /* HPF freq */, HW.lpd8.potar[1][2] /* HPF Q */, HW.lpd8.potar[1][3] /* LPF freq */, HW.lpd8.potar[1][4] /* LPF Q */
// , HW.lpd8.potar[1][5] /* BRF1 freq */, HW.lpd8.potar[1][6] /* BRF1 Q */, HW.lpd8.potar[1][7] /* BRF2 freq */, HW.lpd8.potar[1][8] /* BRF2 Q */
//  , HW.lpd8.potar[2][1] /* BPF1 freq */, HW.lpd8.potar[2][2] /* BPF1 Q */, HW.lpd8.potar[2][3] /* BPF1 Gain */
//   , HW.lpd8.potar[2][5] /* BPF2 freq */, HW.lpd8.potar[2][6] /* BPF2 Q */, HW.lpd8.potar[2][7] /* BPF2 Gain */
//    , HW.lpd8.potar[2][8] /* Output Gain */  ); steq $ ST @=>  last; 
steq.static_connect(last $ ST,  900.569025  /* HPF freq */,  2.687500  /* HPF Q */,  4698.636287  /* LPF freq */,  1.000000  /* LPF Q */
      ,  6058.282118  /* BRF1 freq */,  1.000000  /* BRF1 Q */,  0.000000  /* BRF2 freq */,  1.000000  /* BRF2 Q */
      ,  3883.189454  /* BPF1 freq */,  6.666667  /* BPF1 Q */,  7.187500  /* BPF1 Gain */
      ,  0.000000  /* BPF2 freq */,  1.000000  /* BPF2 Q */,  0.000000   /* BPF2 Gain */
      ,  1.000000  /* Output Gain */ ); steq $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .1 /* mix */, 4 * 10. /* room size */, 1::second /* rev time */, 0.2 /* early */ , 0.4 /* tail */ ); stgverb $ ST @=>  last; 

//STECHO ech;
//ech.connect(last $ ST , data.tick * 3 / 4 , .5);  ech $ ST @=>  last; 

while(1) {
  32 * data.tick => now;
//  0 => buf.pos;
}
 

