public class PLOC3 extends SYNT{
    1 => own_adsr;
    inlet => Gain gin =>TriOsc s=>   PowerADSR padsr => outlet;    
   .45 => s.width;
   4 => gin.gain;
    padsr.set(1::ms, 15::ms, .00001 , 200::ms);
    padsr.setCurves(.6, .4, .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
        .14 => s.gain;

            fun void on()  { }  fun void off() {padsr.keyOff(); }  fun void new_note(int idx)  { padsr.keyOn();  }
}


