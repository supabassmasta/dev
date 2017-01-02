class synt0 extends SYNT{

		inlet => SinOsc s =>  outlet;		
				.7 => s.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c  111111111111" => t.seq;
// t.element_sync();//  t.no_sync();//  t.full_sync();     //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(200::ms, 10::ms, 1., 800::ms);
t.go(); 


//STREV1 rev;
//rev.connect(t $ ST, .3 /* mix */); 

STDUCK duck;
duck.connect(t $ ST); 




while(1) {
	     100::ms => now;
}
 
