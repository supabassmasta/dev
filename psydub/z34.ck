class synt0 extends SYNT{

		inlet => TriOsc s => /* Gain fb =>  LPF filter => */  outlet;		
				.2 => s.gain;
//				.78 => s.width;
		// filter to add in graph:
		// LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
		Step base => Gain filter_freq => blackhole;
		Gain mod_out => Gain variable => filter_freq;
		SinOsc mod =>  mod_out; Step one => mod_out; 1=> one.next; .5 => mod_out.gain;

		// params
//		4 => filter.Q;
		.2 => base.next;
		.6 => variable.gain;
		1::second / (data.tick * 3 ) => mod.freq;
		// If mod need to be synced
		// 1 => int sync_mod;
		// if (idx == 0) { if (sync_mod) { 0=> sync_mod; 0.0 => mod.phase; } }

		fun void filter_freq_control (){ 
			    while(1) {
						      filter_freq.last() => s.width;
									      1::ms => now;
												    }
		}
		spork ~ filter_freq_control (); 



						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*2 15__ ____ ____ ____" => t.seq;
"   41__ ____ ____ ____" => t.seq;
"   15__ ____ ____ ___0" => t.seq;
"   1___ ____ 36__ ____" => t.seq;
"   15__ ____ ____ ____" => t.seq;
"   41__ ____ _8__ ____" => t.seq;
"   15__ ____ ____ ___0" => t.seq;
"   17__ ____ ____ ____" => t.seq;
.6 => t.gain;
t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
t.go(); 


STECHO ech;
ech.connect(t $ ST , data.tick * 1 / 1 , .9); 

ST st;

STAUTOPAN autopan;
autopan.connect(st $ ST, .9 /* span 0..1 */, 8*data.tick /* period */, 0.95 /* phase 0..1 */ );  

STDUCK duck;
duck.connect(autopan $ ST); 


ech.left() =>  LPF filter => st.outr => st.outl;
Step base => Gain filter_freq => blackhole;
Gain mod_out => Gain variable => filter_freq;
SinOsc mod =>  mod_out; Step one => mod_out; 1=> one.next; .5 => mod_out.gain;

// params
2 => filter.Q;
161 => base.next;
511 => variable.gain;
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






//STLPFC lpfc;
//lpfc.connect( ech $ ST , HW.lpd8.potar[2][5] /* freq */  , HW.lpd8.potar[2][6] /* Q */  );  

//STAUTOPAN autopan;
//autopan.connect(t $ ST, .6 /* span 0..1 */, 8*data.tick /* period */, 0.5 /* phase 0..1 */ );  

while(1) {
	     100::ms => now;
}
 

