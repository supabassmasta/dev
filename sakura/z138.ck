TONE t;
t.reg(SERUM00 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(72 /* synt nb */ ); 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" :4{c  111" => t.seq;
0.15 * data.master_gain => t.gain;
t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STAUTOFILTERX stautolpfx0; LPF_XFACTORY stautolpfx0_fact;
stautolpfx0.connect(last $ ST ,  stautolpfx0_fact, 1.0 /* Q */, 4 * 100 /* freq base */, 6 * 100 /* freq var */, data.tick * 24 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautolpfx0 $ ST @=>  last;  

STFLANGER flang;
flang.connect(last $ ST); flang $ ST @=>  last; 
flang.add_line(0 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  5::ms /* dur base */, 2::ms /* dur range */, .3 /* freq */); 
flang.add_line(1 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  6::ms /* dur base */, 3::ms /* dur range */,.4 /* freq */); 


STCONVREV stconvrev;
stconvrev.connect(last $ ST , 14/* ir index */, 1 /* chans */, 10::ms /* pre delay*/, .5 /* rev gain */  , 0.5 /* dry gain */  );       stconvrev $ ST @=>  last;  


while(1) {
       100::ms => now;
}
 
