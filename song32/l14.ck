SEQ s;  //data.tick * 8 => s.max;  // 
SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.ACOUSTICTOM(s);// SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s); //SET_WAV.TRANCE_KICK(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"s" => s.seq;
.9 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate; // s.out("k") /* return ST */
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> ST @ last; 

class STLOSHELF extends ST{
ST @ last;
STGAIN stgain;

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;


  fun void connect(ST @ tone, float f, float q, int order, int channels, float g) {
    tone @=> last;

stlpfx0.connect(last $ ST ,  stlpfx0_fact,  f /* freq */ , q /* Q */ , order /* order */, channels /* channels */  );       stlpfx0 $ ST @=>  last;  

    g => stlpfx0.gain;

    stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last;
    stgain.connect(tone $ ST , 1. /* static gain */  );       stgain $ ST @=>  last;

    if (channels == 1 ){
      stgain.left() => outl;
      stgain.left() => outr;
      stgain.right() => Gain trash;
    }
    else {
      stgain.left() => outl;
      stgain.right() => outr;
    }

  }

}

STLOSHELF stloshelf0; 
stloshelf0.connect(last $ ST , 10 * 100 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */, 1.0 /* Gain */ );       stloshelf0 $ ST @=>  last;  

//.3 => stloshelf0.gain;

//STLIMITER stlimiter;
//3. => float in_gainl;
//stlimiter.connect(last $ ST , in_gainl /* in gain */, 1./in_gainl /* out gain */, 0.0 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stlimiter $ ST @=>  last;   


while(1) {
       100::ms => now;
}
 
