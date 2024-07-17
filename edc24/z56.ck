ST st; st @=> ST @ last;
STEPC stepc; stepc.init(HW.lpd8.potar[1][2],.1 /* min */, 15 /* max */, 50::ms /* transition_dur */);
stepc.out => TriOsc tri1 => OFFSET ofs0 =>SUPERSAW3 tri0 => st.mono_in;
//10.0 => tri1.freq;
60 * 10.0 => tri1.gain;
0.5 => tri1.width;

70 * 10. => ofs0.offset;
1. => ofs0.gain;

//50 10.0 => tri0.freq;
0.3 * data.potar_synts_gain => tri0.gain;
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

/// ECHO  
//STGAINC gainc2;
//gainc2.connect(gainc $ ST , HW.lpd8.potar[1][3] /* gain */  , 0.7 /* static gain */  );       gainc2 $ ST @=>  last; 

//STECHOC0 ech;
//ech.connect(last $ ST , data.tick * 3 / 4  /* period */ , HW.lpd8.potar[1][4] /* Gain */ );      ech $ ST @=>  last;   

//STFLANGER flang;
//flang.connect(last $ ST); flang $ ST @=>  last; 
//flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  3::ms /* dur base */, 1::ms /* dur range */, 34 /* freq */); 

STECHO ech;
ech.connect(gainc $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 

<<<"****************************">>>;
<<<"**        SIREN SUPERSAW ***">>>;
<<<"** lpd 1.1 GAin          ***">>>;
<<<"** lpd 1.2 Freq Mod      ***">>>;
<<<"****************************">>>;


while(1) {
       100::ms => now;
}
 
