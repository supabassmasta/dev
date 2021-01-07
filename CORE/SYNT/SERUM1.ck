public class SERUM1 extends SYNT{

  ADSR @ al[0];
  SERUM0 @ sl[0]; // to access synt after, to hack it

  fun void  add(int n, int k, float g, float ifg, dur  at, dur d, float su, dur r ){ 
    inlet => Gain i => SERUM0 s => ADSR a  => outlet; 
    g => s.outlet.gain;
    ifg => i.gain;
    s.config(n, k);
    a.set(at, d, su, r);
    al << a;
    sl << s;
  } 

  fun void on()  { 
    for (0 => int i; i < al.size() ; i++) {
      al[i].keyOn();
    }

  }

  fun void off() { 
    for (0 => int i; i < al.size() ; i++) {
      al[i].keyOff();
    }
  } 

  fun void new_note(int idx)  {
    on();  
  }

  1 => own_adsr;
} 


