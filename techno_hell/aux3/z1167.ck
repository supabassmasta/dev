class synt0 extends SYNT{

    inlet => SqrOsc s =>  outlet; 
      .5 => s.gain;
      .1 => s.width;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c G|f///h|H 1|G//G|f h|H/1|G " => t.seq;
.2 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
16 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

ARP arp;
arp.t.dor();
50::ms => arp.t.glide;
"*4 1159/1 1/831B14/8  " => arp.t.seq;16 * data.tick =>arp.t.the_end.fixed_end_dur;
arp.t.go();   

// CONNECT SYNT HERE
3 => s0.inlet.op;
arp.t.raw() => s0.inlet; 

STCUTTER stcutter;
"*4 ____ ____ 1_1_ 1111
____ ____ 1_11 _111
" => stcutter.t.seq; 16 * data.tick => stcutter.t.the_end.fixed_end_dur;
stcutter.connect(last, 3::ms /* attack */, 3::ms /* release */ );   stcutter $ ST @=> last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .7 /* span 0..1 */, data.tick * 2 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 

STFILTERMOD fmod;
fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 1 /* Q */, 600 /* f_base */ , 1400  /* f_var */, 1::second / (7 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 



while(1) {
       100::ms => now;
}
 
