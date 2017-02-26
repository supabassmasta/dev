class synt0 extends SYNT{

		inlet => TriOsc s =>  outlet;		
				.5 => s.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*2 15__ ____ ____ ____" => t.seq;
"   41__ ____ ____ ____" => t.seq;
"   15__ ____ ____ ___0" => t.seq;
"   1___ ____ 36__ ____" => t.seq;
"   15__ ____ ____ ____" => t.seq;
"   41__ ____ _8__ ____" => t.seq;
"   15__ ____ ____ ___0" => t.seq;
"   17__ ____ ____ ____" => t.seq;
.6 => t.gain;
t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
t.go(); 


STECHO ech;
ech.connect(t $ ST , data.tick * 1 / 1 , .8); 

STLPFC lpfc;
lpfc.connect( ech $ ST , HW.lpd8.potar[2][5] /* freq */  , HW.lpd8.potar[2][6] /* Q */  );  

STAUTOPAN autopan;
autopan.connect(lpfc $ ST, .6 /* span 0..1 */, 8*data.tick /* period */, 0.5 /* phase 0..1 */ );  

while(1) {
	     100::ms => now;
}
 

