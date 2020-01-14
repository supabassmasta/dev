// Create a synt from a wav
// input : wav path, pitch
// optional: reload_dur (reload time from the end, when wav reach its end)
public class RESYNT extends SYNT{

		1=> int nb_samples;
		string c[nb_samples];
		SndBuf C[2][nb_samples];
		ADSR   a[2][nb_samples];
	  ADSR @  lasta;
		float  Pitch[nb_samples];
		float  limits[nb_samples];
		inlet => blackhole;
		Gain out => outlet;
		1.=> out.gain;


    /// PUBLIC ////////////
    3000::ms => dur reload_dur;

    fun void pitch (float p){
      p => Pitch[0];
    }

		fun void load(string wav) {
        <<<"SYNT: " + wav>>>; 
          0=>int i;
          wav => c[i];
          <<<c[i]>>>;
          c[i] =>	C[0][i].read;
          c[i] =>	C[1][i].read;
          C[0][i].samples() => C[0][i].pos;
          C[1][i].samples() => C[1][i].pos;
          C[0][i] => a[0][i] => out;
          C[1][i] => a[1][i] => out;
          a[0][i].set(30::ms, 30::ms, 1. , 300::ms);
          a[1][i].set(30::ms, 30::ms, 1. , 300::ms);
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
         0 => index;

//				<<<"index " , index>>>; 
				f / Pitch[index] => float p;
				p => C[sidx][index].rate;
				p => C[other_sidx()][index].rate;
//				<<<"p", p>>>; 
				0=> C[sidx][index].pos; 
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
          switch_sidx();
          reload_pos => C[sidx][index].pos;
          a[sidx][index].keyOn();
          reload_dur => now;
        }

		}
		
    fun void  stopa() {
//            <<<"STOP">>>; 
      1 => stopped;
    }

						fun void on()  {spork ~ play(); }
            fun void off() { spork ~  stopa(); }	
            fun void new_note(int idx)  { <<<"note " + idx>>>;		}
}


