class synt0 extends SYNT{

    inlet => TriOsc s => LPF filter =>  outlet;   

    // filter to add in graph:
    // LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
    Step base => Gain filter_freq => blackhole;
    Gain mod_out => Gain variable => filter_freq;
    SinOsc mod =>  mod_out; Step one => mod_out; 1=> one.next; .5 => mod_out.gain;

    // params
    4 => filter.Q;
    161 => base.next;
    551 => variable.gain;
    1::second / (data.tick * 4 ) => mod.freq;
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
        
        .88 => s.width;
        .5 => s.gain;

            fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {
            if (idx == 0) { if (sync_mod) { 0=> sync_mod; 0.75 => mod.phase; } }
            }
} 


TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" *2   1537" => t.seq;
.9 => t.gain;
// t.element_sync();//  t.no_sync();
t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
t.go(); 

while(1) {
       100::ms => now;
}
 
