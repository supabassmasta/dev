POLYTONE pt;

3 => pt.size;

// data.tick * 5 => pt.max; // 60::ms => pt.t[0].glide;// 1 * data.tick => pt.t[0].the_end.fixed_end_dur; // 16 * data.tick => pt.extra_end;  

// /!\ Not managed for all TONE in POLY TONE
//pt.t[0].force_off_action();
// pt.t[0].mono() => dac;//  pt.t[0].left() => dac.left; // pt.t[0].right() => dac.right; // pt.t[0].raw => dac;

pt.dor();// pt.lyd();// pt.ion();// pt.mix();// pt.aeo();// pt.phr();// pt.loc();// pt.double_harmonic();// pt.gypsy_minor();
//pt.sync(4*data.tick);// pt.element_sync();//  pt.no_sync();//  pt.full_sync();

.4 * data.master_gain =>  pt.gain_common;
// .6 * data.master_gain => pt.t[0].gain; // For individual gain

48 => int n;
0 => int k;

pt.t[0].reg(SERUM0 s0); s0.config(n, k);
pt.t[1].reg(SERUM0 s1); s1.config(n, k);
pt.t[2].reg(SERUM0 s2); s2.config(n, k);

pt.adsr0_set(1500::ms, 1000::ms, .8, 3000::ms); // Only works for ADSR 0
pt.adsr0_setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave

// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c 1111/555/111" +=> pt.tseq[0];
"}c 33333/111/33" +=> pt.tseq[1];
"}c 555/333333/5" +=> pt.tseq[2];

pt.go();

// CONNECTIONS
pt.stout_connect(); pt.stout $ ST  @=> ST @ last; // comment to connect each TONE separately
// pt.t[0] $ ST @=> ST @ last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .02 /* mix */, 11 * 10. /* room size */, 7::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 



while(1) {
       100::ms => now;
}
 
