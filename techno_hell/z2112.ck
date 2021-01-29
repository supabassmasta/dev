POLYSEQ ps;

3 => ps.size;

//data.tick * 8 => ps.max;
// SET_WAV.DUBSTEP(ps.s[0]);// SET_WAV.VOLCA(ps.s[0]); // SET_WAV.ACOUSTIC(ps.s[0]); // SET_WAV.TABLA(ps.s[0]);// SET_WAV.CYMBALS(ps.s[0]); // SET_WAV.DUB(ps.s[0]); // SET_WAV.TRANCE(ps.s[0]); // SET_WAV.TRANCE_VARIOUS(ps.s[0]);// SET_WAV.TEK_VARIOUS(ps.s[0]);// SET_WAV.TEK_VARIOUS2(ps.s[0]);// SET_WAV2.__SAMPLES_KICKS(ps.s[0]); // SET_WAV2.__SAMPLES_KICKS_1(ps.s[0]); // SET_WAV.BLIPS(ps.s[0]);  // SET_WAV.TRIBAL(ps.s[0]);// "test.wav" => ps.s[0].wav["a"];  // act @=> ps.s[0].action["a"];
SET_WAV.TRIBAL(ps.s[0]);
SET_WAV.TRIBAL0(ps.s[1]);
SET_WAV.TRIBAL1(ps.s[2]);

//ps.sync(4*data.tick);// ps.element_sync(); //ps.no_sync(); //ps.full_sync(); //
2 * data.tick => ps.s[0].the_end.fixed_end_dur;  // 16 * data.tick => ps.extra_end;   //ps.s[0].print();

// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*2
  _hxh _hxh _hxh *2 __hx __h_ :2
  _hxh _hxh _hxh *2 __h_ x_hx :2
  _hxh _hxh _hxh *2 _xh_ xhhh :2
" +=> ps.sseq[0];

"*2 _x_x _I__ " +=> ps.sseq[1];
"   _x_x ____ " +=> ps.sseq[1];
"   _x_x *2___z:2__ " +=> ps.sseq[1];
"   _x_x ____ " +=> ps.sseq[1];
// "
//  ____ ___f
//  ____ ___ *4v___:4
//  ____ ___f
//  ____ ___ *4zzu_:4
//  " +=> ps.sseq[2];
"
____ ___h
____ __*4____ __ux :4
____ ___R
____ __*4__vw _w_x :4
" +=> ps.sseq[2];
ps.go();

//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); ps.s[0].add_subwav("K", s2.wav["s"]); // ps.s[0].gain_subwav("K", 0, .3);

// GAIN
.6 * data.master_gain =>  ps.gain_common;
 .7 * data.master_gain => ps.s[0].gain; // For individual gain
 .3 * data.master_gain => ps.s[1].gain; // For individual gain
// ps.s[0].gain("s", .4); // for single wav 

// CONNECTIONS
//ps.stout_connect(); ps.stout $ ST  @=> ST @ last; // comment to connect each SEQ separately
 ps.s[0] $ ST @=> ST @ last; 
 ps.s[1] $ ST @=>  last; 
 ps.s[2] $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .8 /* span 0..1 */, data.tick * 2.4 / 0 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
