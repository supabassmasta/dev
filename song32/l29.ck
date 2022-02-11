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

class AUTO {

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

ST st;

AUTO.freq("8") => SinOsc sin0 => MULT m => st.mono_in; 
0.2 => sin0.gain;

//AUTO.gain(":8:2 8/33/8") => m;

class STFREEPAN extends ST{
//  Gain gainl => outl;
//  Gain gainr => outr;

//  1. => gainl.gain => gainr.gain;

  Gain pan => OFFSET ofs0 => MULT ml => outl;
  1. => ofs0.offset;
  0.5 => ofs0.gain;

  pan => OFFSET ofs1 => MULT mr => outr;
  -1. => ofs1.offset;
  0.5 => ofs1.gain;


  fun void connect(ST @ tone) {
    tone.left() => ml;
    tone.right() => mr;
  }
}

//AUTO.pan(":2 8/11/8") => Gain pg => blackhole;
//2 => pg.gain;

STFREEPAN stfreepan;
stfreepan.connect(st);

//AUTO.pan(":2 8/11/8") => stfreepan.pan;
//Step s => stfreepan.pan;
//-1 => s.next;
SqrOsc sin1 =>  stfreepan.pan;
49.0 => sin1.freq;
0.1 => sin1.gain;

while(1) {
//    pg.last() => p.pan;
       1::samp => now;
}
 
 
