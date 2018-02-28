class synt0 extends SYNT{

    inlet => SinOsc s => ABSaturator sat   => LPF filter => outlet;    
    .2 => sat.drive;
    0.3 => sat.dcOffset; 
        4.8 => s.gain;

    // Filter to add in graph
    // LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
    Step base => Gain filter_freq => blackhole;
    Step variable => PowerADSR padsr => filter_freq;

    // Params
    padsr.set(data.tick / 4 , data.tick / 4 , .9, data.tick / 4);
    padsr.setCurves(.7, 2.0, .5);
    1 => filter.Q;
    102 => base.next;
    50 => variable.next;

    // ADSR Trigger
    //padsr.keyOn(); padsr.keyOff();

    // fun void auto_off(){
      //     data.tick / 4 => now;
      //     padsr.keyOff();
      // }
      // spork ~ auto_off();

      fun void filter_freq_control (){ 
            while(1) {
                    filter_freq.last() => filter.freq;
                          1::ms => now;
                              }
      } 
      spork ~ filter_freq_control (); 

            fun void on()  { }  fun void off() {padsr.keyOff(); }  fun void new_note(int idx)  {padsr.keyOn();   }
} 
class synt1 extends SYNT{
    inlet => Gain in;
    Gain out =>  outlet;   

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
    opin[i] => osc[i] => adsrop[i] => opout[i];
    1./4. + 0.03 => opin[i].gain;
    adsrop[i].set(20::ms,20::ms, .00001 , 200::ms);
    adsrop[i].setCurves(.2, .2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
    33 * 1 => adsrop[i].gain;
    i++;

    //---------------------
    opin[i] => TriOsc tri => adsrop[i] => opout[i];
    1./5. +0.0 => opin[i].gain;
    adsrop[i].set(100::ms, 186::ms, 1. , 1800::ms);
    adsrop[i].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
    5 => adsrop[i].gain;
    .74 => tri.width;
    i++;

    //---------------------
    opin[i] => osc[i] => adsrop[i] => opout[i];
    1./2. +0.000 => opin[i].gain;
    adsrop[i].set(200::ms, 186::ms, 1. , 400::ms);
    adsrop[i].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
    1 => adsrop[i].gain;
    i++;

    // connect operators
    // main osc
    in => opin[0]; opout[0]=> out; 

    // modulators
    in => opin[1];
    opout[1] => opin[0];

    in => opin[2];
     opout[2] => opin[0];

    in => opin[3];
    opout[3] => out;// opout[3] => opin[0];


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
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c *4
111_ __1_ 555_ 333_
111_ 1_1_ 444_ 777_
111_ __1_ 855_ 333_
111_ 1_1_ 4_4_ 7_7_

111_ __1_ 555_ 333_
111_ 1_1_ 444_ 777_
111_ __1_ B55_ 333_
111_ 1_1_ 4_4_ 7_7_
" => t.seq;
1.9 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.adsr[0].set(6::ms, 100::ms, .7, 100::ms);
t.adsr[0].setCurves(1.0, 1.0, 2.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe 
t.go(); 

//STAUTOPAN autopan;
//autopan.connect(t $ ST, .4 /* span 0..1 */, data.tick / 12 /* period */, 0.95 /* phase 0..1 */ );  

//STREV1 rev;
//rev.connect(autopan $ ST, .1 /* mix */); 


while(1) {
       100::ms => now;
}
 
