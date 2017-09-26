class synt0 extends SYNT{
    inlet => Gain in;
    Gain out => ResonZ filter => outlet;   
//LPF filter;
//    Gain out =>  outlet;   
// filter to add in graph:
// LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
Step base => Gain filter_freq => blackhole;
Gain mod_out => Gain variable => filter_freq;
SinOsc mod =>  mod_out; Step one => mod_out; 1=> one.next; .5 => mod_out.gain;

// params
1 => filter.Q;
261 => base.next;
551 => variable.gain;
1::second / (data.tick * 9 ) => mod.freq;
// If mod need to be synced
// 1 => int sync_mod;
// if (idx == 0) { if (sync_mod) { 0=> sync_mod; 0.0 => mod.phase; } }

fun void filter_freq_control (){ 
      while(1) {
              filter_freq.last() => filter.freq;
                    1::ms => now;
                        }
}
spork ~ filter_freq_control (); 


    0 => int i;
    Gain opin[8];
    Gain opout[8];
    PowerADSR adsrop[8];
    SinOsc osc[8];

    // build and config operators
    //---------------------
    opin[i] => osc[i] => adsrop[i] => opout[i];
    1. => opin[i].gain;
    adsrop[i].set(1::ms, 20::ms, .7 , 200::ms);
    adsrop[i].setCurves(.6, .4, .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
    1 => adsrop[i].gain;
    i++;

    //---------------------
    opin[i] => TriOsc tri => adsrop[i] => opout[i];
    .8 => tri.width;
    1./2. + 0.0 => opin[i].gain;
    adsrop[i].set(data.tick/2, 1.5*data.tick, .00001 , 200::ms);
    adsrop[i].setCurves(2., .2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
    .4 => adsrop[i].gain;
    i++;

    //---------------------
    opin[i] => osc[i] => adsrop[i] => opout[i];
    1./8. +0.0 => opin[i].gain;
    adsrop[i].set(data.tick/2, 186::ms, 1. , 1800::ms);
    adsrop[i].setCurves(2.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
    22 * 10 => adsrop[i].gain;
    i++;

    //---------------------
    opin[i] => osc[i] => adsrop[i] => opout[i];
    1./6. +0.000 => opin[i].gain;
    adsrop[i].set(data.tick/2, 186::ms, 1. , 400::ms);
    adsrop[i].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
    30 => adsrop[i].gain;
    i++;

    // connect operators
    // main osc
    in => opin[0]; opout[0]=> out; 

    // modulators
    in => opin[1];
    opout[1] => out;

    Step step => opin[2];
    .3 => step.next;
    opout[2] => opin[1];

    Step step2 => opin[3];
    .2 => step2.next;
    opout[3] => opin[1];


    .5 => out.gain;

    fun void on()  
    {
      for (0 => int i; i < 8      ; i++)
      {
            adsrop[i].keyOn();
                // 0=> osc[i].phase;
      }
            
    } 
        
        fun void off() 
        {
          for (0 => int i; i < 8      ; i++) 
          {
                adsrop[i].keyOff();
          }
                      
                                        
        } 
            
            fun void new_note(int idx)  
            { 
                         
            }
}  


TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; 
20::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
//"*6 (4!1)4!5" => t.seq;
"*6 !1!5" => t.seq;
.8 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(4::ms, 10::ms, .9, 400::ms);
t.adsr[0].setCurves(.4, 2.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go(); 

STAUTOPAN autopan2;
autopan2.connect(t $ ST, .2 /* span 0..1 */, data.tick/4 /* period */, 0.95 /* phase 0..1 */ );  
STAUTOPAN autopan;
autopan.connect(autopan2 $ ST, .7 /* span 0..1 */, 7*data.tick /* period */, 0.5 /* phase 0..1 */ );  

STREV1 rev;
rev.connect(autopan $ ST, .2 /* mix */); 

while(1) {
       100::ms => now;
}
 
