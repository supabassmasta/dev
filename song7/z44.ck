class synt0 extends SYNT{

		inlet => blackhole;
		Impulse i => LPF lpf =>   outlet;		
				0.7 => i.gain;
				
				1800 => lpf.freq;
				4 => lpf.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  { 1=>i.next;		}
} 


AMBIENT s1;
s1.load(1);

TONE t;
//t.reg(s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
t.reg(synt0 s2);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*8  __}c}c}c1_
__5_9__0_9_1___5___0_4__________0__
13_19__0_9__{c_4_5_____4_}c0_0___0____8_
____________8_{c0_3______0_}c0_____5_1_

__5_9__0_9_1___5___0_4__________0__
13_19__0_9__{c_4_5_____4_}c0_0___0____8_
____________8_{c0_3______0_}c0_____5_1_


" => t.seq;
.7 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(10::ms, 40::ms, .04, 600::ms);
//t.adsr[0].setCurves(2.0, 3.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.adsr[0].set(1::ms, 7::ms, .9, 200::ms);
t.adsr[0].setCurves(2.0, 4.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go(); 
ST st;

t.mono() => GVerb gverb0  => st.mono_in;
100 => gverb0.roomsize;        // roomsize: (float) [1.0 - 300.0], default 30.0   
7::second => gverb0.revtime;   // revtime: (dur), default 5::second
0.5 => gverb0.dry;             // dry (float) [0.0 - 1.0], default 0.6                
0.1 => gverb0.early;           // early (float) [0.0 - 1.0], default 0.4
0.3 => gverb0.tail;            // tail (float) [0.0 - 1.0], default 0.5       


STAUTOPAN autopan;
autopan.connect(st $ ST, .9 /* span 0..1 */, 8*data.tick /* period */, 0.95 /* phase 0..1 */ );  


while(1) {
	     100::ms => now;
}
 



