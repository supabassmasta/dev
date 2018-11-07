class synt0 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
TriOsc s[synt_nb];
Gain final => outlet; .3 => final.gain;

inlet => detune[i] => s[i] => final;  .98 =>s[i].width;   1.0001 => detune[i].gain;    .6 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;  .98 =>s[i].width;   .9999 => detune[i].gain;    .6 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;  .98 =>s[i].width;   2.0001 => detune[i].gain;    .3 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;  .98 =>s[i].width;   1.9999 => detune[i].gain;    .3 => s[i].gain; i++;  
//inlet => detune[i] => s[i] => final;  .98 =>s[i].width;   1. => detune[i].gain;    .6 => s[i].gain; i++;  
//inlet => detune[i] => s[i] => final;  .98 =>s[i].width;   1. => detune[i].gain;    .6 => s[i].gain; i++;  


						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
} 


TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; 
//3::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" *4 

1// //8 1085
" => t.seq;




0.9 => t.gain;
// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   
//t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
t.go(); 

STECHO ech;
ech.connect(t $ ST , data.tick * 1 / 2 , .8); 

ST st;

// filter to add in graph:
// LPF filter =>   BPF filter =>   HPF filter => 
ech.mono() => BPF filter => st.mono_in;
Step base => Gain filter_freq => blackhole;
Gain mod_out => Gain variable => filter_freq;
SinOsc mod =>  mod_out; Step one => mod_out; 1=> one.next; .5 => mod_out.gain;

// params
4 => filter.Q;
161 => base.next;
1151 => variable.gain;
1::second / (data.tick * 8 ) => mod.freq;
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
autopan.connect(st $ ST, .7 /* span 0..1 */, 9*data.tick /* period */, 0.51 /* phase 0..1 */ ); autopan $ ST @=> ST last; 

 

STGAINC gainc;
gainc.connect(last $ ST , HW.lpd8.potar[1][1] /* gain */  , 3. /* static gain */  );       gainc $ ST @=>  last; 

while(1) {
	     100::ms => now;
}
 
