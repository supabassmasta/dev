class synt1 extends SYNT{

		inlet => SinOsc s =>  outlet;		
				.2 => s.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
} 

class synt0 extends SYNT{

		<<<"TATA">>>;		
		5=> int nb_samples;
		string c[nb_samples];
		SndBuf C[nb_samples];
		ADSR   a[nb_samples];
	 ADSR @  lasta;
		float  pitch[nb_samples];
		float  limits[nb_samples];
				<<<"TOIT1">>>; 

		0=>int i;
		Std.mtof(24) => pitch[i];Std.mtof(24+6)=> limits[i]; i++;
		Std.mtof(36) => pitch[i];Std.mtof(36+6)=> limits[i]; i++;
		Std.mtof(48) => pitch[i];Std.mtof(48+6)=> limits[i]; i++;
		Std.mtof(60) => pitch[i];Std.mtof(60+6)=> limits[i]; i++;
		Std.mtof(72) => pitch[i];Std.mtof(72+6)=> limits[i]; i++;

		
		for (0 => int i; i < nb_samples      ; i++) {
				<<<pitch[i], limits[i]>>>; 
		
		}
		 

		inlet => blackhole;
		Gain out => outlet;
		.4=> out.gain;
				<<<"TOIT3">>>; 

		fun void load() {
		for (0 => int i; i <  nb_samples     ; i++) {
			c[i] =>	C[i].read;
			C[i].samples() => C[i].pos;
			C[i] => a[i] => out;
			a[i].set(3::ms, 3::ms, 1. , 300::ms);
		}
		}
		 
		fun void  play() {
				if (lasta != NULL) {
						lasta.keyOff();
				}
			
				
				1::samp => now;

				inlet.last() => float f;
				
				0=>int index;
				<<<"f", f>>>; 
				nb_samples-1 => index;
				while( f < limits[index] && index > 0 ) {
					  index -- ;	
				}
				index++;

				<<<"index " , index>>>; 
				a[index] @=> lasta;
				a[index].keyOn();
				f / pitch[index] => float p;
				p => C[index].rate;
				<<<"p", p>>>; 
				0=> C[index].pos; 
				<<<"toto7">>>; 
				 

		}

						fun void on()  {spork ~ play(); }	fun void off() { }	fun void new_note(int idx)  { spork ~ play();		}
}
"../_SAMPLES/Progressive-Trance-Loops---Samples/Progressive_Trance_Loops_&_Samples/Ambient&Trance_Pads&Strings/WAV_Multisamples/AnaOrch/C" => string path;
synt0 s1;
synt0 s2;
synt0 s3;
synt0 s4;
for (0 => int i; i <  5     ; i++) {
  path + (i+1) +".wav" =>s1.c[i];
  path + (i+1) +".wav" =>s2.c[i];
  path + (i+1) +".wav" =>s3.c[i];
  path + (i+1) +".wav" =>s4.c[i];
	<<<s1.c[i]>>>; 
}
 
s1.load();
s2.load();
s3.load();
s4.load();


TONE t;
t.reg(s1);
t.reg(s2);
t.reg(s3);
t.reg(s4);
//data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":8 :2 }c 1|3|5|7" => t.seq;
.9 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go(); 

while(1) {
	     100::ms => now;
}
 
