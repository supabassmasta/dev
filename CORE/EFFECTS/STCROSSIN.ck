public class STCROSSIN extends ST {

  STADSR stadsr;
  stadsr.left() => outl;
  stadsr.right() => outr;

  STADSR stadsraux;
  stadsraux.left() => outl;
  stadsraux.right() => outr;

  fun void to_aux(dur d){ 
    stadsr.set(d /* Attack */, 0::ms /* Decay */, 1.0 /* Sustain */, 0::ms /* Sustain dur */,  d /* release */);
    stadsraux.set(d /* Attack */, 0::ms /* Decay */, 1.0 /* Sustain */, 0::ms /* Sustain dur */,  d/* release */);
    stadsr.keyOff(); 
    stadsraux.keyOn(); 
    <<<"ST CROSS IN TO AUX">>>;
  } 

  fun void to_main(dur d){ 
    stadsr.set(d /* Attack */, 0::ms /* Decay */, 1.0 /* Sustain */, 0::ms /* Sustain dur */,  d /* release */);
    stadsraux.set(d /* Attack */, 0::ms /* Decay */, 1.0 /* Sustain */, 0::ms /* Sustain dur */,  d/* release */);
    stadsr.keyOn(); 
    stadsraux.keyOff(); 
    <<<"ST CROSS IN TO MAIN">>>;
  } 

  fun void connect(ST @ main, ST @ aux) {

    stadsr.set(0::ms /* Attack */, 0::ms /* Decay */, 1.0 /* Sustain */, 0::ms /* Sustain dur */,  0::ms /* release */);
    stadsr.connect(main $ ST); 

    stadsraux.set(0::ms /* Attack */, 0::ms /* Decay */, 1.0 /* Sustain */, 0::ms /* Sustain dur */,  100::ms/* release */);
    stadsraux.connect(aux $ ST);

    stadsr.keyOn(); 
    stadsraux.keyOff(); 

  }

}
