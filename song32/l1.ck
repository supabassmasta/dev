TONE t;
t.reg(SERUM2 s0);  //data.tick * 8 => t.max; //
20::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(7 /* synt nb */ );
// s0.set_chunk(0); 

t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 1232 4534 5_34 2_0_" => t.seq;
.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STAUTOFILTERX stautoresx0; RES_XFACTORY stautoresx0_fact;
stautoresx0.connect(last $ ST ,  stautoresx0_fact, 2.0 /* Q */, 1 * 100 /* freq base */, 32 * 100 /* freq var */, data.tick * 27 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  

class STTOAUX extends ST{
  Gain gainl => outl;
  Gain gainr => outr;

  1. => gainl.gain => gainr.gain;

  fun void connect(ST @ tone, float g2main, float g2aux, int stnb) {
    // TO main
    tone.left() => gainl;
    tone.right() => gainr;
    g2main => gainl.gain => gainr.gain;

    // To AUX
    if (stnb != 0) {
      if ( stnb * 2 + 2 <= check_output_nb  ()  ){
        tone.left() => Gain auxl=> dac.chan(2*stnb);
        tone.right() => Gain auxr =>dac.chan(2*stnb + 1);
        g2aux => auxl.gain => auxr.gain;
      }
      else {
        <<<"ERROR:  STTOAUX, Not enough outputs to connect">>>;
      }
    }
    else {
      <<<"ERROR: STTOAUX, Stereo pair index 0 means main">>>;

    }
  }

  fun int check_output_nb  (){ 
     2 => int outnb; // By default assume there is two outputs

     FileIO fio;
     fio.open( "./output_numbers.txt", FileIO.READ );
     if( !fio.good() )
     {
        <<<"ERROR: STTOAUX: Can't open file output_numbers.txt in current dir">>>;
        <<<"                Assuming there is two outputs">>>;
        return 2;
     }

     fio => outnb;
     <<<"STTOAUX: output number: ", outnb>>>;
     return outnb;

  } 

}


STTOAUX sttoaux0; 
sttoaux0.connect(last $ ST ,  1.0 /* gain to main */, 0.3  /* gain  to aux */, 1 /* st pair number */ ); sttoaux0 $ ST @=>  last;


while(1) {
       100::ms => now;
}
 
