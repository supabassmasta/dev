TONE t;
t.reg(SERUM0 s0); s0.config(47, 0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*8 {c{c
1__1 _1__ 8_0_ 5_3_
1!1__ 8_0_ 1__1  5_3_
" => t.seq;
6.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(20::ms, 4*10::ms, .000002, 400::ms);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//////////////////////////////////////////////////////////

SinOsc s => s0.inlet;

8.0 => s.gain;
5.2 => s.freq;

//////////////////////////////////////////////////

//STFLANGER flang;
//flang.connect(last $ ST); flang $ ST @=>  last; 
//flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  3::ms /* dur base */, 1::ms /* dur range */, .2 /* freq */); 

//STGVERB stgverb;
//stgverb.connect(last $ ST, .3 /* mix */, 14 * 10. /* room size */, 5::second /* rev time */, 0.3 /* early */ , 0.7 /* tail */ ); stgverb $ ST @=>  last; 


STFILTERMOD fmod;
fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 97*10 /* f_base */ , 77* 10  /* f_var */, 1::second / (7 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 


STGVERB stgverb;
stgverb.connect(last $ ST, .3 /* mix */, 14 * 10. /* room size */, 5::second /* rev time */, 0.3 /* early */ , 0.7 /* tail */ ); stgverb $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
