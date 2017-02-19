class synt0 extends SYNT{

		inlet => SinOsc s => NRev rev =>  outlet;		
				.5 => s.gain;
				0.06 => rev.mix;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); 
t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
t.reg(synt0 s2);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
t.reg(synt0 s3);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
t.reg(synt0 s4);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" }c}c :2  1 _|3|5  1|_|_|7  1|_|5|_  2|4|_|7" => t.seq;
.3 => t.gain;
// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(4000::ms, 0::ms, 1., 4000::ms);
t.adsr[1].set(4000::ms, 0::ms, 1., 4000::ms);
t.adsr[2].set(4000::ms, 100::ms, .6, 4000::ms);
t.adsr[3].set(4000::ms, 100::ms, .4, 4000::ms);
t.go(); 

STDUCK duck;
duck.connect(t $ ST); 


while(1) {
	     100::ms => now;
}
 
