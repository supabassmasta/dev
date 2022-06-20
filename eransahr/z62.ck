TONE t;
t.reg(SERUM00 s0);  //data.tick * 8 => t.max; 
s0.config(2 /* synt nb */ ); 

//" ZYXWVU TSRQPON MLKJIHG FEDCBA0 1234567 89abcde fghijkl mnopqrs tuvwxyz"
//"1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567"
 

40::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" *8 " + RAND.seq("153,815,B80,cf", Std.rand2(1, 4)) => t.seq;
.2 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
8 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STFILTERXC stlpfxc_0; LPF_XFACTORY stlpfxc_0fact;
stlpfxc_0.connect(last $ ST ,  stlpfxc_0fact, HW.lpd8.potar[1][2] /* freq */  , HW.lpd8.potar[1][3] /* Q */, 3 /* order */, 1 /* channels */);       stlpfxc_0 $ ST @=>  last;  



STAUTOPAN autopan;
autopan.connect(last $ ST, .6 /* span 0..1 */, data.tick * 3 / 2 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 


STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

STGAINC gainc;
gainc.connect(last $ ST , HW.lpd8.potar[1][1] /* gain */  , 1. /* static gain */  );       gainc $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .05 /* mix */, 4 * 10. /* room size */, 1::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

<<<"////////////////////////////////">>>;
<<<"// RAND ARP GLIDE             //">>>;
<<<"// Gain 1.1             //">>>;
<<<"// LPF 1.2 1.3            //">>>;
<<<"////////////////////////////////">>>;


while(1) {
       100::ms => now;
}
 


