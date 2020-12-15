public class STCROSSOUT extends ST{

  ST IN;

  ST AUX;

  STADSR stadsr;
  stadsr.outl => outl;
  stadsr.outr => outr;

  STADSR stadsraux;
  stadsraux.left() => AUX.outl;
  stadsraux.right() => AUX.outr;

  fun void  go  (dur d){ 


    stadsr.set(0::ms /* Attack */, 0::ms /* Decay */, 1.0 /* Sustain */, 0::ms /* Sustain dur */,  d /* release */);
    stadsr.connect(IN $ ST); // stadsr  $ ST @=>  last; 
    stadsr.keyOn(); 

    stadsraux.set(d /* Attack */, 0::ms /* Decay */, 1.0 /* Sustain */, 0::ms /* Sustain dur */,  100::ms/* release */);
    stadsraux.connect(IN $ ST); // stadsraux  $ ST @=>  last; 
    stadsraux.keyOff(); 

    1::samp => now;
    stadsr.keyOff(); 
    stadsraux.keyOn(); 
    1::samp => now;
  } 


  fun void connect(ST @ tone, dur d) {
    tone.left() => IN.outl;
    tone.right() => IN.outr;
     
    spork ~   go (d); 

  }

}


