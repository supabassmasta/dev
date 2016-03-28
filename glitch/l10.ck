SEQ s;  
data.tick * 4 => s.max;  
SET_WAV.VOLCA(s);

// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"s" => s.seq;

s.element_sync(); //s.no_sync(); s.full_sync();     //s.print();


class synt0 extends SYNT{

		inlet => SinOsc s =>  outlet;		
				.4 => s.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
} 

TONE t;
//data.tick * 4 => t.max; 
t.reg(synt0 s1); 
t.reg(synt0 s2); 
t.adsr[0].set(1::ms, 30::ms, 0.0001 , 1::ms);
t.adsr[1].set(1::ms, 100::ms, 0.0001 , 1::ms);
//60::ms => t.glide;   
t.aeo();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" }c}c 1!5!7_" => t.seq;
 t.element_sync(); 

t.print();
.6 => float dry;

s.mono() => Gain g => Gain g_dac => dac;
g => Gain Gain_rev => GVerb gverb0  => dac;
dry => g_dac.gain;
1. - dry => Gain_rev.gain;


50 => gverb0.roomsize;        // roomsize: (float) [1.0 - 300.0], default 30.0   
5::second => gverb0.revtime;   // revtime: (dur), default 5::second
0.0 => gverb0.dry;             // dry (float) [0.0 - 1.0], default 0.6                
0.4 => gverb0.early;           // early (float) [0.0 - 1.0], default 0.4
0.5 => gverb0.tail;            // tail (float) [0.0 - 1.0], default 0.5       
 
 // s.left() => dac.left; s.right() => dac.right;
//s.go();	

 t.mono() => g;
t.go(); 


while(1) {
	     100::ms => now;
}
		
