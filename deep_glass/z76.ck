SEQ s[5];
STADSRC stadsrc[5];
STGAIN stgain;
0 => int idx;
ST @ last;

//data.tick * 8 => s[idx].max;  // SET_WAV.DUBSTEP(s[idx]);// SET_WAV.VOLCA(s[idx]); // SET_WAV.ACOUSTIC(s[idx]); // SET_WAV.TABLA(s[idx]);// SET_WAV.CYMBALS(s[idx]); // SET_WAV.DUB(s[idx]); // SET_WAV.TRANCE(s[idx]); // SET_WAV.TRANCE_VARIOUS(s[idx]);// SET_WAV.TEK_VARIOUS(s[idx]);// SET_WAV.TEK_VARIOUS2(s[idx]);// SET_WAV2.__SAMPLES_KICKS(s[idx]); // SET_WAV2.__SAMPLES_KICKS_1(s[idx]); // SET_WAV.BLIPS(s[idx]); // "test.wav" => s[idx].wav["a"];  // act @=> s[idx].action["a"]; 
SET_WAV2._Dirt_samples_amencutup(s[idx]);
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*4
b__b _ab_
b_ab _ab_
b_ab _ab_
b_ab a_ba
" => s[idx].seq;
.8 * data.master_gain => s[idx].gain; // s[idx].gain("s", .2); // for single wav 
//s[idx].sync(4*data.tick);// s[idx].element_sync(); //s[idx].no_sync(); //s[idx].full_sync();  // 16 * data.tick => s[idx].extra_end;   //s[idx].print();
// s[idx].mono() => dac; //s[idx].left() => dac.left; //s[idx].right() => dac.right;
s[idx].go();     s[idx] $ ST @=>  last; 

stadsrc[idx].connect(last, HW.launchpad.keys[16*3 + 4] /* pad 1:1 */ /* controler */, 3::ms /* attack */, 3::ms /* release */, 0 /* default_on */, 1  /* toggle */); stadsrc[idx] $ ST @=> last; 

stgain.connect(last $ ST , 1. /* static gain */  );     

1 +=> idx;

//////////////////
//data.tick * 8 => s[idx].max;  // SET_WAV.DUBSTEP(s[idx]);// SET_WAV.VOLCA(s[idx]); // SET_WAV.ACOUSTIC(s[idx]); // SET_WAV.TABLA(s[idx]);// SET_WAV.CYMBALS(s[idx]); // SET_WAV.DUB(s[idx]); // SET_WAV.TRANCE(s[idx]); // SET_WAV.TRANCE_VARIOUS(s[idx]);// SET_WAV.TEK_VARIOUS(s[idx]);// SET_WAV.TEK_VARIOUS2(s[idx]);// SET_WAV2.__SAMPLES_KICKS(s[idx]); // SET_WAV2.__SAMPLES_KICKS_1(s[idx]); // SET_WAV.BLIPS(s[idx]); // "test.wav" => s[idx].wav["a"];  // act @=> s[idx].action["a"]; 
SET_WAV2._Dirt_samples_amencutup(s[idx]);
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*4
_i__ i__i
" => s[idx].seq;
.8 * data.master_gain => s[idx].gain; // s[idx].gain("s", .2); // for single wav 
//s[idx].sync(4*data.tick);// s[idx].element_sync(); //s[idx].no_sync(); //s[idx].full_sync();  // 16 * data.tick => s[idx].extra_end;   //s[idx].print();
// s[idx].mono() => dac; //s[idx].left() => dac.left; //s[idx].right() => dac.right;
s[idx].go();     s[idx] $ ST @=>  last; 

stadsrc[idx].connect(last, HW.launchpad.keys[16*3 + 5] /* pad 1:1 */ /* controler */, 3::ms /* attack */, 3::ms /* release */, 0 /* default_on */, 1  /* toggle */); stadsrc[idx] $ ST @=> last; 

stgain.connect(last $ ST , 1. /* static gain */  );     

1 +=> idx;

//////////////////

//data.tick * 8 => s[idx].max;  // SET_WAV.DUBSTEP(s[idx]);// SET_WAV.VOLCA(s[idx]); // SET_WAV.ACOUSTIC(s[idx]); // SET_WAV.TABLA(s[idx]);// SET_WAV.CYMBALS(s[idx]); // SET_WAV.DUB(s[idx]); // SET_WAV.TRANCE(s[idx]); // SET_WAV.TRANCE_VARIOUS(s[idx]);// SET_WAV.TEK_VARIOUS(s[idx]);// SET_WAV.TEK_VARIOUS2(s[idx]);// SET_WAV2.__SAMPLES_KICKS(s[idx]); // SET_WAV2.__SAMPLES_KICKS_1(s[idx]); // SET_WAV.BLIPS(s[idx]); // "test.wav" => s[idx].wav["a"];  // act @=> s[idx].action["a"]; 
SET_WAV2._Dirt_samples_amencutup(s[idx]);
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*4
_c__ c__c
" => s[idx].seq;
.8 * data.master_gain => s[idx].gain; // s[idx].gain("s", .2); // for single wav 
//s[idx].sync(4*data.tick);// s[idx].element_sync(); //s[idx].no_sync(); //s[idx].full_sync();  // 16 * data.tick => s[idx].extra_end;   //s[idx].print();
// s[idx].mono() => dac; //s[idx].left() => dac.left; //s[idx].right() => dac.right;
s[idx].go();     s[idx] $ ST @=>  last; 

