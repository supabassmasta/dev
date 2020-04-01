class synt0 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
Step det_amount[synt_nb];
SERUM0 s[synt_nb];
Gain final => outlet; .3 => final.gain;

47 =>int  nb;
0 => int rk;

inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  0 => det_amount[i].next;      .6 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  -3.51 => det_amount[i].next;      .1 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  3.51 => det_amount[i].next;      .1 => s[i].gain; i++;   
inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  0 => det_amount[i].next; 2 => detune[i].gain;    .4 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  -4.51 => det_amount[i].next; 2 => detune[i].gain;    .1 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final; s[i].config(nb, rk); det_amount[i] => detune[i];  4.5 => det_amount[i].next; 2 => detune[i].gain;    .1 => s[i].gain; i++;  

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //
60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 }c

1532 ____ ____ ____
1532 ____ ____ ____
0423 ____ ____ ____ 
0423 ____ ____ ____ 
{c
4865 ____ ____ ____ 
4865 ____ ____ ____ 
5978 ____ ____ ____ 
5978 ____ ____ ____ 
" => t.seq;
.9 * data.master_gain => t.gain;
//
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 
8 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .6 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 4 / 4 , .9);  ech $ ST @=>  last; 


//STGVERB stgverb;
//stgverb.connect(last $ ST, .1 /* mix */, 5 * 10. /* room size */, 8::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb $ ST @=>  last; 

STEQ steq;
// steq.connect(last $ ST, HW.lpd8.potar[1][1] /* HPF freq */, HW.lpd8.potar[1][2] /* HPF Q */, HW.lpd8.potar[1][3] /* LPF freq */, HW.lpd8.potar[1][4] /* LPF Q */
//  , HW.lpd8.potar[1][5] /* BRF1 freq */, HW.lpd8.potar[1][6] /* BRF1 Q */, HW.lpd8.potar[1][7] /* BRF2 freq */, HW.lpd8.potar[1][8] /* BRF2 Q */
//   , HW.lpd8.potar[2][1] /* BPF1 freq */, HW.lpd8.potar[2][2] /* BPF1 Q */, HW.lpd8.potar[2][3] /* BPF1 Gain */
//    , HW.lpd8.potar[2][5] /* BPF2 freq */, HW.lpd8.potar[2][6] /* BPF2 Q */, HW.lpd8.potar[2][7] /* BPF2 Gain */
//     , HW.lpd8.potar[2][8] /* Output Gain */  ); steq $ ST @=>  last; 
steq.static_connect(last $ ST,  269.291780  /* HPF freq */,  1.000000  /* HPF Q */,  3419.792433  /* LPF freq */,  2.562500  /* LPF Q */
      ,  0.000000  /* BRF1 freq */,  1.000000  /* BRF1 Q */,  0.000000  /* BRF2 freq */,  1.000000  /* BRF2 Q */
      ,  1318.510228  /* BPF1 freq */,  2.666667  /* BPF1 Q */,  5.500000  /* BPF1 Gain */
      ,  0.000000  /* BPF2 freq */,  1.000000  /* BPF2 Q */,  0.000000   /* BPF2 Gain */
      ,  0.4  /* Output Gain */ ); steq $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
