TONE t;
t.reg(SERUM00 s0);  //data.tick * 8 => t.max; 
60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(84 /* synt nb */ ); 
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c *2 5555/1 1111 3121 111_ 1111 333_ f181 B110" => t.seq;
1.7 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.set_adsrs(2::ms, 10::ms, .9, 400::ms);
t.set_adsrs_curves(.2, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 

STSYNCFILTERX stsynclpfx0; LPF_XFACTORY stsynclpfx0_fact;
stsynclpfx0.freq(32* 100 /* Base */, 53 * 100 /* Variable */, 2. /* Q */);
stsynclpfx0.adsr_set(.1 /* Relative Attack */, .2/* Relative Decay */, 0.8 /* Sustain */, .4 /* Relative Sustain dur */, 0.3 /* Relative release */);
stsynclpfx0.nio.padsr.setCurves(1.0, 1.2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpfx0.connect(last $ ST ,  stsynclpfx0_fact, t.note_info_tx_o , 2 /* order */, 1 /* channels */ , 1::ms /* period */ );       stsynclpfx0 $ ST @=>  last; 
// CONNECT THIS to play on freq target //     => stsynclpfx0.nio.padsr; 

STLHPFC lhpfc;
lhpfc.connect(last $ ST , HW.lpd8.potar[1][5] /* freq */  , HW.lpd8.potar[1][6] /* Q */  );       lhpfc $ ST @=>  last; 



class Dirtier extends Chugen
{
    1 => int first; 
    0 => int positive;
    36 => int winsize;
    0 => int cnt;

    fun float tick(float in)
    {   
      if ( first ){
          0=> first;
          if ( in > 0  ){
              1 => positive;
          }
          return 0;
      }

      if ( positive && in < 0.  ){
         0 => positive;
          winsize => cnt; // trig a window
      }
      else if ( !positive && in > 0.  ){
         1 => positive;
          winsize => cnt; // trig a window
      }
 
      if ( cnt  ){
          cnt--;
          return 1;
      }
      else{
        return 0;
      }
    }
}

ST st;

t.mono() => Dirtier dirt ;
MGAINC mgainc0; mgainc0.config( HW.lpd8.potar[1][1] /* gain */, .25 /* Static gain */ ); 
dirt => Gain g0 => mgainc0 =>  st.mono_in;  
3 => g0.op;

stgain.connect(st $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 


//37 * 0.001 => g0.gain;
// 3 => g0.op; //1+ 2- 3* 4/ 0 off -1 passthrough

//MGAINC mgainc1; mgainc1.config( HW.lpd8.potar[1][2] /* gain */, 63.0 /* Static gain */ ); 
//s0.inlet => mgainc1 =>  SinOsc sin0 => g0;    
s0.inlet => Gain g1 =>SERUM00 s1 => g0;  
//s1.config(86 /* synt nb */ ); 
s1.config(86 /* synt nb */ ); 
2*4.0001 => g1.gain;

//1 * 1000.0 => sin0.freq;
//1.0 => sin0.gain;

//t.mono() => dac;
//
while(1) {
       100::ms => now;
}
 
