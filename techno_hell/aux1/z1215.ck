POLYTONE pt;

4 => pt.size;

// data.tick * 5 => pt.max; // 60::ms => pt.t[0].glide;// 1 * data.tick => pt.t[0].the_end.fixed_end_dur; // 16 * data.tick => pt.extra_end;  

// /!\ Not managed for all TONE in POLY TONE
//pt.t[0].force_off_action();
// pt.t[0].mono() => dac;//  pt.t[0].left() => dac.left; // pt.t[0].right() => dac.right; // pt.t[0].raw => dac;

pt.dor();// pt.lyd();// pt.ion();// pt.mix();// pt.aeo();// pt.phr();// pt.loc();// pt.double_harmonic();// pt.gypsy_minor();
//pt.sync(4*data.tick);// pt.element_sync();//  pt.no_sync();//  pt.full_sync();

.6 * data.master_gain =>  pt.gain_common;
//
.3 * data.master_gain => pt.t[1].gain; // For individual gain
.2 * data.master_gain => pt.t[2].gain; // For individual gain
.3 * data.master_gain => pt.t[3].gain; // For individual gain

pt.t[0].reg(SERUM0 s0); s0.config(0,0);
pt.t[1].reg(SERUM0 s1); s1.config(15,1);
pt.t[2].reg(SERUM0 s2); s2.config(28,0);
pt.t[3].reg(SERUM0 s3); s3.config(43,0);

/// HACK s3
SinOsc mod => OFFSET o => s3.inlet;

4 => o.offset;
100 => mod.gain;
2 => mod.freq;

SinOsc mod2 => OFFSET o2 => mod;
1.1 => o2.offset;
4 => mod2.gain;
.1 => mod2.freq;


pt.adsr0_set(3::ms, 1::ms, 1., 3::ms); // Only works for ADSR 0
pt.adsr0_setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave

// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  

"*4}c" +=> pt.tseq[0];
"*4" +=> pt.tseq[1];
"*4" +=> pt.tseq[2];
"*4}c" +=> pt.tseq[3];

"____ ____ 1_1_ __1_ " +=> pt.tseq[0];
"____ ____ ____ ____ " +=> pt.tseq[1];
"1111 1/3333 3/0000 0/1111 " +=> pt.tseq[2];
"____ ____ ____ ____ " +=> pt.tseq[3];

"____ ____ ____ ____ " +=> pt.tseq[0];
"__8/1 ____ ____ ____ " +=> pt.tseq[1];
"____ ____ ____ ____ " +=> pt.tseq[2];
"____ ____ 1_1!3_5_4 " +=> pt.tseq[3];

"____ ____ ____ ____ " +=> pt.tseq[0];
"____ ____ G//f__ ____ " +=> pt.tseq[1];
"3333 3/1111 1/0000 0/1111" +=> pt.tseq[2];
"____ ____ ____ ____ " +=> pt.tseq[3];

"____ ____ ____ __8_ " +=> pt.tseq[0];
"__1}c}c/1 ____ ____ ____ " +=> pt.tseq[1];
"____ ____ ____ ____ " +=> pt.tseq[2];
"____ 3!1_1 __5_ 4_4_ " +=> pt.tseq[3];
pt.go();

// CONNECTIONS
pt.stout_connect(); pt.stout $ ST  @=> ST @ last; // comment to connect each TONE separately
// pt.t[0] $ ST @=> ST @ last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .6 /* span 0..1 */, data.tick * 5 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .02 /* mix */, 11 * 10. /* room size */, 7::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
