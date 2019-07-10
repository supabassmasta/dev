class STDELAY extends ST{
  Delay dl => outl;
  Delay dr => outr;

  1. => dl.gain => dr.gain;

  fun void connect(ST @ tone, float g, dur d) {
    tone.left() => dl;
    tone.right() => dr;

    g => dl.gain => dr.gain;
    d => dl.max => dr.max => dl.delay => dr.delay; 
  }

}

class STECHOHPF  extends ST{

  STSYNCRES stsynchpf;
  STADSR stadsr;
  STDELAY stdelay;

  stadsr.left() => outl;
  stadsr.right() => outr;

  // feedback path 
  stadsr.left() => stdelay.dl;
  stadsr.right() => stdelay.dr;


  fun void connect(ST @ tone ) {
    // Delay path
    tone.left() => outl;
    tone.right() => outr;
  }

}

SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); //
SET_WAV.DUB(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"
_s__
____
_y__
____
_v__
____
_f__
____
" => s.seq;
.9 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); // 
1::ms => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go();     s $ ST @=> ST @ last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 1 / 8 , .9);  ech $ ST @=>  last; 

STFILTERMOD fmod;
fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 600 /* f_base */ , 3400  /* f_var */, 1::second / (1.5 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 


STLIMITER stlimiter;
4. => float in_gainl;
stlimiter.connect(last $ ST , in_gainl /* in gain */, 1./in_gainl /* out gain */, 0.0 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stlimiter $ ST @=>  last;   



while(1) {
       100::ms => now;
}
 

