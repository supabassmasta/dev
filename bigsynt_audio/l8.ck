ST st;
Step f => PLOC0 synt => st.mono_in;
.7 => synt.s.gain;

st $ ST @=> ST last;

STHPF hpf;
hpf.connect(last $ ST , 13 * 100 /* freq */  , 1.0 /* Q */  );       hpf $ ST @=>  last; 

STECHOC0 ech;
ech.connect(last $ ST , data.tick * 3 / 4  /* period */ , HW.lpd8.potar[1][2] /* Gain */ );      ech $ ST @=>  last;   

STGAINC gainc;
gainc.connect(last $ ST , HW.lpd8.potar[1][1] /* gain */  , 1. /* static gain */  );       gainc $ ST @=>  last; 


STREV2 rev; // DUCKED
rev.connect(last $ ST, .3 /* mix */);      rev $ ST @=>  last; 



Std.mtof(48) => f.next;

[0, 2, 3,5, 7, 9, 10, 12 ] @=> int notes[];


while(1) {
  Std.mtof ( 48 +  notes[ Std.rand2(0, notes.size() - 1) ] )  => f.next;

  synt.new_note(0);  
  LPD8.pot[0][2] + 1 => int p;
  Std.rand2(p * 10, p * 31) * 1::ms  => now;
}