stadsrc[idx].connect(last, HW.launchpad.keys[16*3 + 6] /* pad 1:1 */ /* controler */, 3::ms /* attack */, 3::ms /* release */, 0 /* default_on */, 1  /* toggle */); stadsrc[idx] $ ST @=> last; 

stgain.connect(last $ ST , 1. /* static gain */  );     

1 +=> idx;

//////////////////

//data.tick * 8 => s[idx].max;  // SET_WAV.DUBSTEP(s[idx]);// SET_WAV.VOLCA(s[idx]); // SET_WAV.ACOUSTIC(s[idx]); // SET_WAV.TABLA(s[idx]);// SET_WAV.CYMBALS(s[idx]); // SET_WAV.DUB(s[idx]); // SET_WAV.TRANCE(s[idx]); // SET_WAV.TRANCE_VARIOUS(s[idx]);// SET_WAV.TEK_VARIOUS(s[idx]);// SET_WAV.TEK_VARIOUS2(s[idx]);// SET_WAV2.__SAMPLES_KICKS(s[idx]); // SET_WAV2.__SAMPLES_KICKS_1(s[idx]); // SET_WAV.BLIPS(s[idx]); // "test.wav" => s[idx].wav["a"];  // act @=> s[idx].action["a"]; 
SET_WAV2._Dirt_samples_amencutup(s[idx]);
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*4
cici ccic icic iici
" => s[idx].seq;
.8 * data.master_gain => s[idx].gain; // s[idx].gain("s", .2); // for single wav 
//s[idx].sync(4*data.tick);// s[idx].element_sync(); //s[idx].no_sync(); //s[idx].full_sync();  // 16 * data.tick => s[idx].extra_end;   //s[idx].print();
// s[idx].mono() => dac; //s[idx].left() => dac.left; //s[idx].right() => dac.right;
s[idx].go();     s[idx] $ ST @=>  last; 

stadsrc[idx].connect(last, HW.launchpad.keys[16*4 + 4] /* pad 1:1 */ /* controler */, 3::ms /* attack */, 3::ms /* release */, 0 /* default_on */, 1  /* toggle */); stadsrc[idx] $ ST @=> last; 

stgain.connect(last $ ST , 1. /* static gain */  );     

1 +=> idx;

//////////////////

//data.tick * 8 => s[idx].max;  // SET_WAV.DUBSTEP(s[idx]);// SET_WAV.VOLCA(s[idx]); // SET_WAV.ACOUSTIC(s[idx]); // SET_WAV.TABLA(s[idx]);// SET_WAV.CYMBALS(s[idx]); // SET_WAV.DUB(s[idx]); // SET_WAV.TRANCE(s[idx]); // SET_WAV.TRANCE_VARIOUS(s[idx]);// SET_WAV.TEK_VARIOUS(s[idx]);// SET_WAV.TEK_VARIOUS2(s[idx]);// SET_WAV2.__SAMPLES_KICKS(s[idx]); // SET_WAV2.__SAMPLES_KICKS_1(s[idx]); // SET_WAV.BLIPS(s[idx]); // "test.wav" => s[idx].wav["a"];  // act @=> s[idx].action["a"]; 
SET_WAV2._Dirt_samples_amencutup(s[idx]);
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*4
iiii *2 iiii iiii
" => s[idx].seq;
.8 * data.master_gain => s[idx].gain; // s[idx].gain("s", .2); // for single wav 
//s[idx].sync(4*data.tick);// s[idx].element_sync(); //s[idx].no_sync(); //s[idx].full_sync();  // 16 * data.tick => s[idx].extra_end;   //s[idx].print();
// s[idx].mono() => dac; //s[idx].left() => dac.left; //s[idx].right() => dac.right;
s[idx].go();     s[idx] $ ST @=>  last; 

stadsrc[idx].connect(last, HW.launchpad.keys[16*4 + 5] /* pad 1:1 */ /* controler */, 3::ms /* attack */, 3::ms /* release */, 0 /* default_on */, 1  /* toggle */); stadsrc[idx] $ ST @=> last; 

stgain.connect(last $ ST , 1. /* static gain */  );     

1 +=> idx;

//////////////////



 


stgain $ ST @=>  last; 

STLPFC lpfc;
lpfc.connect(last $ ST , HW.lpd8.potar[1][3] /* freq */  , HW.lpd8.potar[1][4] /* Q */  );       lpfc $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
