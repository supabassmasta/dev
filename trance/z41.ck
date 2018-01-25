class NOISE0 extends SYNT{

		inlet => SinOsc s =>  outlet;		
				.15 => s.gain;
		Noise n => Gain mult => s;
		3 => mult.op;
		inlet => Gain gn => mult;
		1.5 => gn.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		} 0 => own_adsr;
}

class NOISE1 extends SYNT{

		inlet => SinOsc s =>  outlet;		
				.3 => s.gain;
		Noise n => Gain mult => s;
		3 => mult.op;
		inlet => Gain gn => mult;
		1.8 => gn.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		} 0 => own_adsr;
}
class NOISE2 extends SYNT{

		inlet => SinOsc s =>  outlet;		
				.3 => s.gain;
		Noise n => Gain mult => s;
		3 => mult.op;
		inlet => Gain gn => mult;
		2.3 => gn.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		} 0 => own_adsr;
}

class NOISE3 extends SYNT{

		inlet => SinOsc s =>  outlet;		
				.3 => s.gain;
		Noise n => Gain mult => s;
		3 => mult.op;
		inlet => Gain gn => mult;
		2.9 => gn.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		} 0 => own_adsr;
}

class NOISE4 extends SYNT{

		inlet => SinOsc s =>  outlet;		
				.3 => s.gain;
		Noise n => Gain mult => s;
		3 => mult.op;
		inlet => Gain gn => mult;
		3.9 => gn.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		} 0 => own_adsr;
}

TONE t;
t.reg(NOISE0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" *4  
____ __z/M ____ ____ M/z 
____ ____G //// //// /z
____ __T/f ____ ____ e/D 
____ ____x //// //// /A

" => t.seq;
.9 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last;

////STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3/4 , .7);  ech $ ST @=>  last; 

while(1) {
	     100::ms => now;
}
 
