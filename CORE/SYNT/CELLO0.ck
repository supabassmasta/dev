public class CELLO0 extends SYNT{

inlet => Gain factor => blackhole;

1. / 4. => factor.gain;

SndBuf s => outlet;
"../_SAMPLES/wavetable/cello0.wav"=> s.read;

.5 => s.gain;
1=> s.loop;
1 => s.interp;


        fun void on()  { }  fun void off() { } 
        fun void new_note(int idx)  { 
          1::samp => now;
          factor.last() => s.freq;
        } 0 => own_adsr;
} 


