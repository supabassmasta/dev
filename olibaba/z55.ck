ST st; st @=> ST @ last;
STEPC stepc; stepc.init(HW.lpd8.potar[1][8],.1 /* min */, 22 /* max */, 50::ms /* transition_dur */);
stepc.out => TriOsc tri1 => OFFSET ofs0 =>TriOsc tri0 => st.mono_in;
//10.0 => tri1.freq;
60 * 10.0 => tri1.gain;
0.5 => tri1.width;

99 * 10. => ofs0.offset;
1. => ofs0.gain;

//50 10.0 => tri0.freq;
0.2 => tri0.gain;
0.1 => tri0.width;

//STLPFC lpfc;
//lpfc.connect(last $ ST , HW.lpd8.potar[1][3] /* freq */  , HW.lpd8.potar[1][4] /* Q */  );       lpfc $ ST @=>  last; 

STLPF lpf;
lpf.connect(last $ ST , 1000 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 

STGAINC gainc;
gainc.connect(last $ ST , HW.lpd8.potar[1][7] /* gain */  , 0.5 /* static gain */  );       gainc $ ST @=>  last; 

/// OUTPUT
STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 

/// ECHO  
//STGAINC gainc2;
//gainc2.connect(gainc $ ST , HW.lpd8.potar[1][3] /* gain */  , 0.7 /* static gain */  );       gainc2 $ ST @=>  last; 

//STECHOC0 ech;
//ech.connect(last $ ST , data.tick * 3 / 4  /* period */ , HW.lpd8.potar[1][4] /* Gain */ );      ech $ ST @=>  last;   

STFLANGER flang;
flang.connect(last $ ST); flang $ ST @=>  last; 
flang.add_line(0 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  8::ms /* dur base */, 5::ms /* dur range */, 3 /* freq */); 
flang.add_line(1 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  7::ms /* dur base */, 4::ms /* dur range */, 3.2 /* freq */); 

STECHO ech;
ech.connect(gainc $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

<<<"****************************">>>;
<<<"**        SIREN          ***">>>;
<<<"** lpd 1.7 GAin          ***">>>;
<<<"** lpd 1.8 Freq Mod      ***">>>;
<<<"****************************">>>;


while(1) {
       100::ms => now;
}
 
