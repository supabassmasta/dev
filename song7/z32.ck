class synt0 extends SYNT{

    inlet => TriOsc s =>  outlet;   
        .2 => s.gain;
        .66 => s.width;

            fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {   }
} 



TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*8 }c 1__5 81_0" => t.seq;
.7 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2::ms, 10::ms, 1., 4::ms); t.adsr[0].setCurves(.2, 2.0, .5);
t.go(); 

ST st;

t.mono() => LPF filter => st.mono_in;
// filter to add in graph:
// LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
Step base => Gain filter_freq => blackhole;
Gain mod_out => Gain variable => filter_freq;
SinOsc mod =>  mod_out; Step one => mod_out; 1=> one.next; .5 => mod_out.gain;

// params
4 => filter.Q;
161 => base.next;
751 => variable.gain;
1::second / (data.tick * 16 ) => mod.freq;
// If mod need to be synced
// 1 => int sync_mod;
// if (idx == 0) { if (sync_mod) { 0=> sync_mod; 0.0 => mod.phase; } }

fun void filter_freq_control (){ 
      0.75 => mod.phase;
      while(1) {
              filter_freq.last() => filter.freq;
                    1::ms => now;
                        }
}
spork ~ filter_freq_control (); 


STREV1 rev;
rev.connect(st $ ST, .2 /* mix */); 


while(1) {
       100::ms => now;
}
 

 
