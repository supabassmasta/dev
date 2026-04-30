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

TONE t;
t.reg(PLOC0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor(); t.set_scale("dor");
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note, [] = note_offset_in_scale, ! = force new note , # = sharp , ^ = bemol  
"1__2__3_" => t.seq;
2.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

class STDISTO extends ST{
  Distortion distl  => outl;
  Distortion distr => outr;



  fun void connect(ST @ tone, int mode, float gain_in, float g) {
    if ( mode == -1  ){
       <<<"DISTO BYPASS">>>;
      tone.left() => outl;
      tone.right() => outr;

    }
    else {
      tone.left() => distl;
      tone.right() => distr;

      g => distl.gain => distr.gain;
      gain_in => distl.gainIn=> distr.gainIn;

      if ( mode == 0  ){
        .5 => distl.threshold=> distr.threshold;    
        distl.mode( Distortion.HARD_CLIP);distr.mode( Distortion.HARD_CLIP);
        <<<"DISTO HARD_CLIP, default\n.1 => stdisto.distl.threshold=> stdisto.distr.threshold;","">>>;
      }
      else if ( mode == 1  ){
        .5 => distl.threshold=> distr.threshold;    
        .8 => distl.knee=> distr.knee;    
        distl.mode( Distortion.SOFT_CLIP);distr.mode( Distortion.SOFT_CLIP);
        <<<"DISTO SOFT_CLIP, default\n.1 => stdisto.distl.threshold=> stdisto.distr.threshold;\n.8 => stdisto.distl.knee => stdisto.distr.knee;","">>>;
      }
      else if ( mode == 2  ){
        .4 => distl.foldThreshold=> distr.foldThreshold;    
        distl.mode( Distortion.FOLDBACK);distr.mode( Distortion.FOLDBACK);
        <<<"DISTO FOLDBACK, default\n.4 => stdisto.distl.foldThreshold=> stdisto.distr.foldThreshold;","">>>;
      }
      else if ( mode == 3  ){
        .15 => distl.bias=> distr.bias;    
        .6 => distl.warmth=> distr.warmth;    
        distl.mode( Distortion.TUBE);distr.mode( Distortion.TUBE);
        <<<"DISTO TUBE, default\n.15 => stdisto.distl.bias=> stdisto.distr.bias;\n.6 =>  stdisto.distl.warmth=>  stdisto.distr.warmth;","">>>;
      }
      else if ( mode == 4  ){
        8.0 => distl.drive=> distr.drive;    
        distl.mode( Distortion.ARCTANGENT);distr.mode( Distortion.ARCTANGENT);
        <<<"DISTO ARCTANGENT, default\n8.0 => stdisto.distl.drive=> stdisto.distr.drive;","">>>;
      }
      else if ( mode == 5  ){
        .6 => distl.threshold=> distr.threshold;    
        .4 => distl.presence=> distr.presence;    
        distl.mode( Distortion.AMPSIM);distr.mode( Distortion.AMPSIM);
        <<<"DISTO AMPSIM, default\n.6 => stdisto.distl.tone=> stdisto.distr.tone;\n.4 => stdisto.distl.presence => stdisto.distr.presence;","">>>;
      }
      else if ( mode == 6  ){
        6.0 => distl.drive=> distr.drive;    
        .1 => distl.bias=> distr.bias;    
        distl.mode( Distortion.OVERDRIVE);distr.mode( Distortion.OVERDRIVE);
        <<<"DISTO AMPSIM, default\n6.0 => stdisto.distl.drive=> stdisto.distr.drive;\n.1 => stdisto.distl.bias => stdisto.distr.bias;","">>>;
      }







    }


  }

}

STDISTO stdisto;
stdisto.connect(last $ ST,6/*mode*/,1.0/*gain in*/,1.0/* static gain */  );       stdisto $ ST @=>  last; 
//0.26 => stdisto.dist.threshold; 
//.9 => distl.threshold=> distr.threshold;
//.1 => stdisto.distl.threshold=> stdisto.distr.threshold;
//.7 => stdisto.distl.knee => stdisto.distr.knee;  

//.1 => stdisto.distl.foldThreshold=> stdisto.distr.foldThreshold;  
//.5 => stdisto.distl.threshold=> stdisto.distr.threshold;  
//12.0 => stdisto.distl.drive=> stdisto.distr.drive;
//.8 => stdisto.distl.tone=> stdisto.distr.tone;
//.8 => stdisto.distl.presence => stdisto.distr.presence;  
//6.0 => stdisto.distl.drive=> stdisto.distr.drive;
//.1 => stdisto.distl.bias => stdisto.distr.bias;
while(1) {
       100::ms => now;
}
 

