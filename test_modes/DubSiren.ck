/*********************************************
                SIREN-
*********************************************/

// Main
Gain freq_in => SqrOsc osc  => ADSR env_out => Gain Tampon => LPF lpf => Gain final => dac ; 
.03=> osc.gain;
10000 => lpf.freq;
env_out.set(20::ms, 0::ms, 1, 20::ms);
env_out.keyOff();

// Mod
Step offset_freq => freq_in;
10 => offset_freq.next;
Phasor mod => freq_in;
1000 => mod.gain;
0.5 => mod.freq;


// Noise 
Noise noise => freq_in;
0 => noise.gain;

// ECHO
Tampon => Delay del => Tampon;
4::second => del.max;
data.tick => del.delay ;
0.8 => del.gain;

/*********************************************
                NANO
*********************************************/
class nanomidi_ext extends nanomidi{
   
   fun void potar_ext (int bank, int group, int val) {
       // <<<"potar: ", bank, group, val>>>;
    if (bank ==2 ) {
      if (group ==1 ) {
            Std.mtof(val)   => lpf.freq;          
		}
       else if (group ==2 ) {
            Std.mtof(val)   => mod.gain;
		<<<"mod.gain",mod.gain()>>>;
        }
       else if (group ==3 ) {
            4./ ((data.tick/1::second)*(val+1))   => mod.freq;
        }
       else if (group ==4 ) {
            (val + 1) * data.tick /2  => del.delay ;
        }
     }
   }

   fun void fader_ext (int bank, int group, int val) {
       // <<<"potar: ", bank, group, val>>>;
     if (bank ==2 ) {
       if (group ==1 ) {
          	(val $ float)/127   => final.gain;
       }
       else if (group ==2 ) {
            Std.mtof(val)   => offset_freq.next;
        }
       else if (group ==3 ) {
            val * 50   => noise.gain;
        }

        else if (group ==4 ) {
            (val $ float) / 127. => del.gain;
        }
      }
   }

   
    fun void button_play_ext (int val) {
        <<<"button play: ",val>>>;
        
        if (val != 0) {
            0=> mod.phase;
            env_out.keyOn();
        }
        else {
            env_out.keyOff();
        }
        
        
    }


}

nanomidi_ext nano;

// Test
            // 0=> mod.phase;
            // env_out.keyOn();
 // 1::second => now;
             // env_out.keyOff();
// 4::second=> now;

while (1) 1::second => now;

 
