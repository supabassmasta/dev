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

class STDISTOt extends ST{
  Distortion distl ;
  Distortion distr ;



  fun void connect(ST @ tone, int mode, float gain_in, int dc_block, int chan, float g) {
    if ( mode == -1  ){
       <<<"DISTO BYPASS">>>;
      tone.left() => outl;
      tone.right() => outr;

    }
    else {
      if ( chan == 1  ){
        tone.left() => distl;
        tone.right() => blackhole;
        distl  => outl;
        distl => outr;
      }
      else {
        tone.left() => distl;
        tone.right() => distr;
        distl  => outl;
        distr => outr;
      }

      dc_block => distl.dcBlock => distr.dcBlock;
      
      g => distl.gain => distr.gain;
      gain_in => distl.gainIn=> distr.gainIn;

      if ( mode == 0  ){
        .5 => distl.threshold=> distr.threshold;    
        distl.mode( Distortion.HARD_CLIP);distr.mode( Distortion.HARD_CLIP);
        <<<"DISTO HARD_CLIP, default\n.5 => stdisto.distl.threshold=> stdisto.distr.threshold;","">>>;
      }
      else if ( mode == 1  ){
        .5 => distl.threshold=> distr.threshold;    
        .8 => distl.knee=> distr.knee;    
        distl.mode( Distortion.SOFT_CLIP);distr.mode( Distortion.SOFT_CLIP);
        <<<"DISTO SOFT_CLIP, default\n.5 => stdisto.distl.threshold=> stdisto.distr.threshold;\n.8 => stdisto.distl.knee => stdisto.distr.knee;","">>>;
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
        .6 => distl.tone=> distr.tone;    
        .4 => distl.presence=> distr.presence;    
        distl.mode( Distortion.AMPSIM);distr.mode( Distortion.AMPSIM);
        <<<"DISTO AMPSIM, default\n.6 => stdisto.distl.tone=> stdisto.distr.tone;\n.4 => stdisto.distl.presence => stdisto.distr.presence;","">>>;
      }
      else if ( mode == 6  ){
        6.0 => distl.drive=> distr.drive;    
        .1 => distl.bias=> distr.bias;    
        distl.mode( Distortion.OVERDRIVE);distr.mode( Distortion.OVERDRIVE);
        <<<"DISTO OVERDRIVE, default\n6.0 => stdisto.distl.drive=> stdisto.distr.drive;\n.1 => stdisto.distl.bias => stdisto.distr.bias;","">>>;
      }
      else if ( mode == 7  ){
        .4 => distl.tone=> distr.tone;    
        distl.mode( Distortion.FUZZ);distr.mode( Distortion.FUZZ);
        <<<"DISTO FUZZ, default\n.4 => stdisto.distl.tone=> stdisto.distr.tone;\n","">>>;
      }
      else if ( mode == 8  ){
        4.0 => distl.bits=> distr.bits;    
        distl.mode( Distortion.BITCRUSH);distr.mode( Distortion.BITCRUSH);
        <<<"DISTO BITCRUSH, default\n4.0 => stdisto.distl.bits=> stdisto.distr.bits;\n","">>>;
      }
      else if ( mode == 9  ){
        1.5 => distl.shape=> distr.shape;    
        distl.mode( Distortion.WAVESHAPER);distr.mode( Distortion.WAVESHAPER);
        <<<"DISTO WAVESHAPER, default\n1.5 => stdisto.distl.shape=> stdisto.distr.shape;\n","">>>;
      }
      else if ( mode == 10  ){
        0.7 => distl.asymmetry=> distr.asymmetry;    
        distl.mode( Distortion.DIODE);distr.mode( Distortion.DIODE);
        <<<"DISTO DIODE, default\n0.7 => stdisto.distl.asymmetry=> stdisto.distr.asymmetry;\n","">>>;
      }
      else if ( mode == 11  ){
        10 => distl.slope=> distr.slope;    
        distl.mode( Distortion.SIGMOID);distr.mode( Distortion.SIGMOID);
        <<<"DISTO SIGMOID, default\n10 => stdisto.distl.slope=> stdisto.distr.slope;\n","">>>;
      }
      else if ( mode == 12  ){
        .5 => distl.threshold=> distr.threshold;    
        2.0 => distl.foldFreq=> distr.foldFreq;    
        distl.mode( Distortion.SINEFOLD);distr.mode( Distortion.SINEFOLD);
        <<<"DISTO SINEFOLD, default\n.5 => stdisto.distl.threshold=> stdisto.distr.threshold;\n2.0 => stdisto.distl.foldFreq => stdisto.distr.foldFreq;","">>>;
      }
      else if ( mode == 13  ){
        0.9 => distl.sampleHold=> distr.sampleHold;    
        distl.mode( Distortion.DECIMATOR);distr.mode( Distortion.DECIMATOR);
        <<<"DISTO DECIMATOR, default\n0.9 => stdisto.distl.sampleHold=> stdisto.distr.sampleHold;\n","">>>;
      }

    }

  }

}

STDISTOt stdisto;
stdisto.connect(last $ ST,3/*mode*/,3.0/*gain in*/,0/*dc blcok*/,2/*chan*/,0.1/*gain*/);       stdisto $ ST @=>  last; 
//0.0 => stdisto.distl.asymmetry=> stdisto.distr.asymmetry;

//7.5 => stdisto.distl.shape=> stdisto.distr.shape;
//6 => stdisto.distl.slope=> stdisto.distr.slope;

//.5 => stdisto.distl.threshold=> stdisto.distr.threshold;
//2.5 => stdisto.distl.foldFreq => stdisto.distr.foldFreq; 

.33 => stdisto.distl.bias=> stdisto.distr.bias;
.9 =>  stdisto.distl.warmth=>  stdisto.distr.warmth; 

//.5 => stdisto.distl.threshold=> stdisto.distr.threshold;
//.3 => stdisto.distl.threshold=> stdisto.distr.threshold;
//.9 => stdisto.distl.knee => stdisto.distr.knee;

//.6 => stdisto.distl.foldThreshold=> stdisto.distr.foldThreshold;  
//.3 => stdisto.distl.bias=> stdisto.distr.bias;
//.3 =>  stdisto.distl.warmth=>  stdisto.distr.warmth;
//9.0 => stdisto.distl.drive=> stdisto.distr.drive;  
//1.9 => stdisto.distl.tone=> stdisto.distr.tone;
//.8 => stdisto.distl.presence => stdisto.distr.presence;  
//6.0 => stdisto.distl.drive=> stdisto.distr.drive;
//.9 => stdisto.distl.bias => stdisto.distr.bias;  
//.1 => stdisto.distl.tone=> stdisto.distr.tone;

//6.0 => stdisto.distl.bits=> stdisto.distr.bits;
STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 11* 100.0 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

while(1) {
       100::ms => now;
}
 

