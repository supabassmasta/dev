SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); 
SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s); // "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*2 ____ ____ ____ ____   ____ ____ ____ ____
    ____ ____ ____ ____   ____ s___ ____ ____ 
		" => s.seq;
1.5 => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go(); 


STECHO ech;
ech.connect(s $ ST , data.tick * 3 / 4 , .85); 



ST st;

// filter to add in graph:
ech.mono() => LPF filter =>  st.mono_in;
 //BPF filter =>   HPF filter =>   BRF filter => 
Step base => Gain filter_freq => blackhole;
Gain mod_out => Gain variable => filter_freq;
SinOsc mod =>  mod_out; Step one => mod_out; 1=> one.next; .5 => mod_out.gain;

// params
2 => filter.Q;
261 => base.next;
634 => variable.gain;
1::second / (data.tick * 14 ) => mod.freq;
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

STAUTOPAN autopan;
autopan.connect(st $ ST, .9 /* span 0..1 */, .24*data.tick /* period */, 0.93 /* phase 0..1 */ );  

STREV1 rev;
rev.connect(autopan $ ST, .2 /* mix */); 

while(1) {
       100::ms => now;
}
 

