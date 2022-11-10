ST st; st @=> ST @ last;
STEPC stepc; stepc.init(HW.lpd8.potar[1][2],.1 /* min */, 15 /* max */, 50::ms /* transition_dur */);
stepc.out => TriOsc tri1 => OFFSET ofs0 =>SUPERSAW3 tri0 => st.mono_in;
//10.0 => tri1.freq;
60 * 10.0 => tri1.gain;
0.5 => tri1.width;

70 * 10. => ofs0.offset;
1. => ofs0.gain;

//50 10.0 => tri0.freq;
0.6 => tri0.gain;
//0.5 => tri0.width;

//STLPFC lpfc;
//lpfc.connect(last $ ST , HW.lpd8.potar[1][3] /* freq */  , HW.lpd8.potar[1][4] /* Q */  );       lpfc $ ST @=>  last; 

//STLPF lpf;
//lpf.connect(last $ ST , 71 * 100 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 

STGAINC gainc;
gainc.connect(last $ ST , HW.lpd8.potar[1][1] /* gain */  , 0.5 /* static gain */  );       gainc $ ST @=>  last; 

/// OUTPUT
STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 


STECHO ech;
ech.connect(last $ ST , data.tick * 6 / 4 , .8);  ech $ ST @=>  last; 
//:2
//1_1_1_1_1_1_1_1_
//*2

STCUTTER stcutter;
"*8 
1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_
" => stcutter.t.seq;
stcutter.connect(last, 1::ms /* attack */, 1::ms /* release */ );   stcutter $ ST @=> last; 

<<<"****************************">>>;
<<<"**        SIREN          ***">>>;
<<<"** lpd 1.1 GAin          ***">>>;
<<<"** lpd 1.2 Freq Mod      ***">>>;
<<<"****************************">>>;


while(1) {
       100::ms => now;
}
 
