class synt0 extends SYNT{

		inlet => SinOsc s =>  outlet;		
				.03 => s.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
t.reg(synt0 s2);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
t.reg(synt0 s3);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
t.reg(synt0 s4);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
t.reg(synt0 s5);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
t.reg(synt0 s6);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion();  
t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c 1|3|5|7" => t.seq;
// t.element_sync();//  t.no_sync();//  t.full_sync();     
t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(200::ms, 10::ms, 1., 800::ms);
t.adsr[1].set(200::ms, 10::ms, 1., 800::ms);
t.adsr[2].set(200::ms, 10::ms, 1., 800::ms);
t.adsr[3].set(200::ms, 10::ms, 1., 800::ms);
t.adsr[4].set(200::ms, 10::ms, 1., 800::ms);
t.adsr[5].set(200::ms, 10::ms, 1., 800::ms);
t.go(); 


STREV1 rev;
rev.connect(t $ ST, .5 /* mix */); 

STDUCK duck;
duck.connect(rev $ ST); 




while(1) {
	     100::ms => now;
}
 
