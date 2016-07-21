class synt0 extends SYNT{

		inlet => SinOsc s => ADSR a =>  outlet;		
				.2 => s.gain;
				a.set(1::ms, 15::ms, 0.000001, 10::ms);

				TriOsc t => ADSR amod => s;
				amod.set(1::ms, 10::ms, 0.000001, 10::ms);
				1000 => t.gain;			
				400 => t.freq;
						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {a.keyOn();		amod.keyOn();}
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); t.ion(); t.mix();t.dor();
t.aeo(); //t.phr();t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 }c}c}c _1_5 __4_ _2_2_ _46_ _71_5_" => t.seq;
 t.element_sync();
 
 // t.no_sync(); t.full_sync();     //t.print();
// t.mono() => dac; t.left() => dac.left; t.right() => dac.right; t.raw => dac;
t.mono() => global_mixer.line3;
t.go(); 

while(1) {
	     100::ms => now;
}
 
