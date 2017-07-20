class AMBIENT2 extends SYNT{

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

TONE t;
RESYNT s1;
s1.load("../_SAMPLES/Progressive-Trance-Loops---Samples/Progressive_Trance_Loops_&_Samples/Ambient&Trance_Pads&Strings/WAV_Multisamples/AnaOrch/C1.wav");
s1.pitch(Std.mtof(24));
3002::ms => s1.reload_dur;
t.reg(s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
//AMBIENT2 s2;
//s2.load(1);
//t.reg(s2);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
//":2 0!5_0_ }c 5_{c{c5!0_" => t.seq;
//":4  0000_3|53|53|53|5_" => t.seq;
":4:4 {c {c  1_" => t.seq;
2.9 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   
t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(1000::ms, 0::ms, 1., 4000::ms);
//t.adsr[1].set(1000::ms, 0::ms, 1., 4000::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go(); 


while(1) {
       1000::ms => now;
}
 

