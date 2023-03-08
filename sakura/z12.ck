POLYSEQ ps;

3 => ps.size;

//data.tick * 8 => ps.max;
// SET_WAV.DUBSTEP(ps.s[0]);// SET_WAV.VOLCA(ps.s[0]); // SET_WAV.ACOUSTIC(ps.s[0]); // SET_WAV.TABLA(ps.s[0]);// SET_WAV.CYMBALS(ps.s[0]); // SET_WAV.DUB(ps.s[0]); // SET_WAV.TRANCE(ps.s[0]); // SET_WAV.TRANCE_VARIOUS(ps.s[0]);// SET_WAV.TEK_VARIOUS(ps.s[0]);// SET_WAV.TEK_VARIOUS2(ps.s[0]);// SET_WAV2.__SAMPLES_KICKS(ps.s[0]); // SET_WAV2.__SAMPLES_KICKS_1(ps.s[0]); // SET_WAV.BLIPS(ps.s[0]);  // SET_WAV.TRIBAL(ps.s[0]);// "test.wav" => ps.s[0].wav["a"];  // act @=> ps.s[0].action["a"];
SET_WAV.TRANCE(ps.s[0]);
SET_WAV.TRIBAL(ps.s[1]);
SET_WAV.TRIBAL0(ps.s[2]);

//ps.sync(4*data.tick);// ps.element_sync(); //ps.no_sync(); //ps.full_sync(); // 1 * data.tick => ps.s[0].the_end.fixed_end_dur;  // 16 * data.tick => ps.extra_end;   //ps.s[0].print();

// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*2 _hsh _hsh _hsh _hsh      _hsh _hsh  *2  _hsh hhsh _hsh _hsh :2" +=> ps.sseq[0];
"   _hsh _hsh _hsh _hsh    _hsh hhsh _hsh *2__sh _s__:2" +=> ps.sseq[0];

"*4 ____ _a__ ____ ____ ____ ___x ____ ____" +=> ps.sseq[1];
"___H ___*2II:2 _*4XYXY:4__ __V_" +=> ps.sseq[2];
"___U  ___*4__YY:4 ___*2JI:2 __V_" +=> ps.sseq[2];

ps.go();

//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); ps.s[0].add_subwav("K", s2.wav["s"]); // ps.s[0].gain_subwav("K", 0, .3);

// GAIN
//.7 * data.master_gain =>  ps.gain_common;
 .8 * data.master_gain => ps.s[0].gain; // For individual gain
 .5 * data.master_gain => ps.s[1].gain; // For individual gain
 .4 * data.master_gain => ps.s[2].gain; // For individual gain
 ps.s[0].gain("s", 1.4); // for single wav 
 ps.s[0].gain("h", 1.0); // for single wav 

// CONNECTIONS
//ps.stout_connect(); ps.stout $ ST  @=> ST @ last; // comment to connect each SEQ separately
 ps.s[0] $ ST @=> ST @ last; 
 ps.s[1] $ ST @=>  last; 
 ps.s[2] $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .7 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.05 /* phase 0..1 */ );       autopan $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 

