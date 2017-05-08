class synt0 extends SYNT{

		inlet => TriOsc s =>LPF filter =>  outlet;		
  	inlet => SqrOsc s2=> filter;
	  .3 => s.gain;
		.2 => s2.gain;	

	.99 => s.width;
	.85 => s2.width;


//		Noise n => s;
//		100 => n.gain;

		// Filter to add in graph
		// LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
		Step base => Gain filter_freq => blackhole;
		Step variable => PowerADSR padsr => filter_freq;

		// Params
		padsr.set(4::ms , data.tick / 4 , .0000001, data.tick / 4);
		padsr.setCurves(2.0, .4, .5);
		5 => filter.Q;
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

						fun void on()  { padsr.keyOn();}	fun void off() { padsr.keyOff(); }	fun void new_note(int idx)  {padsr.keyOn();		}
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 
__8_ ____ ____ ____
__8_ __8_ ____ ____
__8_ ____ ____ ____
__8_ __8_ __8_ 8////1
" => t.seq;
.11 => t.gain;
//t.sync(4*data.tick);
t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2::ms, 10::ms, 1., 400::ms);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go(); 

/*
ST st;

t.mono() => BPF filter => st.mono_in;
t.mono() => Gain direct => st.mono_in;
.3 => direct.gain;

// filter to add in graph:
// LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
Step base => Gain filter_freq => blackhole;
Gain mod_out => Gain variable => filter_freq;
SinOsc mod =>  mod_out; Step one => mod_out; 1=> one.next; .5 => mod_out.gain;

// params
3 => filter.Q;
161 => base.next;
2551 => variable.gain;
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



STDUCK duck;
duck.connect(st $ ST); 

STREV2 rev; // DUCKED
rev.connect(st $ ST, .3 ); 
*/

while(1) {
	     100::ms => now;
}
 

