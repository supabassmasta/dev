fun  Gain  sin  (float g, float f, float o){ 
   SinOsc sin0 =>  OFFSET ofs0 => Gain out;
   o => ofs0.offset;
   1. => ofs0.gain;

   f => sin0.freq;
   g => sin0.gain;

   return out;
} 

fun Gain  offset (float o){ 
   OFFSET ofs0 => Gain out;
   o => ofs0.offset;
   1. => ofs0.gain;

  return out;
} 


class synt0 extends SYNT{


//80 => int conf; Theremin
57 => int conf;
1::ms => dur ut;


8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
Step det_amount[synt_nb];
SERUM3 s[synt_nb];
Gain final => outlet; .5 => final.gain;

inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  0 => det_amount[i].next;      .6 => s[i].gain;sin(.047,  .04 , .20) => s[i].in;  s[i].control_update(ut); s[i].config(conf /* synt nb */ );i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -3.51 => det_amount[i].next; .03 => s[i].gain;sin(.050,  .04 , .21) => s[i].in;  s[i].control_update(ut); s[i].config(conf /* synt nb */ );i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  4.53 => det_amount[i].next;  .04 => s[i].gain;sin(.027,  .04 , .22) => s[i].in;  s[i].control_update(ut); s[i].config(conf /* synt nb */ );i++;   
//                                                                                                               .6 => s[i].gain;sin(.052,  .4 , .23) => s[i].in;  s[i].control_update(ut); s[i].config(conf /* synt nb */ );






//8 => int synt_nb; 0 => int i;
//Gain detune[synt_nb];
//SERUM3 s[synt_nb];
//Gain final => outlet; .3 => final.gain;

//inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .6 => s[i].gain;sin(.1,  .4 , .2) => s[i].in;  s[i].control_update(ut); s[i].config(conf /* synt nb */ ); i++;  
//inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .6 => s[i].gain;sin(.1,  .4 , .2) => s[i].in;  s[i].control_update(ut); s[i].config(conf /* synt nb */ ); i++;  
//inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .6 => s[i].gain;sin(.1,  .4 , .2) => s[i].in;  s[i].control_update(ut); s[i].config(conf /* synt nb */ ); i++;  
//inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .6 => s[i].gain;sin(.1,  .4 , .2) => s[i].in;  s[i].control_update(ut); s[i].config(conf /* synt nb */ ); i++;  



//s0.config(86 /* synt nb */ );
//sin(.1,  .4 , .2) => s0.in; offset(.000) => s0.inlet; s0.control_update(10::ms); 
//s1.config(86 /* synt nb */ );
//sin(.1,  .4 , .2) => s1.in; offset(.1) => s1.inlet; s1.control_update(10::ms); 


        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 1 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//

//Noise n => s0.inlet;
//77 => n.gain;
// n => s1.inlet;


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c}c :4 :2 1|3_ 2|5_" => t.seq;
0.8 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 
0.01 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 13* 100.0 /* freq */ , 1.0 /* Q */ , 3 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STADSR stadsr;
stadsr.set(4 * data.tick  /* Attack */, 2 * data.tick  /* Decay */, 0.4 /* Sustain */, 2 * data.tick /* Sustain dur */,  4 * data.tick/* release */);
stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;
//stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff(); 

//STREV2 rev; // DUCKED
//rev.connect(last $ ST, .6 /* mix */);      rev $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .1 /* mix */, 7 * 10. /* room size */, 5::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
