public class PAD0 extends SYNT{

inlet => Gain factor => blackhole;

1. / 4. => factor.gain;

SndBuf s => outlet;
"../_SAMPLES/Cymatics Freebies - Xfer Serum Wavetables/Cymatics Freebies - Xfer Serum Wavetables/Cymatics - Chill Wavetables/Cymatics - Chill Table 06_short.wav"=> s.read;

.5 => s.gain;
1=> s.loop;
1 => s.interp;


        fun void on()  { }  fun void off() { } 
        fun void new_note(int idx)  { 
          1::samp => now;
          factor.last() => s.freq;
        } 0 => own_adsr;
} 


