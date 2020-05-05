class synt0 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
Step det_amount[synt_nb];
SinOsc s[synt_nb];
Gain final => outlet; .3 => final.gain;

inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  0 => det_amount[i].next;      .6 => s[i].gain; i++;  
//inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -18.51 => det_amount[i].next;      .3 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  0.51 => det_amount[i].next;      .1 => s[i].gain; i++;   
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -1.51 => det_amount[i].next;      .1 => s[i].gain; i++;   
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  3.51 => det_amount[i].next;      .1 => s[i].gain; i++;   
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  5.51 => det_amount[i].next;      .1 => s[i].gain; i++;   
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -5.51 => det_amount[i].next;      .1 => s[i].gain; i++;   
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -3.51 => det_amount[i].next;      .1 => s[i].gain; i++;   

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
}


TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c}c  1" => t.seq;
.4 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .3 /* mix */, 20 * 10. /* room size */, 5::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
