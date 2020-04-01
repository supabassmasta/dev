ST st; st @=> ST @ last;

SndBuf2 s;

s.chan(0) => st.outl;
s.chan(1) => st.outr;

"../_SAMPLES/CostaRica/processed/ZOOM0016.wav" => s.read;
.12 => s.gain;
-0.21 => s.rate;

STDELAY stdelay;
stdelay.connect(last $ ST , data.tick * 4. / 4. /* static delay */ );       stdelay $ ST @=>  last;  

STAUTOPAN autopan;
autopan.connect(last $ ST, .6 /* span 0..1 */, data.tick * 2 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STAUTOPAN autopan2;
autopan2.connect(st $ ST, .5 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan2 $ ST @=>  last; 

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
stgain.connect(autopan $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 

STEQ steq;
steq.static_connect(last $ ST,  1022.600117  /* HPF freq */,  1.000000  /* HPF Q */,  2652.296559  /* LPF freq */,  1.000000  /* LPF Q */
      ,  0.000000  /* BRF1 freq */,  1.000000  /* BRF1 Q */,  0.000000  /* BRF2 freq */,  1.000000  /* BRF2 Q */
      ,  0.000000  /* BPF1 freq */,  1.000000  /* BPF1 Q */,  0.000000  /* BPF1 Gain */
      ,  0.000000  /* BPF2 freq */,  1.000000  /* BPF2 Q */,  0.000000   /* BPF2 Gain */
      ,  1.000000  /* Output Gain */ ); steq $ ST @=>  last; 

while(1) {
       s.samples() => s.pos;
       33 * data.tick => now;
}
 

