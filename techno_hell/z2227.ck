TONE t;
t.reg(SYNTWAV s0); 
s0.config(.5 /* G */, 2::second /* ATTACK */, 3::second /* RELEASE */, 4 /* FILE */, 100::ms /* UPDATE */); 
t.reg(SYNTWAV s1); 
s1.config(.5 /* G */, 2::second /* ATTACK */, 3::second /* RELEASE */, 4 /* FILE */, 100::ms /* UPDATE */); 
t.reg(SYNTWAV s2); 
s2.config(.5 /* G */, 2::second /* ATTACK */, 3::second /* RELEASE */, 4 /* FILE */, 100::ms /* UPDATE */); 

t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
//1|31|3 __
//5|8___
":4 

_1|31|3|5 __
5|8_2|4

" => t.seq;

.001 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STGAIN stgain;
stgain.connect(last $ ST , 0.2 /* static gain */  );       stgain $ ST @=>  last; 

STFLANGER flang;
flang.connect(last $ ST); flang $ ST @=>  last; 
flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  10::ms /* dur base */, 2::ms /* dur range */, .13 /* freq */); 

while(1) {
       100::ms => now;
}
 
