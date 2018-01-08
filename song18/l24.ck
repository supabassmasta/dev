class SUPERSAW1 extends SYNT{

	8 => int synt_nb; 0 => int i;
	Gain detune[synt_nb];
	TriOsc s[synt_nb];
	Gain final => outlet; .15 => final.gain;

	.001 * 2 => float offset;
	fun float comp_detune(int i) {
		return i * offset- 0.1 + Math.random2f(-0.001, 0.001) ;

	}
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  



	// init width
	for (0 =>  i; i < detune.size()     ; i++) {
		0. => s[i].width;
	}
  /*
	fun void f1 (){ 

		while(1) {
			if (LPD8.k(2,1)< 130) {
				for (0 =>  i; i < detune.size()     ; i++) {
					LPD8.k(2,1) / (128. * 9.) => s[i].width;
				}
			}

			if (LPD8.k(2,2)< 130) {
				LPD8.k(2,2) / 10000. => offset;
				for (0 =>  i; i < detune.size()     ; i++) {
					1. + comp_detune(i) => detune[i].gain;
				}
			}


			100::ms => now;
		}
	} 
	spork ~ f1 ();
*/

	fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
} 

class SUPERSAW2 extends SYNT{

	8 => int synt_nb; 0 => int i;
	Gain detune[synt_nb];
	TriOsc s[synt_nb];
	Gain final => outlet; .15 => final.gain;

	.001 * 4 => float offset;
	fun float comp_detune(int i) {
		return i * offset- 0.1 + Math.random2f(-0.001, 0.001) ;

	}
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  


	// init width
	for (0 =>  i; i < detune.size()     ; i++) {
		0. => s[i].width;
	}

	fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
} 
class SUPERSAW3 extends SYNT{

	8 => int synt_nb; 0 => int i;
	Gain detune[synt_nb];
	TriOsc s[synt_nb];
	Gain final => outlet; .15 => final.gain;

	.001 * 9 => float offset;
	fun float comp_detune(int i) {
		return i * offset- 0.1 + Math.random2f(-0.001, 0.001) ;

	}
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  


	// init width
	for (0 =>  i; i < detune.size()     ; i++) {
		0. => s[i].width;
	}

	fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
} 
class SUPERSAW4 extends SYNT{

	8 => int synt_nb; 0 => int i;
	Gain detune[synt_nb];
	TriOsc s[synt_nb];
	Gain final => outlet; .15 => final.gain;

	.001 * 12 => float offset;
	fun float comp_detune(int i) {
		return i * offset- 0.1 + Math.random2f(-0.001, 0.001) ;

	}
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  


	// init width
	for (0 =>  i; i < detune.size()     ; i++) {
		0. => s[i].width;
	}

	fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
} 


class SUPERSAW5 extends SYNT{

	8 => int synt_nb; 0 => int i;
	Gain detune[synt_nb];
	TriOsc s[synt_nb];
	Gain final => outlet; .15 => final.gain;

	.001 * 14 => float offset;
	fun float comp_detune(int i) {
		return i * offset- 0.1 + Math.random2f(-0.001, 0.001) ;

	}
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  
	inlet => detune[i] => s[i] => final;    1. + comp_detune(i) => detune[i].gain;    .6 => s[i].gain; i++;  


	// init width
	for (0 =>  i; i < detune.size()     ; i++) {
		0. => s[i].width;
	}

	fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
} 

TONE t;
t.reg(SUPERSAW1 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4  {c ____ 8157 ____ ____
    1111 ____ ____ ____
    ____ 0c51 ____ ____
    1111 ____ ____ ____
" => t.seq;
1.5 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 


while(1) {
       100::ms => now;
}
 
