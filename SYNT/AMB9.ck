public class AMB9 extends SYNT{

  AMBIENT2 s0;
  s0.load(10);

  inlet => Gain gin => s0  => ADSR a =>  outlet;   

  .7 => a.gain;
  a.set(2000::ms, 10::ms, 1., 4000::ms);

  1. => gin.gain;

  fun void on()  {s0.on(); a.keyOn(); }  fun void off() {s0.off(); a.keyOff(); }  fun void new_note(int idx)  {   } 

  1 => own_adsr;
} 


