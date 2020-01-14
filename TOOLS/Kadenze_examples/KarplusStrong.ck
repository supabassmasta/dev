// Basic Karplus Strong Plucked String Synthesis Model
//    by Perry R. Cook, July 2015
// Noise into feedback delay (collapsed waveguide),
// with 2-pt moving average lowpass loop filter

public class KarplusStrong extends Chubgraph {
// Noise thru envelope through string into filter into dac
    Noise n => ADSR plk => DelayA strng => OneZero loop => dac;
    loop => strng;                // hook delay back to itself
    second/50 => strng.max;       // 50 Hz. is lowest frequency we expect
    (ms,10*ms,0.0,ms) => plk.set; // set noise envelope
    100.0 => float frq;   // default frequency
    10.0 => float sust; // in seconds
    sustain(sust);
    second/frq => strng.delay;   // delay time is 1.0/freq seconds 
    
    fun void pluck(float note, float vel)  {
        Std.mtof(note) => frq;
        ((second / samp) / frq - 1) => float period;
        (samp,period::samp,0.0,samp) => plk.set;
        period::samp => strng.delay;
        vel => n.gain;
        1 => plk.keyOn;
    }
    
    fun void sustain(float aT60)  {
        aT60 => sust;
        Math.exp(-6.91/sust/frq) => loop.gain;
    }    
}

//  Test code

KarplusStrong ks => dac;
0 => int i;

30.0 => float temp;

while (i++ < 10)  {
    temp => ks.sustain;
    <<< "Sustain (T60) =",  temp >>>;
    2.0 /=> temp;
    ks.pluck(56, 0.7);
    second => now;        
}
