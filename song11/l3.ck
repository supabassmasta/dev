class synt0 extends SYNT{

		inlet => LPF f => TriOsc s =>  outlet;		
		10 => f.freq;
		.4 => s.width;
				.5 => s.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
}

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 }c 1__41___14__12_8_" => t.seq;
.2 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();

ST st;
// filter to add in graph:
// LPF filter =>  
t.mono() => BPF filter => st.mono_in;
Step base => Gain filter_freq => blackhole;
Gain mod_out => Gain variable => filter_freq;
SinOsc mod =>  mod_out; Step one => mod_out; 1=> one.next; .5 => mod_out.gain;

// params
2 => filter.Q;
465 => base.next;
357 => variable.gain;
1::second / (data.tick * 13 ) => mod.freq;
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
autopan.connect(st $ ST, .9 /* span 0..0 */, 9*data.tick /* period */, 0.5 /* phase 0..1 */ );  

//STECHO ech;
//ech.connect(t $ ST , data.tick * 3 / 1 , .5); 
STDUCK duck;
duck.connect(autopan $ ST); 

STREV2 rev; // DUCKED
rev.connect(autopan $ ST, .2 /* mix */); 



while(1) {
	     100::ms => now;
}
 


