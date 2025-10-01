


TONE t;
t.scale.size(0);
t.scale << 1 << 3 << 1 << 2 << 3 << 2;
t.reg(SERUM00 s0); s0.config(65);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"  
1111 1111 1////F F////1" => t.seq;

.2 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(3::samp , 10::ms, 1., 3::samp);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 


class SINMODONE {

STEPC stepc; stepc.init(HW.lpd8.potar[1][8], .2 /* min */, 10 /* max */, 50::ms /* transition_dur */);
stepc.out =>  SqrOsc s => Gain gsin=> Gain out;
3 => gsin.op;
STEPC stepc2; stepc2.init(HW.lpd8.potar[1][7], 0 /* min */, 1 /* max */, 50::ms /* transition_dur */);
stepc2.out => gsin;  

Step one => out;
0. => one.next;

//while(1) {
//       100::ms => now;
//}
 
}

3 => s0.inlet.op;

SINMODONE sin;
sin.out => s0.inlet;

STAUTOFILTERX stautoresx0; RES_XFACTORY stautoresx0_fact;
stautoresx0.connect(last $ ST ,  stautoresx0_fact, 3.0 /* Q */, 25 * 10 /* freq base */, 75 * 10 /* freq var */, data.tick * 16 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautoresx0 $ ST @=>  last;  
8 => stautoresx0.gain;
//
STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .6 /* span 0..1 */, data.tick * 3 / 2 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STLIMITER stlimiter;
3. => float in_gainl;
stlimiter.connect(last $ ST , in_gainl /* in gain */, 1./in_gainl /* out gain */, 0.0 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stlimiter $ ST @=>  last;   


//STFILTERMOD fmod;
//fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 6 /* Q */, 600 /* f_base */ , 3400  /* f_var */, 1::second / (3 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

<<<"------------- FM MOD  --------------">>>;
<<<"---------  LPD8 1.7 Gain, Gain Mod -">>>;
<<<"---------  LPD8 1.8 Freq Mod  ------">>>;
<<<"------------------------------------">>>;


while(1) {
       100::ms => now;
}


