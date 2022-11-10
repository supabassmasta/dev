POLYSEQ ps;

4 => ps.size;

//data.tick * 8 => ps.max;
// SET_WAV.DUBSTEP(ps.s[0]);// SET_WAV.VOLCA(ps.s[0]); // SET_WAV.ACOUSTIC(ps.s[0]); // SET_WAV.TABLA(ps.s[0]);// SET_WAV.CYMBALS(ps.s[0]); // SET_WAV.DUB(ps.s[0]); // SET_WAV.TRANCE(ps.s[0]); // SET_WAV.TRANCE_VARIOUS(ps.s[0]);// SET_WAV.TEK_VARIOUS(ps.s[0]);// SET_WAV.TEK_VARIOUS2(ps.s[0]);// SET_WAV2.__SAMPLES_KICKS(ps.s[0]); // SET_WAV2.__SAMPLES_KICKS_1(ps.s[0]); // SET_WAV.BLIPS(ps.s[0]);  // SET_WAV.TRIBAL(ps.s[0]);// "test.wav" => ps.s[0].wav["a"];  // act @=> ps.s[0].action["a"];
SET_WAV.TRIBAL(ps.s[0]);
SET_WAV.TRIBAL1(ps.s[1]);
SET_WAV.TRIBAL(ps.s[2]);
SET_WAV.TRIBAL(ps.s[3]);

// LED
HW.ledstrip.set_tx('k') @=> ps.s[0].action["k"];
HW.ledstrip.set_tx('m') @=> ps.s[0].action["u"];
HW.ledstrip.set_tx('l') @=> ps.s[0].action["u"];

//ps.sync(4*data.tick);// ps.element_sync(); //ps.no_sync(); //ps.full_sync(); //
16 * data.tick => ps.s[0].the_end.fixed_end_dur;  // 16 * data.tick => ps.extra_end;   //ps.s[0].print();

// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  


"*2
____ ____ u|s___ ____ 
____ ____ u|s___ ____ 
____ ____ u|s___ ____ 
____ ____ u|s___ _s__ 
" +=> ps.sseq[0];

"*2
____ ____ __vu __B_ 
____ ____ __vx u_A_ 
____ ____ _vuv x_B_ 
____ ____ __vx u_A_ 
" +=> ps.sseq[1];
//____ *2vuvu:2__ ___v __xy 

"*2
____ ____ ____ ____
____ ____ ____ ____
____ ____ u|s___ ____ 
____ ____ ____ ____
" +=> ps.sseq[2];

":2
____ ____
____ __t_
____ ____
____ __q_

" +=> ps.sseq[3];

ps.go();

//// SUBWAV ////
SEQ s2; SET_WAV.TRANCE(s2); ps.s[0].add_subwav("k", s2.wav["k"]);  ps.s[0].gain_subwav("k", 0, .4);

// GAIN
1. * data.master_gain =>  ps.gain_common;
.9 * data.master_gain => ps.s[0].gain; // For individual gain
.9 * data.master_gain => ps.s[1].gain; // For individual gain
.8 * data.master_gain => ps.s[2].gain; // For individual gain
.9 * data.master_gain => ps.s[3].gain; // For individual gain
ps.s[0].gain("s", .4); // for single wav 

// CONNECTIONS
//ps.stout_connect(); ps.stout $ ST  @=> ST @ last; // comment to connect each SEQ separately
ps.s[0] $ ST @=> ST @ last; 
/////////////////////////////////////////////
ps.s[1] $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .04 /* mix */, 5 * 10. /* room size */, 2::second /* rev time */, 0.1 /* early */ , 0.3 /* tail */ ); stgverb $ ST @=>  last; 

/////////////////////////////////////////
ps.s[2] $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 6 / 4 , .8);  ech $ ST @=>  last; 

/////////////////////////////////////////
ps.s[3] $ ST @=>  last; 
STGVERB stgverb2;
stgverb2.connect(last $ ST, .2 /* mix */, 9 * 10. /* room size */, 8::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb2 $ ST @=>  last; 

STCOMPRESSOR stcomp;
9. => float in_gain;
stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 30::ms /* releaseTime */);   stcomp $ ST @=>  last;   

STGAIN stgain;
stgain.connect(last $ ST , 1.9 /* static gain */  );       stgain $ ST @=>  last; 

/////////////////////////////////////////////


while(1) {
       100::ms => now;
}
 
