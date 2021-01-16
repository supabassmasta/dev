public class SERUM1 extends SYNT{

  ADSR @ al[0];
  SERUM0 @ sl[0]; // to access synt after, to hack it
  SYNT @ syntl[0]; // to access synt after, to hack it

  fun void  add(int n, int k, float g, float ifg, dur  at, dur d, float su, dur r ){ 
    inlet => Gain i => SERUM0 s => ADSR a  => outlet; 
    g => s.outlet.gain;
    ifg => i.gain;
    s.config(n, k);
    a.set(at, d, su, r);
    al << a;
    sl << s;
  } 

  fun void  add(SYNT @ in, float g, float ifg, dur  at, dur d, float su, dur r ){ 
    inlet => Gain i => in => ADSR a  => outlet; 
    g => in.outlet.gain;
    ifg => i.gain;
    a.set(at, d, su, r);
    al << a;
    syntl << in;
  } 

  fun void on()  { 
    for (0 => int i; i < al.size() ; i++) {
      al[i].keyOn();
    }
    for (0 => int i; i < syntl.size() ; i++) {
      syntl[i].on();
    }

  }

  fun void off() { 
    for (0 => int i; i < al.size() ; i++) {
      al[i].keyOff();
    }
    for (0 => int i; i < syntl.size() ; i++) {
      syntl[i].off();
    }
  } 

  fun void new_note(int idx)  {
    on();  
    for (0 => int i; i < syntl.size() ; i++) {
      syntl[i].new_note(idx);
    }
  }

  1 => own_adsr;
} 

