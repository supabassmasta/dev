
fun void ARPY   (string seq, int nb){ 
   

TONE t;
t.reg(SERUM00 s0);  //data.tick * 8 => t.max; 
35::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(nb /* synt nb */ ); 


t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
seq => t.seq;
.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 

STMIX stmix;
stmix.send(last, 11);
//stmix.receive(11); stmix $ ST @=> ST @ last; 

  1::samp => now; // let seq() be sporked to compute length
  t.s.duration => now;


} 

STMIX stmix;
//stmix.send(last, 11);
stmix.receive(11); stmix $ ST @=> ST @ last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .9 /* span 0..1 */, data.tick * 8 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STFILTERXC stlpfxc_0; LPF_XFACTORY stlpfxc_0fact;
stlpfxc_0.connect(last $ ST ,  stlpfxc_0fact, HW.lpd8.potar[1][2] /* freq */  , HW.lpd8.potar[1][3] /* Q */, 3 /* order */, 1 /* channels */);       stlpfxc_0 $ ST @=>  last;  


STGAINC gainc;
gainc.connect(last $ ST , HW.lpd8.potar[1][1] /* gain */  , 1. /* static gain */  );       gainc $ ST @=>  last; 

SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 

WAIT w;
8 *data.tick => w.fixed_end_dur;
//4*data.tick => w.sync_end_dur;

//

while(1) {

spork ~   ARPY ("*4 " + RAND.seq("1538,85B1,}c -6 8181/F",1) + " :4 ____ ____", 34); 
8 * data.tick =>  w.wait; 
}
 
