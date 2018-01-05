class FROG0 extends SYNT{
 

  inlet => SqrOsc s =>  LPF filter => ADSR a => Gain fb => outlet;   
  a.set(1::ms, 0::ms, 1. , 1::ms);
  fb => Delay d => fb;
  data.tick * 3 / 4 => d.max => d.delay;
  .5 => d.gain; 

  .2 => s.gain;
  .4 => filter.gain;
  // filter to add in graph:
  // LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
  Step base => Gain filter_freq => blackhole;
  Gain mod_out => Gain variable => filter_freq;
  SinOsc mod =>  mod_out; Step one => mod_out; 1=> one.next; .5 => mod_out.gain;

  // params
  7 => filter.Q;
  3200 => base.next;
  6400 => variable.gain;
  1::second / (data.tick * 27 ) => mod.freq;
  // If mod need to be synced
  // 1 => int sync_mod;
  // if (idx == 0) { if (sync_mod) { 0=> sync_mod; 0.0 => mod.phase; } }

  fun void filter_freq_control (){ 
    while(1) {
      filter_freq.last() => filter.freq;
      1::ms => now;
    }
  }
  spork ~ filter_freq_control (); 



  fun void on()  { a.keyOn(); }  fun void off() {a.keyOff();  }  fun void new_note(int idx)  {   } 0 => own_adsr;

  1 => own_adsr;
} 


TONE t;
t.reg(FROG0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c {c {c *4 
____ 1/8_ _5/11/c_ ____
____ 11_1 ____ _R__
____ 15_6 _1r/Y_ __a/T_
____ 1A1T _D_1 __F_
" => t.seq;

.9 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//STFILTERMOD fmod;
//fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 7 /* Q */, 3200 /* f_base */ , 6400  /* f_var */, 1::second / ( 27* data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

//STECHO ech;
//ech.connect(last $ ST , data.tick * 3 / 4 , .5);  ech $ ST @=>  last;


while(1) {
       100::ms => now;
}
 
