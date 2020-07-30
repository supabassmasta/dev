TONE t;
t.reg(SERUM0 s0); s0.config(33, 0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*8 }c }c 1358 }c 1358 *4 43938241 :4 " => t.seq;
.17 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
4 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 


STCUTTER stcutter;
" *2 1__1 1_1_ _11_ 1_1_ " => stcutter.t.seq;
4 * data.tick => stcutter.t.the_end.fixed_end_dur;
stcutter.connect(last, 3::ms /* attack */, 3::ms /* release */ );   stcutter $ ST @=> last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .6 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STFILTERMOD fmod;
fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 160* 10 /* f_base */ , 110 * 10  /* f_var */, 1::second / (2 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

ARP arp;
arp.t.dor();
50::ms => arp.t.glide;
"*4 {c 1083 B/38 3//8 0 " => arp.t.seq;
4 * data.tick => arp.t.the_end.fixed_end_dur;
arp.t.go();   

// CONNECT SYNT HERE
3 => s0.inlet.op;
arp.t.raw() => s0.inlet; 


// MOD ////////////////////////////////

SinOsc mod => SinOsc s => OFFSET o => s0.inlet;
1::second / (13 * data.tick) => s.freq;

.3 => mod.freq;

1.2 => o.offset;
.8 => o.gain;

// MOD ////////////////////////////////


while(1) {
       100::ms => now;
}
 
