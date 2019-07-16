class filter0 extends SYNT{
  1::samp => dur refresh;

  inlet => blackhole;

  STLPF lpf;
  //    STWPDiodeLadder lpf;

  fun void f1 (){ 
    while(1) {
      inlet.last() => lpf.lpfl.freq =>  lpf.lpfr.freq;
      //        inlet.last() => lpf.lpfl.cutoff =>  lpf.lpfr.cutoff;
      refresh => now;
    }


  } 
  spork ~ f1 ();

  fun void  connect (ST @ in, float q){
    lpf.connect(in , 1000 /* freq */  , 1.0 /* Q */  );   
    q => lpf.lpfl.Q =>  lpf.lpfr.Q;
    //      lpf.connect(in , 1000 /* cutoff */  , 5. /* resonance */ , true /* nonlinear */, true /* nlp_type */  );   
    //      q => lpf.lpfl.resonance=>  lpf.lpfr.resonance;

  }


  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE tone_filter;
tone_filter.reg(filter0 filt0);  //data.tick * 8 => tone_filter.max; //60::ms => tone_filter.glide;  // tone_filter.lyd(); // tone_filter.ion(); // tone_filter.mix();// 
tone_filter.dor();// tone_filter.aeo(); // tone_filter.phr();// tone_filter.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*8 }c}c
____ ____  ____ ____  ____ ____  ____ ____  
d/1Z_1/d Z_G//Z  ____ d/1Z_1/d Z_G//Z ____  d/1Z_1/d Z_G//Z  
____ Z_d/1Z  ____ ____  ____ ____  ____ ____  
____ ____  ____ ____  B//cZB//cZB//cZB//cZB//cZ _  

____ ____  ____ ____  ____ ____  ____ ____  
____ ____  ____ ____  ____ ____  ____ ____  
____ ____  ____ ____  ____ ____  ___g/Z __g/Z_  
Z////1Z___    d////1 11Z_  1/dZ_d/1 Z_d/1Z  ____ ____  

" => tone_filter.seq;
.9 * data.master_gain => tone_filter.gain;
//tone_filter.sync(4*data.tick);// tone_filter.element_sync();//  tone_filter.no_sync();//  tone_filter.full_sync();  // 16 * data.tick => tone_filter.extra_end;   //tone_filter.print(); //tone_filter.force_off_action();
// tone_filter.mono() => dac;//  tone_filter.left() => dac.left; // tone_filter.right() => dac.right; // tone_filter.raw => dac;
tone_filter.adsr[0].set(20::ms, 0::ms, 1., 400::ms);
tone_filter.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
tone_filter.go();   tone_filter $ ST @=> ST @ last; 

//////////////////////////////////////////////
//            PUT YOUR SYNT/SEQ HERE :       //
//            Beware of "last" declaration  //


TONE t;
t.reg(SUPERSAW0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.mix();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*2
1851


" => t.seq;
0.5 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=>  last; 

STFLANGER flang;
flang.connect(last $ ST); flang $ ST @=>  last; 
flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  8::ms /* dur base */, 1::ms /* dur range */, 7 /* freq */); 
//flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  8::ms /* dur base */, 7::ms /* dur range */, 82 /* freq */); 


//////////////////////////////////////////////

filt0.connect(last, 2.0); filt0.lpf @=> last; 

STHPF hpf;
hpf.connect(last $ ST , 15* 10 /* freq */  , 1.0 /* Q */  );       hpf $ ST @=>  last; 

//STFILTERMOD fmod;
//fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 1600 /* f_base */ , 2400  /* f_var */, 1::second / (7 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .2);  ech $ ST @=>  last; 

STREV1 rev;
rev.connect(last $ ST, .1 /* mix */);     rev  $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
