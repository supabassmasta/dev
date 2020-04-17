class synt0 extends SYNT{

    8 => int synt_nb; 0 => int i;
    Gain detune[synt_nb];
    Step det_amount[synt_nb];
    SinOsc s[synt_nb];
//    Gain final => outlet; .3 => final.gain;
    Gain final => SinOsc dist => outlet; .12 => final.gain;
    1 => dist.sync;

    inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  0 => det_amount[i].next;      .6 => s[i].gain; i++;  
    inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -4.51 => det_amount[i].next;      .1 => s[i].gain; i++;  
    inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  4.51 => det_amount[i].next;      .1 => s[i].gain; i++;   
    inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -5.51 => det_amount[i].next;      .1 => s[i].gain; i++;  
    inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  5.51 => det_amount[i].next;      .1 => s[i].gain; i++;   

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  
t.reg(synt0 s1);  
t.reg(synt0 s2);  
//data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":4 }c 
1|3|5 1|3|5 _ 2|4|7  ____
3|5|8 3|5|8 _ 0|2|4  ____
" => t.seq;
.4 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
8 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2* data.tick, 1 *data.tick, .8, 8*data.tick);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.adsr[1].set(2* data.tick, 1 *data.tick, .8, 8*data.tick);
t.adsr[1].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.adsr[2].set(2* data.tick, 1 *data.tick, .8, 8*data.tick);
t.adsr[2].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .2 /* mix */, 7 * 10. /* room size */, 6::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb $ ST @=>  last; 

STDUCK2 duck2;
duck2.connect(last $ ST, 8. /* Side Chain Gain */, .04 /* Tresh */, .5 /* Slope */, 10::ms /* Attack */, 50::ms /* Release */ );      duck2 $ ST @=>  last;  


while(1) {
       100::ms => now;
}
 
