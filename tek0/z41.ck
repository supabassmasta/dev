class synt0 extends SYNT{


8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
SqrOsc s[synt_nb];
Gain final => outlet; .3 => final.gain;

inlet => detune[i] => s[i] => final;    1.001 => detune[i].gain;    .6 => s[i].gain; .9 => s[i].width; i++;  
inlet => detune[i] => s[i] => final;    .9995 => detune[i].gain;    .6 => s[i].gain; .9 => s[i].width; i++;  
inlet => detune[i] => s[i] => final;    1.002 => detune[i].gain;    .4 => s[i].gain; .9 => s[i].width; i++;  
inlet => detune[i] => s[i] => final;    1.9985 => detune[i].gain;    .4 => s[i].gain; .9 => s[i].width; i++;  


						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {	
							for (0 => int i; i <  synt_nb     ; i++) {
								0 => s[i].phase;
							}
							 
							
							}
} 


TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c 1//Z__" => t.seq;
.3 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();

STREV1 rev; // DUCKED
rev.connect(t $ ST, .4 /* mix */); 

while(1) {
	     100::ms => now;
}
 
