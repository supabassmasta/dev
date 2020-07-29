ST st;
SndBuf s => ADSR adsr => st.mono_in; st @=> ST @ last;
adsr.set(3::ms, 0::ms, 1., 3::ms);

"../../_SAMPLES/Aborigines/abo0.wav" => s.read;
s.samples() => s.pos;

STGAIN stgain;
stgain.connect(last $ ST , 0.4 /* static gain */  );       stgain $ ST @=>  last; 


fun void play(dur p, dur l, float r, dur atk, dur rel) {
  adsr.set(atk, 0::ms, 1., rel);
  adsr.keyOn();

  (p/(1::samp)) $ int => s.pos;

  l - rel => now;

  adsr.keyOff();
  rel => now;

  s.samples() => s.pos;
}


data.tick  => dur d;
while(1) {
   Std.rand2(1,21) * d =>  dur pr;
   d / Math.pow (2, Std.rand2(1,4)) => dur dr;
play( pr, dr, 1. , 2::ms, 2::ms);
   d /Math.pow (2, Std.rand2(1,4)) => now;

}
 
