ST st;

STEPC stepc; stepc.init(HW.lpd8.potar[1][4], 1 /* min */, 30 /* max */, 50::ms /* transition_dur */);
stepc.out =>  SqrOsc sqr0 => OFFSET ofs0 => MULT m => SqrOsc sqr1 => st.mono_in;

//Step stp => m;
//Std.mtof(55 + 12) => stp.next;

Std.mtof(data.ref_note) => sqr1.freq;
0.10 => sqr1.gain;
0.6 => sqr1.width;

1. => ofs0.offset;
1. => ofs0.gain;

10.0 => sqr0.freq;
1.0 => sqr0.gain;
0.5 => sqr0.width;

st @=> ST @ last;

STWPDiodeLadder stdl;
stdl.connect(last $ ST , 7 * 1000 /* cutoff */  , 5. /* resonance */ , true /* nonlinear */, true /* nlp_type */  );       stdl $ ST @=>  last; 

//STGAINC gainc;
//gainc.connect(last $ ST , HW.lpd8.potar[1][5] /* gain */  , 1. /* static gain */  );       gainc $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 

STEPC stepc1; stepc1.init(HW.lpd8.potar[1][3], 0 /* min */, 3000 /* max */, 50::ms /* transition_dur */);
stepc1.out => m; 

<<<"************************">>>;
<<<"* Sqr Mod echo      ****">>>;
<<<"* lpd 1.3 Gain Pitch    **">>>;
<<<"* lpd 1.4 Mod     **">>>;
<<<"************************">>>;


while(1) {
       100::ms => now;
}
 

