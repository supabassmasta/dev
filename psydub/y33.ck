class synt0 extends SYNT{

		inlet => TriOsc s =>  outlet;		
				.1 => s.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*21/m___" => t.seq;
// t.element_sync();//  
t.no_sync();//  t.full_sync();     //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
16 * data.tick => t.extra_end;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
t.go(); 

STECHO ech;
ech.connect(t $ ST ,  data.tick / 2, .8); 

16 * data.tick => now; 
//data.tick *8 => now;



