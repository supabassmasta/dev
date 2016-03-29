class synt0 extends SYNT{

		inlet => SinOsc s =>  outlet;		
				.2 => s.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); t.ion(); t.mix();t.dor();t.aeo(); t.phr();t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c}c 1!3!7_" => t.seq;
t.adsr[0].set(1::ms, 40::ms, 0.0001, 1::ms);

// t.element_sync(); t.no_sync(); t.full_sync();     //t.print();
 t.mono() => Gain g ; //=> dac; 
 g => Gain revg => global_mixer.rev1_left;		
.7 => revg.gain;
//t.left() => dac.left; t.right() => dac.right; t.raw => dac;
t.go(); 

while(1) {
	     100::ms => now;
}
 
