class voidSYNT extends SYNT{
    inlet =>  outlet; 
} 

class autofreq extends Chugraph {
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
//autofreq a;"1//8" => a.seq;
//a.outlet =>  SinOsc sin0 =>  dac;
//a.go();
//10.0 => sin0.freq;
//0.2 => sin0.gain;

class AUTOX {
 static autofreq   a[0];
  fun static UGen freq (string s){
    a << new autofreq ;
    s => a[a.size()-1].seq;
   a[a.size()-1].go();
//a.outlet =>  SinOsc sin0 =>  dac;
//0.2 => sin0.gain;

//    while(1) {
//           100::ms => now;
//    }
     
    return a[a.size()-1].outlet;
  } 
}

fun UGen t (){
  SinOsc s;
600 => s.gain;
1=> s.freq;
  return s;

}

//AUTOX A;
//A.freq("1//f") =>  SinOsc sin0 =>  dac;
AUTOX.freq("1//8") =>  SinOsc sin0 =>  dac;
//t() =>  SinOsc sin0 =>  dac;
//10.0 => sin0.freq;
0.2 => sin0.gain;

AUTOX.freq("f/8") =>  SinOsc sin1 =>  dac;
0.2 => sin1.gain;


while(1) {
       100::ms => now;
}
 
