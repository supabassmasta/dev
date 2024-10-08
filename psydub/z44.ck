class synt0 extends SYNT{

		inlet => TriOsc s => LPF filter =>   outlet;		
  	.5 => s.gain;
		.77 => s.width;

		// filter to add in graph:
		// LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
		Step base => Gain filter_freq => blackhole;
		Gain mod_out => Gain variable => filter_freq;
		SinOsc mod =>  mod_out; Step one => mod_out; 1=> one.next; .5 => mod_out.gain;

		// params
		5 => filter.Q;
		461 => base.next;
		3502 => variable.gain;
		1::second / (data.tick * 7 ) => mod.freq;
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


						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
} 


TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c *4 1435 7260 1435 7260 1435 7260 1435 7260
 }7    1435 7260 1435 7260 1435 7260 1435 7260
 {5    1435 7260 1435 7260 1435 7260 1435 7260
 }2    1435 7260 1435 7260 1435 7260 1435 7260" => t.seq;




.03 => t.gain;
// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   
t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
t.go(); 

STAUTOPAN autopan;
autopan.connect(t $ ST, .6 /* span 0..1 */, 12*data.tick /* period */, 0.5 /* phase 0..1 */ );  

STDUCK duck;
duck.connect(autopan $ ST); 

STREV1 rev;
rev.connect(autopan $ ST, .1 /* mix */); 

while(1) {
	     100::ms => now;
}
 
