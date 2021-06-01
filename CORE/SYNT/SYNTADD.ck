public class SYNTADD extends SYNT{
  SYNT @ syntl[0];
  1 => stereo;

  fun void  add(SYNT @ in, float g, float ifg) {
    if ( in.stereo  ){
      inlet => Gain i => in; 
      in.stout.left() => stout.outl;  in.stout.right() => stout.outr;
      g => in.stout.gain;
      ifg => i.gain;
      syntl << in;
    }
    else {
      inlet => Gain i => in => stout.outl;  in => stout.outr;
      g => in.outlet.gain;
      ifg => i.gain;
      syntl << in;
    }

  }

  fun void on()  { 
   for (0 => int i; i < syntl.size() ; i++) {
      syntl[i].on();
    }

  }

  fun void off() { 
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

0 => own_adsr;
} 
