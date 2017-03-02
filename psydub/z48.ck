class synt0 extends SYNT{

		 Noise s =>  outlet;		
		
				.5 => s.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"1" => t.seq;
.9 => t.gain;
// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
t.go(); 

STBPFC bpfc;
bpfc.connect(t $ ST , HW.lpd8.potar[1][2] /* freq */  , HW.lpd8.potar[1][3] /* Q */  );  

STECHO ech;
ech.connect(bpfc $ ST , data.tick * 1 / 1 , .6); 

STGAINC gainc;
gainc.connect(ech $ ST , HW.lpd8.potar[1][1] /* gain */  , 2. /* static gain */  );  

STREV1 rev;
rev.connect(gainc $ ST, .2 /* mix */);



while(1) {
	     100::ms => now;
}
 
