public class VOICEA2 extends SYNT{

inlet => Gain factor => blackhole;

1. / 1. => factor.gain;

SndBuf s => outlet;
"../_SAMPLES/wavetable/voiceA2.wav"=> s.read;

.5 => s.gain;
1=> s.loop;
1 => s.interp;


        fun void on()  { }  fun void off() { } 
        fun void new_note(int idx)  { 
          1::samp => now;
          factor.last() => s.freq;
        } 0 => own_adsr;
} 


