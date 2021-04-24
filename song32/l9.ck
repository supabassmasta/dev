class synt0 extends SYNT{
  8 => int synt_nb; 0 => int i;
  Gain detune[synt_nb];
  SERUM0 s[synt_nb]; 
  Gain final => outlet; .3 => final.gain;

  0 => int n;
  0 => int k;

  inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .6 => s[i].gain;   s[i].config(n, k) ; i++;  
  inlet => detune[i] => s[i] => final;    1.001 => detune[i].gain;    .6 => s[i].gain;   s[i].config(n, k) ; i++;  
  inlet => detune[i] => s[i] => final;    1.002 => detune[i].gain;    .6 => s[i].gain;   s[i].config(n, k) ; i++;  
  inlet => detune[i] => s[i] => final;    1.003 => detune[i].gain;    .6 => s[i].gain;   s[i].config(n, k) ; i++;  
  inlet => detune[i] => s[i] => final;    0.999 => detune[i].gain;    .6 => s[i].gain;   s[i].config(n, k) ; i++;  
  inlet => detune[i] => s[i] => final;    0.998 => detune[i].gain;    .6 => s[i].gain;   s[i].config(n, k) ; i++;  
  inlet => detune[i] => s[i] => final;    0.997 => detune[i].gain;    .6 => s[i].gain;   s[i].config(n, k) ; i++;  
  inlet => detune[i] => s[i] => final;    0.996 => detune[i].gain;    .6 => s[i].gain;   s[i].config(n, k) ; i++;  

  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;

}  

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(synt0 s2);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(synt0 s3);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(synt0 s4);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*8 1|3|5|7|9___ ____ ____ ____" => t.seq;
.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.set_adsrs(1::ms, 10::ms, .9, 1::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


while(1) {
       100::ms => now;
}
 
