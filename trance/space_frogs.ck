class synt0 extends SYNT{

		inlet => Gain in => SqrOsc s => LPF lpf => Gain out =>  outlet;		
				.1 => s.gain;
				.25 => in.gain;
        1. => out.gain;


        <<<"______ SPACE FROGS 0 ____">>>; 
        <<<"______               ____">>>; 
        <<<"______ LPD8 :        ____">>>; 
        <<<"______ pot 1.1: GAIN ____">>>; 
        <<<"______ pot 1.1: IN FREQ _">>>; 
        <<<"______ pot 1.2: LPFFREQ _">>>; 
        <<<"______ pot 1.3: LPF Q ___">>>; 
        <<<"______ pot 1.4: SQR width">>>; 
        <<<"______               ____">>>; 
        <<<"______ SPACE FROGS 0 ____">>>; 

				fun void f1 (){ 
					while(1) {
						//	<<<"POT",LPD8.pot[0][0]>>>; 
						LPD8.pot[0][0] * 2 / 127. =>out.gain;	
						LPD8.pot[0][1] * 2 / 127. =>in.gain;	
						Std.mtof(LPD8.pot[0][2]) => lpf.freq;
						LPD8.pot[0][3] * 12. / 127. + 1. => lpf.Q;
						LPD8.pot[0][4] / 127. => s.width;	
						10::ms => now;
					}
 
			 } 
			 spork ~ f1 ();
			  

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
} 


TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*8 {c {c 11" => t.seq;
//"*8 {c {c 11__57_1AC_B 7531_ 8///1" => t.seq;
.9 => t.gain;
// t.element_sync();//  t.no_sync();//  t.full_sync();     //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
t.go(); 

STECHO ech;
ech.connect(t $ ST , 4 * data.tick / 4, .5); 

STREV1 rev;
rev.connect(ech $ ST, .4 /* mix */); 

while(1) {
	     100::ms => now;
}
 

