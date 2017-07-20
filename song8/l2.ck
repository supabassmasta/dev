class AMBIENT2 extends SYNT{

		5=> int nb_samples;
		string c[nb_samples];
		SndBuf C[2][nb_samples];
		ADSR   a[2][nb_samples];
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
		1.=> out.gain;

		fun void load(int in) {
      "../_SAMPLES/Progressive-Trance-Loops---Samples/Progressive_Trance_Loops_&_Samples/Ambient&Trance_Pads&Strings/WAV_Multisamples/" => string path;
      //["Agitato/",    "AnaOrch/",  "Apollo/"] @=> string synt[];
      ["Agitato/","AnaOrch/","Apollo/","BigWave/","Breathchoir/","ClearBell/","ComeOnHigh/","DynaPWM/","FlangOrg/","GlassChoir/","HollowPad/","Mars/","Neptune/","Phasensemble/","SkyOrgan/","SoftString/","StereoString/","VelocityEns/","AnalogStr/","AnLayer/","BigStrings+/","BottledOut/","BriteString/","CloudNine/","Dreamsphere/","EnsembleMix/","FreezePad/","GlassMan/","Kemuri/","MellowStrings/","No.9String/","PulseString/","SmokePad/","Stalactite/","Telesa/"] @=> string synt[];

      if (in < synt.size()) {
        <<<"SYNT: " + synt[in]>>>; 
        for (0 => int i; i <  nb_samples     ; i++) {
          path + synt[in] + "C" + (i + 1) +".wav" => c[i];
          <<<c[i]>>>;
          c[i] =>	C[0][i].read;
          c[i] =>	C[1][i].read;
          C[0][i].samples() => C[0][i].pos;
          C[1][i].samples() => C[1][i].pos;
          C[0][i] => a[0][i] => out;
          C[1][i] => a[1][i] => out;
          a[0][i].set(3::ms, 3::ms, 1. , 300::ms);
          a[1][i].set(3::ms, 3::ms, 1. , 300::ms);
        }
      }
      else {
        <<<"synt index too high">>>; 
      }
		}
		 
    // Double Sample index
    0 => int sidx;

    fun void switch_sidx() {
      if (sidx) 0 => sidx;
      else 1 => sidx;
    }

    fun int other_sidx() {
      if (sidx) return 0;
      else return 1;
    }

		0=>int index;

    0=>int stopped;
		fun void  play() {
		    // Off last
        a[sidx][index].keyOff();
			  if (stopped) {
           //immediate stop last one
           C[sidx][index].samples() => C[sidx][index].pos;
           0 => stopped;
        }

        1::samp => now;

        switch_sidx();

				inlet.last() => float f;
				
//				<<<"f", f>>>; 
				nb_samples-1 => index;
				while( f < limits[index] && index > 0 ) {
					  index -- ;	
				}
				index++;

//				<<<"index " , index>>>; 
				f / pitch[index] => float p;
				p => C[sidx][index].rate;
//				<<<"p", p>>>; 
				0=> C[sidx][index].pos; 
				a[sidx][index].keyOn();
				 

		}
		
    fun void  stopa() {
            <<<"STOP">>>; 
      1 => stopped;
    }

						fun void on()  {spork ~ play(); }
            fun void off() { spork ~  stopa(); }	
            fun void new_note(int idx)  { <<<"note " + idx>>>;		}
}

TONE t;
AMBIENT2 s1;
s1.load(1);
t.reg(s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":2 0!5_0_ }c 5_{c{c5!0_" => t.seq;
2.9 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   
t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go(); 


while(1) {
       1000::ms => now;
}
 

