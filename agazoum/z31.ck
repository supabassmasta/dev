TONE t;//data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(SERUM00 s0);  
t.reg(SERUM00 s1);  
t.reg(SERUM00 s2);  
3 => int k;
s0.config(k /* synt nb */ ); 
s1.config(k /* synt nb */ ); 
s2.config(k /* synt nb */ ); 

t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c _1|3|5__ ____ ____ ____" => t.seq;
0.7 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.set_adsrs(2::ms, 161::ms, .002, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .95);  ech $ ST @=>  last; 

STROTATE strot;
strot.connect(last $ ST , 0.6 /* freq */  , 0.1 /* depth */, 0.4 /* width */, 1::samp /* update rate */ ); strot$ ST @=>  last; 
// => strot.sin0;  => strot.sin1; // connect to make freq change 


while(1) {
       100::ms => now;
}
 
