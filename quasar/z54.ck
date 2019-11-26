
TONE t;
t.reg(SUPERSAW0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*8 1_1_5_4_" => t.seq;
.3 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

ARP arp;
arp.t.dor();
50::ms => arp.t.glide;
"*4 1538 35 8 " => arp.t.seq;
arp.t.go();   

// CONNECT SYNT HERE
3 => s1.inlet.op;
arp.t.raw() => s1.inlet; 


STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 600 /* f_base */ , 400  /* f_var */, 1::second / (7 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STFILTERMOD fmod2;
fmod2.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 4 /* Q */, 600 /* f_base */ , 400  /* f_var */, 3::second / (2 * data.tick) /* f_mod */);     fmod2  $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .5 /* span 0..1 */, 3*data.tick /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 

STFADEOUT fadeout;
fadeout.connect(last, 20*data.tick);     fadeout  $ ST @=>  last; 


 // FLANGER PART
 
 STFADEIN fadein;
 fadein.connect(autopan, 20*data.tick);     fadein  $ ST @=>  last; 
 
 STFLANGER flang;
 flang.connect(last $ ST); flang $ ST @=>  last; 
 flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  7::ms /* dur base */, 4::ms /* dur range */, 5 /* freq */); 
 
 STECHO ech;
 ech.connect(last $ ST , data.tick * 1 / 4 , .7);  ech $ ST @=>  last; 
 
 
 STGAIN stgain2;
 stgain2.connect(last $ ST , 0.8 /* static gain */  );       stgain $ ST @=>  last; 
 

while(1) {
       100::ms => now;
}
 
