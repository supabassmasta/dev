class synt0 extends SYNT{

		inlet =>  TriOsc s =>LPF f2  =>  outlet;		
	inlet => Gain g => TriOsc s2 => f2; 
	inlet => Gain gs =>SinOsc sub => f2;
	1.7 => sub.gain;
	.5 => gs.gain;
	.007 => g.gain;
		1999 => f2.freq;
		2 => f2.Q;
		.83 => s.width;
		.81 => s2.width;
				.7 => s.gain;
				.7 => s2.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
}

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*2 {c 11__ 55_5 __5_ 111_ 11__ 5___ _8//1_ 1_1_" => t.seq;
.9 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2::ms, 60::ms, .9, 400::ms);
t.adsr[0].setCurves(.4, 3.0, 3.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();

STREV1 rev;
rev.connect(t $ ST, .03 /* mix */); 

while(1) {
	     100::ms => now;
}
 


