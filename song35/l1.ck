class syntBW extends SYNT{
  float pluck;
  inlet => blackhole;
  BandedWG bwg => outlet;

//    Math.random2f( 0, 1 ) => bwg.bowRate;
//    Math.random2f( 0, 1 ) => bwg.bowPressure;
//    Math.random2f( 0, 1 ) => bwg.strikePosition;
//    Math.random2( 0, 3 ) => bwg.preset;

// 0 => bwg.preset;

//    3 => bwg.preset;
//    0.246798 => bwg.bowRate;
//    0.733152 => bwg.bowPressure;
//    0.746624 => bwg.strikePosition;

//  0 => bwg.preset;  
//  0.730914 => bwg.bowRate;  
//  0.510297 => bwg.bowPressure;  
//  97 * 0.001 => bwg.strikePosition; 
//  25 => bwg.gain;

//0 => bwg.preset;  
//0.754839 => bwg.bowRate;  
//0.739238 => bwg.bowPressure;  
//0.763381 => bwg.strikePosition;  

1 => bwg.preset;  
//    1.9 => s0.pluck;
0.692167 => bwg.bowRate;  
0.923691 => bwg.bowPressure;  
0.321358 => bwg.strikePosition;  

//2 => bwg.preset;  
//0.700376 => bwg.bowRate;  
//0.549689 => bwg.bowPressure;  
//0.231001 => bwg.strikePosition;  

//    <<< "---", "" >>>;
//    <<<  bwg.preset() + " => bwg.preset;", ""  >>>;    
//    <<<  bwg.bowRate()  + " => bwg.bowRate;", "" >>>;
//    <<<  bwg.bowPressure()  + " => bwg.bowPressure;", "" >>>;
//    <<<  bwg.strikePosition()  + " => bwg.strikePosition;", "" >>>;
//    <<< "---", "" >>>;

    fun void f1 (){ 
      1::samp => now;
      inlet.last() => bwg.freq;
          pluck => bwg.pluck;
//      1::samp => now;
       } 

        fun void on()  { }  fun void off() { } 
        fun void new_note(int idx)  { 
//          1::samp => now;
//          inlet.last() => bwg.freq;
//          .9 => bwg.pluck;
          spork ~ f1 ();
        }

        1 => own_adsr;
} 
class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; 
19::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor(); t.set_scale("dor");
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note, [] = note_offset_in_scale, ! = force new note , # = sharp , ^ = bemol  
"{c{3 *4 12345432" => t.seq;
2.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STDISTO stdisto;
stdisto.connect(last $ ST,3/*mode*/,3.0/*gain in*/,0/*dc blcok*/,0.1/*gain*/);       stdisto $ ST @=>  last;  

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 11* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

while(1) {
       100::ms => now;
}
 

