39 => int n;

TONE t;

t.reg(SYNTWAV s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(.5 /* G */, 2::second /* ATTACK */, 1::second /* RELEASE */, n /* FILE */, 100::ms /* UPDATE */);
t.reg(SYNTWAV s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s1.config(.3 /* G */, 2::second /* ATTACK */, 1::second /* RELEASE */, n /* FILE */, 100::ms /* UPDATE */);
t.reg(SYNTWAV s2);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s2.config(.5 /* G */, 2::second /* ATTACK */, 1::second /* RELEASE */, n+ 1 /* FILE */, 100::ms /* UPDATE */);
// s0.pos s0.rate s0.lastbuf 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
//" ZYXWVU TSRQPON MLKJIHG FEDCBA0 1234567 89abcde fghijkl mnopqrs tuvwxyz"
//"1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567"
 
":8:2 {c 5|9|5_B|9|5_" => t.seq;
.6 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STFLANGER flang;
flang.connect(last $ ST); flang $ ST @=>  last; 
flang.add_line(0 /* 0 : left, 1: right 2: both */, .6 /* delay line gain */,  3::ms /* dur base */, 3::ms /* dur range */, 1.3 /* freq */); 
flang.add_line(1 /* 0 : left, 1: right 2: both */, .6 /* delay line gain */,  3::ms /* dur base */, 2::ms /* dur range */, .8 /* freq */); 

STCONVREV stconvrev;
stconvrev.connect(last $ ST , 6/* ir index */, 1 /* chans */, 10::ms /* pre delay*/, .2 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last;  


while(1) {
       100::ms => now;
}

