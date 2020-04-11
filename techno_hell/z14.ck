STMIX stmix;
//stmix.send(last, 11);
stmix.receive(14); stmix $ ST @=> ST @ last; 

STLHPFC2 lhpfc2;
0 => lhpfc2.cfreq.update_on_reg;
0 => lhpfc2.cq.update_on_reg;
19999 => lhpfc2.lpfl.freq;
19999 => lhpfc2.lpfr.freq;
  1 => lhpfc2.lpfl.Q;
  1 => lhpfc2.lpfr.Q;

  0 => lhpfc2.hpfl.freq;
  0 => lhpfc2.hpfr.freq;
  1 => lhpfc2.hpfl.Q;
  1 => lhpfc2.hpfr.Q;
lhpfc2.connect(last $ ST , HW.lpd8.potar[2][3] /* freq */  , HW.lpd8.potar[2][4] /* Q */  );       lhpfc2 $ ST @=>  last; 
lhpfc2.cfreq.set(64);

STGAINC gainc2;
0 => gainc2.cgain.update_on_reg;
gainc2.connect(last $ ST , HW.lpd8.potar[2][2] /* gain */  , 12. /* static gain */  );       gainc2 $ ST @=>  last; 

STCOMPRESSOR stcomp;
1. => float in_gain;
stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 40::ms /* releaseTime */);   stcomp $ ST @=>  last;   


STGAINC gainc;
0 => gainc.cgain.update_on_reg;
gainc.connect(last $ ST , HW.lpd8.potar[2][1] /* gain */  , 2. /* static gain */  );       gainc $ ST @=>  last; 

<<<"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%">>>;
<<<"%%%%%  TECHNO HELL KICK BASS OUT z14  %%%">>>;
<<<"%%%%%  lpd 2.1 Final Gain             %%%">>>;
<<<"%%%%%  lpd 2.2 Compressor pre Gain    %%%">>>;
<<<"%%%%%  lpd 2.3 HLPF freq              %%%">>>;
<<<"%%%%%  lpd 2.4 HLPF Q                 %%%">>>;
<<<"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%">>>;



while(1) {
       100::ms => now;
}



