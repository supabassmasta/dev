class voidSYNT extends SYNT{
    inlet =>  outlet; 
} 

// Gain synt 1 note is  0.0, 8 is 1.0
class gainSYNT extends SYNT{
    inlet => Gain minus => Gain fact => outlet; 
    
    1. => minus.gain;
    Step stp;
    Std.mtof(data.ref_note) => stp.next;
    stp => minus;
    2 => minus.op;

   1 / Std.mtof(data.ref_note)   => fact.gain;
   // <<<"fact.gain", fact.gain()>>>;

} 

// PAN synt 1 note is -1.0, 5 : 0.0, 8 :1.0
class panSYNT extends SYNT{
    inlet => Gain minus => Gain fact => Gain minus2 => outlet; 
    
    1. => minus.gain;
    Step stp;
    Std.mtof(data.ref_note) => stp.next;
    stp => minus;
    2 => minus.op;

    Step stp2;
    1 => stp2.next;
    stp2 => minus2;
    2 => minus2.op;

   2 / Std.mtof(data.ref_note)   => fact.gain;
   //<<<"fact.gain", fact.gain()>>>;
   
} 


class autofreq extends Chubgraph {
  string seq;

  TONE t;
  t.raw() => outlet;
  fun void  go  (){ 
     t.reg(voidSYNT s0);  

    t.dor();
    seq => t.seq;
    1. * data.master_gain => t.gain;
    1::samp => t.the_end.fixed_end_dur; 
    t.no_sync();
    1 => t.set_disconnect_mode;
    t.go();  
  } 

}

class autogain extends Chubgraph {
  string seq;

  TONE t;
  t.raw() => outlet;
  fun void  go  (){ 
     t.reg(gainSYNT s0);  

    t.dor();
    seq => t.seq;
    1. * data.master_gain => t.gain;
    1::samp => t.the_end.fixed_end_dur; 
    t.no_sync();
    1 => t.set_disconnect_mode;
    t.go();  
  } 

}

class autopan extends Chubgraph {
  string seq;

  TONE t;
  t.raw() => outlet;
  fun void  go  (){ 
     t.reg(panSYNT s0);  

    t.dor();
    seq => t.seq;
    1. * data.master_gain => t.gain;
    1::samp => t.the_end.fixed_end_dur; 
    t.no_sync();
    1 => t.set_disconnect_mode;
    t.go();  
  } 

}

public class AUTO {

  fun static UGen freq (string s){
    new autofreq @=> autofreq  @ a;
    s => a.seq;
    a.go();

    return a.outlet;
  } 

  fun static UGen gain (string s){
    new autogain @=> autogain  @ a;
    s => a.seq;
    a.go();

    return a.outlet;
  } 

  fun static UGen pan (string s){
    new autopan @=> autopan  @ a;
    s => a.seq;
    a.go();

    return a.outlet;
  } 

}


