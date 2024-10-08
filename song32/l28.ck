// Gain synt F note is -1, f : 1, 1 : 0
class gainSYNT extends SYNT{
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
   <<<"fact.gain", fact.gain()>>>;
   

fun void new_note(int idx)  { 
  <<<"NNNNNN">>>;
  }

} 

class autofreq extends Chubgraph {
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

fun UGen  AUTOGAIN(string s){
  new autofreq @=> autofreq  @ a;
  s => a.seq;
  a.go();
   
  return a.outlet;
} 

AUTOGAIN("5")=> Gain test => blackhole; 

//" ZYXWVU TSRQPON MLKJIHG FEDCBA0 1234567 89abcde fghijkl mnopqrs tuvwxyz"
//"1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567"
 

while(1) {
       100::ms => now;
<<<test.last()>>>;


}
 

