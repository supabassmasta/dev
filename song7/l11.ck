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

		fun void load(int in) {
      "../_SAMPLES/Progressive-Trance-Loops---Samples/Progressive_Trance_Loops_&_Samples/Ambient&Trance_Pads&Strings/WAV_Multisamples/" => string path;
      //["Agitato/",    "AnaOrch/",  "Apollo/"] @=> string synt[];
      ["Agitato/","AnaOrch/","Apollo/","BigWave/","Breathchoir/","ClearBell/","ComeOnHigh/","DynaPWM/","FlangOrg/","GlassChoir/","HollowPad/","Mars/","Neptune/","Phasensemble/","SkyOrgan/","SoftString/","StereoString/","VelocityEns/","AnalogStr/","AnLayer/","BigStrings+/","BottledOut/","BriteString/","CloudNine/","Dreamsphere/","EnsembleMix/","FreezePad/","GlassMan/","Kemuri/","MellowStrings/","No.9String/","PulseString/","SmokePad/","Stalactite/","Telesa/"] @=> string synt[];

      if (in < synt.size()) {
        <<<"SYNT: " + synt[in]>>>; 
        for (0 => int i; i <  nb_samples     ; i++) {
          path + synt[in] + "C" + (i + 1) +".wav" => c[i];
          <<<c[i]>>>;
          c[i] =>	C[i].read;
          C[i].samples() => C[i].pos;
          C[i] => a[i] => out;
          a[i].set(3::ms, 3::ms, 1. , 300::ms);
        }
      }
      else {
        <<<"synt index too high">>>; 
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

						fun void on()  {spork ~ play(); }	fun void off() { }	fun void new_note(int idx)  { 		}
}
//"../_SAMPLES/Progressive-Trance-Loops---Samples/Progressive_Trance_Loops_&_Samples/Ambient&Trance_Pads&Strings/WAV_Multisamples/AnaOrch/C" => string path;
synt0 s1;
synt0 s2;
synt0 s3;
synt0 s4;
//for (0 => int i; i <  5     ; i++) {
//  path + (i+1) +".wav" =>s1.c[i];
//  path + (i+1) +".wav" =>s2.c[i];
//  path + (i+1) +".wav" =>s3.c[i];
//  path + (i+1) +".wav" =>s4.c[i];
//	<<<s1.c[i]>>>; 
//}
22 => int synt_nb; 
s1.load(synt_nb);
s2.load(synt_nb);
s3.load(synt_nb);
s4.load(synt_nb);


TONE t;
t.reg(s1);
t.reg(s2);
t.reg(s3);
t.reg(s4);
//data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":4  }c 1|3|5|7_" => t.seq;
.9 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(200::ms, 1000::ms, .7, 1400::ms);
t.adsr[1].set(200::ms, 1000::ms, .7, 1400::ms);
t.adsr[2].set(200::ms, 1000::ms, .7, 1400::ms);
t.adsr[3].set(200::ms, 1000::ms, .7, 1400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go(); 

while(1) {
	     100::ms => now;
}
 
