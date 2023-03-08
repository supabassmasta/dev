class PSYBASSx extends SYNT{

    1 => own_adsr;
    

    inlet => PowerADSR padsrin => TriOsc s => LPF filter =>PowerADSR padsrout => outlet;   
    
    1.0 => s.width;

    .25 => padsrin.gain;
    padsrin.set(0::ms, data.tick  , .7 , 200::ms);
    padsrin.setCurves(.6, 7., .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave

    padsrout.set(1::ms, data.tick* 2/2, .000001 , 16 * 10::ms);
    padsrout.setCurves(.6, 2., .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 
        1.8 => s.gain;

    // Filter to add in graph
    // LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
    Step base => Gain filter_freq => blackhole;
    Step variable => PowerADSR padsr => filter_freq;

    // Params
    padsr.set(1::ms, data.tick / 2 , .0000001, data.tick / 4);
    padsr.setCurves(.3, 2.0, .5);
    1.2 => filter.Q;
    48 => base.next;
    250 => variable.next;

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


            fun void on()  {padsr.keyOn(); padsrin.keyOn(); padsrout.keyOn(); 0.5 => s.phase;}  fun void off() {padsr.keyOff(); padsrin.keyOff(); padsrout.keyOff(); }  fun void new_note(int idx)  {   } 0 => own_adsr;
} 

TONE t;
t.reg(PSYBASSx s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
//" ZYXWVU TSRQPON MLKJIHG FEDCBA0 1234567 89abcde fghijkl mnopqrs tuvwxyz"
//"1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567"
//5!6!7!9 !a!c!d_
//e!d!c!a !9!7!6_
 
"
*4
!5!6!5!6!5!6!5!6!7!9!7!9!7!9!7!9 !a!c!a!c!a!c!a!c!d!5!d!5!d!5!d!5
!e!d!e!d!e!d!e!d!c!a!c!a!c!a!c!a !9!7!9!7!9!7!9!7!6!e!6!e!6!e!6!e
:4
" => t.seq;
.5 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

t.print();

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 23* 10.0 /* freq */ , 1.1 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  

STOVERDRIVE stod;
stod.connect(last $ ST, 1.2 /* drive 1 == no drive, > 1 == drive */ ); stod $ ST @=> last; 

.8 => stod.gain;


//STCUTTER stcutter;
//"111*8 1_1_" => stcutter.t.seq;
//stcutter.connect(last, 3::ms /* attack */, 3::ms /* release */ );   stcutter $ ST @=> last; 


//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
