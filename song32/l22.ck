TONE t;
t.reg(SERUM00 s0);  //data.tick * 8 => t.max; // 
22::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(18 /* synt nb */ ); 
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
//"*4" + RAND.seq("1__, 1_, 851, 8/1, 1/8, }c, {c", 16) + RAND.char("058", 1) => string seq;
//"*4 }c" + RAND.seq("87654321,8765432,876543,87654,8765,876,87,8,1,21,321,4321,54321 ", 16) + RAND.char("058", 1) => string seq;
"*4 " + RAND.seq("
87654321,
876543,
8765,
87,
12345678,
123456,
1234,
12
", 16) + RAND.char("058", 1) => string seq;
<<<seq>>>;

seq => t.seq;
.5 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STAUTOFILTERX stautolpfx0; LPF_XFACTORY stautolpfx0_fact;
stautolpfx0.connect(last $ ST ,  stautolpfx0_fact, 3.0 /* Q */, 2 * 100 /* freq base */, 21 * 100 /* freq var */, data.tick * 6 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautolpfx0 $ ST @=>  last;  

STAUTOPAN autopan;
autopan.connect(last $ ST, .7 /* span 0..1 */, data.tick * 5 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .4);  ech $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
