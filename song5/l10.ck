class synt0 extends SYNT{

    inlet => TriOsc s => LPF filter =>  outlet;   

    // Filter to add in graph
    // LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
    Step base => Gain filter_freq => blackhole;
    Step variable => PowerADSR padsr => filter_freq;

    // Params
    padsr.set(data.tick / 4 , data.tick / 4 , .0000001, data.tick / 4);
    padsr.setCurves(2.0, 2.0, .5);
    1 => filter.Q;
    48 => base.next;
    3300 => variable.next;
    
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
    
    


        .93 => s.width;
        .5 => s.gain;

            fun void on()  { }  fun void off() {padsr.keyOff(); }  fun void new_note(int idx)  { padsr.keyOn(); // spork ~ auto_off(); 
            }
} 


TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" *2  {c 11_5 __33 676_5757" => t.seq;
.9 => t.gain;
// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
t.go(); 

while(1) {
       100::ms => now;
}
 
