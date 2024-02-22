ST st;

.3 => st.gain;

STEPC stepc; stepc.init(HW.lpd8.potar[1][6], 1 /* min */, 10 /* max */, 50::ms /* transition_dur */);
stepc.out =>  TriOsc sqr0 => OFFSET ofs0 => MULT m => SERUM2 s0 => st.mono_in;
s0.config(0 /* synt nb */ );
fun void  LOOPLA  (){ 
  while(1) {
 

 s0.set_chunk(Std.rand2(0,63)); 

    1 * data.tick / 2=> now;
    //-------------------------------------------
  }
} 
spork ~ LOOPLA();
//LOOPLAB(); 


//Step stp => m;
//Std.mtof(55 + 12) => stp.next;

//Std.mtof(55 - 12) => sqr1.freq;
//0.15 => sqr1.gain;
//0.6 => sqr1.width;

1. => ofs0.offset;
1. => ofs0.gain;

10.0 => sqr0.freq;
1.0 => sqr0.gain;
//0.5 => sqr0.width;

st @=> ST @ last;

STWPDiodeLadder stdl;
stdl.connect(last $ ST , 7 * 1000 /* cutoff */  , 5. /* resonance */ , true /* nonlinear */, true /* nlp_type */  );       stdl $ ST @=>  last; 

//STGAINC gainc;
//gainc.connect(last $ ST , HW.lpd8.potar[1][5] /* gain */  , 1. /* static gain */  );       gainc $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 

STFREEPAN stfreepan0;
stfreepan0.connect(last $ ST); stfreepan0 $ ST @=>  last; 
AUTO.pan("*4 2//88/55/7//11/2") => stfreepan0.pan; // CONNECT THIS, normal range: -1.0 to 1.0 

STEPC stepc1; stepc1.init(HW.lpd8.potar[1][5], 0 /* min */, 3000 /* max */, 50::ms /* transition_dur */);
stepc1.out => m; 

//STGAINC gainc;
//gainc.connect(last $ ST , HW.lpd8.potar[1][6] /* gain */  , 1. /* static gain */  );       gainc $ ST @=>  last; 

<<<"************************">>>;
<<<"* tri Mod echo      ****">>>;
//<<<"* lpd 1.6 Gain        **">>>;
<<<"* lpd 1.5 Gain Pitch    **">>>;
<<<"* lpd 1.6 Mod     **">>>;
<<<"************************">>>;


while(1) {
       100::ms => now;
}
 

