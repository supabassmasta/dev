public class PLOC0 extends SYNT{
    1 => own_adsr;
    inlet => Gain gin =>SinOsc s =>  PowerADSR padsr => outlet;   
    4 => gin.gain;
    padsr.set(1::ms, 20::ms, .00001 , 200::ms);
    padsr.setCurves(.6, .4, .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
        .2 => s.gain;

            fun void on()  { }  fun void off() {padsr.keyOff(); }  fun void new_note(int idx)  { padsr.keyOn();  }
} 


