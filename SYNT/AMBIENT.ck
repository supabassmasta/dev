public class AMBIENT extends SYNT{

		5=> int nb_samples;
		string c[nb_samples];
		SndBuf C[nb_samples];
		ADSR   a[nb_samples];
	 ADSR @  lasta;
		float  pitch[nb_samples];
		float  limits[nb_samples];

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
//				<<<"f", f>>>; 
				nb_samples-1 => index;
				while( f < limits[index] && index > 0 ) {
					  index -- ;	
				}
				index++;

//				<<<"index " , index>>>; 
				a[index] @=> lasta;
				a[index].keyOn();
				f / pitch[index] => float p;
				p => C[index].rate;
//				<<<"p", p>>>; 
				0=> C[index].pos; 
				 

		}

						fun void on()  {spork ~ play(); }	fun void off() { }	fun void new_note(int idx)  { 		}
}
