public class STCROSSOUT extends ST{

  ST IN;

  ST AUX;

  STADSR stadsr;
  stadsr.outl => outl;
  stadsr.outr => outr;

  STADSR stadsraux;
  stadsraux.left() => AUX.outl;
  stadsraux.right() => AUX.outr;

  fun void  go  (){ 


    stadsr.set(0::ms /* Attack */, 0::ms /* Decay */, 1.0 /* Sustain */, 0::ms /* Sustain dur */,  0::ms /* release */);
    stadsr.connect(IN $ ST); 
    stadsr.keyOn(); 

    stadsraux.set(0::ms /* Attack */, 0::ms /* Decay */, 1.0 /* Sustain */, 0::ms /* Sustain dur */,  100::ms/* release */);
    stadsraux.connect(IN $ ST);
    stadsraux.keyOff(); 

    1::samp => now;
  }

  fun void to_aux(dur d){ 
    stadsr.set(d /* Attack */, 0::ms /* Decay */, 1.0 /* Sustain */, 0::ms /* Sustain dur */,  d /* release */);
    stadsraux.set(d /* Attack */, 0::ms /* Decay */, 1.0 /* Sustain */, 0::ms /* Sustain dur */,  d/* release */);
    stadsr.keyOff(); 
    stadsraux.keyOn(); 
    <<<"ST CROSS OUT TO AUX">>>;
  } 

  fun void to_main(dur d){ 
    stadsr.set(d /* Attack */, 0::ms /* Decay */, 1.0 /* Sustain */, 0::ms /* Sustain dur */,  d /* release */);
    stadsraux.set(d /* Attack */, 0::ms /* Decay */, 1.0 /* Sustain */, 0::ms /* Sustain dur */,  d/* release */);
    stadsr.keyOn(); 
    stadsraux.keyOff(); 
    <<<"ST CROSS OUT TO MAIN">>>;
  } 

  fun void connect(ST @ tone) {
    tone.left() => IN.outl;
    tone.right() => IN.outr;
     
    spork ~   go (); 

  }

}


