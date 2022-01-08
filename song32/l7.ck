// class SERUM01 extends SYNT{
// 
//   ADSR @ al[0];
//   SERUM00 @ sl[0]; // to access synt after, to hack it
//   SYNT @ syntl[0]; // to access synt after, to hack it
// 
//   fun void  add(int n, float g, float ifg, dur  at, dur d, float su, dur r ){ 
//     inlet => Gain i => SERUM00 s => ADSR a  => outlet; 
//     g => s.outlet.gain;
//     ifg => i.gain;
//     s.config(n);
//     a.set(at, d, su, r);
//     al << a;
//     sl << s;
//   } 
// 
//   fun void  add(SYNT @ in, float g, float ifg, dur  at, dur d, float su, dur r ){ 
//     inlet => Gain i => in => ADSR a  => outlet; 
//     g => in.outlet.gain;
//     ifg => i.gain;
//     a.set(at, d, su, r);
//     al << a;
//     syntl << in;
//   } 
// 
//   fun void on()  { 
//     for (0 => int i; i < al.size() ; i++) {
//       al[i].keyOn();
//     }
//     for (0 => int i; i < syntl.size() ; i++) {
//       syntl[i].on();
//     }
// 
//   }
// 
//   fun void off() { 
//     for (0 => int i; i < al.size() ; i++) {
//       al[i].keyOff();
//     }
//     for (0 => int i; i < syntl.size() ; i++) {
//       syntl[i].off();
//     }
//   } 
// 
//   fun void new_note(int idx)  {
//     on();  
//     for (0 => int i; i < syntl.size() ; i++) {
//       syntl[i].new_note(idx);
//     }
//   }
// 
//   1 => own_adsr;
// } 

TONE t;
t.reg(SERUM01 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
 NOISE0 synt0;
 s0.add(synt0 /* SYNT, to declare outside */, 1.4 /* GAIN */, 1.5 /* in freq gain */,  0 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 
s0.add(0 /* synt nb */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  2 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ );
s0.add(1 /* synt nb */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  3::ms /* attack */, 300::ms /* decay */, 0.0001 /* sustain */, 3* data.tick /* release */ );
// s0.add(synt0 /* SYNT, to declare outside */, 0.4 /* GAIN */, 1.5 /* in freq gain */,  0 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"1/////1 ___ ____ ____" => t.seq;
.05 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 60* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STLOSHELF stloshelf0; 
stloshelf0.connect(last $ ST , 10 * 100 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */, 2.0 /* Gain */ );       stloshelf0 $ ST @=>  last;   


STTOAUX sttoaux0; 
 // WARNING use it with option :   --out4 or more, else make the script crash
 sttoaux0.connect(last $ ST ,  1.0 /* gain to main */, 0.6  /* gain  to aux */, 1 /* st pair number */ ); sttoaux0 $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
