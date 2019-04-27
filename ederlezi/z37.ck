SEQ s;  //data.tick * 8 => s.max;  //
SET_WAV.TRIBAL(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s); // "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"
*8

h_h_ h_h_ h_h_ hshs 
h_h_ hJh_ h_hs hshs 
h_hJ hJh_ hshs hsh_ 
h_h_ hJh_ h_sh shs|h_ 

" => s.seq;
.9 * data.master_gain => s.gain; //
s.gain("s", .25); // for single wav 
s.gain("v", .5); // for single wav 
s.gain("h", 1.1); // for single wav 
s.gain("J", 0.7); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go();     s $ ST @=> ST @ last; 

STADSRC stadsrc;
stadsrc.connect(last, HW.launchpad.keys[16*2 + 1] /* pad 1:1 */ /* controler */, 3::ms /* attack */, 3::ms /* release */, 1 /* default_on */, 1  /* toggle */); stadsrc $ ST @=> last; 


/////////////////////////////////

SEQ s2;  //data.tick * 8 => s2.max;  //
SET_WAV.TRIBAL(s2);// SET_WAV.VOLCA(s2); // SET_WAV.ACOUSTIC(s2); // SET_WAV.TABLA(s2);// SET_WAV.CYMBALS(s2); // SET_WAV.DUB(s2); // SET_WAV.TRANCE(s2); // SET_WAV.TRANCE_VARIOUS(s2);// SET_WAV.TEK_VARIOUS(s2);// SET_WAV.TEK_VARIOUS2(s2);// SET_WAV2.__SAMPLES_KICKS(s2); // SET_WAV2.__SAMPLES_KICKS_1(s2); // SET_WAV.BLIPS(s2); // "test.wav" => s2.wav["a"];  // act @=> s2.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"
*8

hhhh hshs hhhh hshs 
hhsh sJhs hhhs hsss 
hhhJ sJss hshs hshs 
hhsh hshs hhsh ssss 

" => s2.seq;
.9 * data.master_gain => s2.gain; //
s2.gain("s", .25); // for single wav 
s2.gain("v", .5); // for single wav 
s2.gain("h", 1.1); // for single wav 
s2.gain("J", 0.7); // for single wav 
//s2.sync(4*data.tick);// s2.element_sync(); //s2.no_sync(); //s2.full_sync();  // 16 * data.tick => s2.extra_end;   //s2.print();
// s2.mono() => dac; //s2.left() => dac.left; //s2.right() => dac.right;
s2.go();     s2 $ ST @=> last; 

STADSRC stadsrc2;
stadsrc2.connect(last, HW.launchpad.keys[16*2 + 2] /* pad 1:1 */ /* controler */, 3::ms /* attack */, 3::ms /* release */, 0 /* default_on */, 1  /* toggle */); stadsrc $ ST @=> last; 


////////////////////////




STLPFC lpfc;
lpfc.connect(stadsrc , HW.lpd8.potar[1][2] /* freq */  , HW.lpd8.potar[1][3] /* Q */  );       lpfc $ ST @=>  last; 

lpfc.connect(stadsrc2 , HW.lpd8.potar[1][2] /* freq */  , HW.lpd8.potar[1][3] /* Q */  );       lpfc $ ST @=>  last; 

STGAINC gainc;
gainc.connect(last $ ST , HW.lpd8.potar[1][1] /* gain */  , 3. /* static gain */  );       gainc $ ST @=>  last; 

//STECHOC0 ech;
//ech.connect(last $ ST , data.tick * 3 / 4  /* period */ , HW.lpd8.potar[1][4] /* Gain */ );      ech $ ST @=>  last;   

<<<"Venitian percs: ">>>;
<<<"  POTAR 1.1:  GAin">>>;
<<<"  POTAR 1.2:  LPF Freq">>>;
<<<"  POTAR 1.3:  LPF Q">>>;
//<<<"  POTAR 1.4:  Echo GAin">>>;


while(1) {
	     100::ms => now;
}
 
