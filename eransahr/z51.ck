POLYSEQ ps;

4 => ps.size;

//data.tick * 8 => ps.max;
// SET_WAV.DUBSTEP(ps.s[0]);// SET_WAV.VOLCA(ps.s[0]); // SET_WAV.ACOUSTIC(ps.s[0]); // SET_WAV.TABLA(ps.s[0]);// SET_WAV.CYMBALS(ps.s[0]); // SET_WAV.DUB(ps.s[0]); // SET_WAV.TRANCE(ps.s[0]); // SET_WAV.TRANCE_VARIOUS(ps.s[0]);// SET_WAV.TEK_VARIOUS(ps.s[0]);// SET_WAV.TEK_VARIOUS2(ps.s[0]);// SET_WAV2.__SAMPLES_KICKS(ps.s[0]); // SET_WAV2.__SAMPLES_KICKS_1(ps.s[0]); // SET_WAV.BLIPS(ps.s[0]);  // SET_WAV.TRIBAL(ps.s[0]);// "test.wav" => ps.s[0].wav["a"];  // act @=> ps.s[0].action["a"];
SET_WAV.TRIBAL(ps.s[0]);
SET_WAV.ACOUSTIC(ps.s[1]);
SET_WAV.TRIBAL(ps.s[2]);
SET_WAV.TRIBAL(ps.s[3]);

// LED
HW.ledstrip.set_tx('k') @=> ps.s[0].action["k"];
HW.ledstrip.set_tx('m') @=> ps.s[0].action["u"];
HW.ledstrip.set_tx('l') @=> ps.s[2].action["u"];
HW.ledstrip.set_tx('l') @=> ps.s[3].action["t"];

//ps.sync(4*data.tick);// ps.element_sync(); //ps.no_sync(); //ps.full_sync(); // 
8 * data.tick => ps.s[0].the_end.fixed_end_dur;  // 16 * data.tick => ps.extra_end;   //ps.s[0].print();

// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*4
k___ u|s__k
k___ u|s__s
k___ u|s_sk
ksk_ u|s__s

k___ u|s__k
k___ u|s__s
ks__ u|su|s_k
ksk_ u|sk_k
" +=> ps.sseq[0];

"*4
__j_ __j_ __j_ _ij_
__j_ __j_ __ji _iji
" +=> ps.sseq[1];

"____ ___t
____ ____

" +=> ps.sseq[2];

"
____ ____
____ ___t

" +=> ps.sseq[3];
ps.go();

//// SUBWAV ////
SEQ s2; SET_WAV.TRANCE(s2); ps.s[0].add_subwav("k", s2.wav["k"]); ps.s[0].gain_subwav("k", 0, .4);

// GAIN
1 * data.master_gain =>  ps.gain_common;
.9 * data.master_gain => ps.s[0].gain; // For individual gain
.8 * data.master_gain => ps.s[1].gain; // For individual gain
.9 * data.master_gain => ps.s[2].gain; // For individual gain
.9 * data.master_gain => ps.s[3].gain; // For individual gain
ps.s[0].gain("s", .4); // for single wav 
// CONNECTIONS
//ps.stout_connect(); ps.stout $ ST  @=> ST @ last; // comment to connect each SEQ separately

 //////////////////////////////////
 ps.s[0] $ ST @=> ST @ last; 
 //////////////////////////////////
 ps.s[1] $ ST @=>  last; 

STADSR stadsr;
stadsr.set(0::ms /* Attack */, 17::ms /* Decay */, .3 /* Sustain */, 100::ms /* Sustain dur */,  10::ms /* release */);
stadsr.connect(last $ ST, ps.s[1].note_info_tx_o);  stadsr  $ ST @=>  last; 

 //////////////////////////////////
 ps.s[2] $ ST @=>  last; 
STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .7);  ech $ ST @=>  last; 

 //////////////////////////////////
 ps.s[3] $ ST @=>  last; 
STGVERB stgverb;
stgverb.connect(last $ ST, .2 /* mix */, 9 * 10. /* room size */, 8::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb $ ST @=>  last; 

STCOMPRESSOR stcomp;
9. => float in_gain;
stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 30::ms /* releaseTime */);   stcomp $ ST @=>  last;   

STGAIN stgain;
stgain.connect(last $ ST , 1.1 /* static gain */  );       stgain $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
