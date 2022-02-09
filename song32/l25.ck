class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

class voidSYNT extends SYNT{
    inlet =>  outlet; 
fun void new_note(int idx)  { 
  <<<"NNNNNN">>>;
  }

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

fun UGen  AUTOFREQ(string s){
  new autofreq @=> autofreq  @ a;
  s => a.seq;
  a.go();
   
  return a.outlet;
} 

fun void f1 (){ 
AUTOFREQ("F//ff//F") => SinOsc sin0 => dac; 
0.2 => sin0.gain;
 
      3 * 1000::ms => now;
} 
spork ~ f1 ();

      4 * 1000::ms => now;


while(1) {
       1000::ms => now;

}
 

