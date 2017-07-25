public class AMBIENT2 extends SYNT{

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

    /// PUBLIC ////////////
    3000::ms => dur reload_dur;
    300::ms => dur	release_dur;	

    fun void disconnect_after_release(int si, int i) {
      release_dur => now;
      a[si][i] =< out;
    }

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
          C[0][i] => a[0][i] ;
          C[1][i] => a[1][i] ;
          a[0][i].set(30::ms, 30::ms, 1. , release_dur);
          a[1][i].set(30::ms, 30::ms, 1. , release_dur);
        }
      }
      else {
        <<<"synt index too high">>>; 
      }
		}
    /// PUBLIC ////////////
		 
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

    0=> int exit_idx;

		fun void  play() {
		    // Off last
        a[sidx][index].keyOff();
        spork ~ disconnect_after_release(sidx, index);

			  if (stopped) {
           //immediate stop last one
           C[sidx][index].samples() => C[sidx][index].pos;
           0 => stopped;
        }
        
        exit_idx + 1 => exit_idx;

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
				p => C[other_sidx()][index].rate;
//				<<<"p", p>>>; 
				0=> C[sidx][index].pos; 
        a[sidx][index] => out;
				a[sidx][index].keyOn();

        // Rewined wav while key is on
        // And after to let long TONE keyOff possible
        exit_idx => int exit;

        if (reload_dur > (1./C[sidx][index].rate()) * C[sidx][index].length()) {
          <<<"!!!!!!RELOAD DUR TOO HIGH!!!!!!!">>>;
          (1./C[sidx][index].rate()) * C[sidx][index].length() / 2 => reload_dur;
        }

 
        (1./C[sidx][index].rate()) * C[sidx][index].length() * 0.9 => dur first_reload;
        (( (C[sidx][index].length() * (1./C[sidx][index].rate()) ) - reload_dur)/ (C[sidx][index].length() * (1./C[sidx][index].rate()) ) * C[sidx][index].samples()) $ int => int reload_pos;
        
        first_reload => now;
//        <<<"RELOAD">>>;

        while (exit == exit_idx) {
//        <<<"RELOAD 2">>>;
          a[sidx][index].keyOff();
          spork ~ disconnect_after_release(sidx, index);
          switch_sidx();
          reload_pos => C[sidx][index].pos;
          a[sidx][index] => out;
          a[sidx][index].keyOn();
          reload_dur => now;
        }
        
//        <<<"EXIT AMBIENT2">>>; 

		}
		
    fun void  stopa() {
//            <<<"STOP">>>; 
      1 => stopped;
    }

						fun void on()  {spork ~ play(); }
            fun void off() { spork ~  stopa(); }	
            fun void new_note(int idx)  { /*<<<"note " + idx>>>;	*/	}
}
