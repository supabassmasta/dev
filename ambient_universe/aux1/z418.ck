TONE t;
4 => int n;
1 => int r;
t.reg(SERUM0 s0); s0.config(n, r);  //data.tick * 8 => t.max; //
30::ms => t.glide;  // t.lyd(); // t.ion(); //
//t.double_harmonic();//
 0 =>t. scale.size;
 t.scale << 2 << 1 << 3 << 1 << 1 << 3 << 1 ;
//t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
//1324 3546 5768 798a
//8978 6756 4534 2312
" *4 }c }c
1324 2312 3546 1324
3546 5768 3546 4534
5768 798a 8978 6756  
5768 6756 4534 3546   
" => t.seq;
.7 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

ARP arp;
arp.t.dor();
50::ms => arp.t.glide;
"*8 
11111111 11111111 11111111 11111121 
11111111 11111111 11111111 11110101 
11111111 11111111 11111111 11111131 
11111111 11111111 11111111 11210121 

" => arp.t.seq;
arp.t.go();   

// CONNECT SYNT HERE
3 => s0.inlet.op;
arp.t.raw() => s0.inlet; 

STFLANGER flang;
flang.connect(last $ ST); flang $ ST @=>  last; 
flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  4::ms /* dur base */, 1::ms /* dur range */, .5 /* freq */); 

STFILTERMOD fmod;
fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 1 /* Q */, 599 /* f_base */ , 1400  /* f_var */, 3::second / (2 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .4 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STGAIN stgain2;
stgain2.connect(last $ ST , 0.4 /* static gain */  );       stgain2 $ ST @=>  last; 

STDELAY stdelay;
stdelay.connect(last $ ST , data.tick * 1. / 4. /* static delay */ );       stdelay $ ST @=>  last;  

STAUTOPAN autopan2;
autopan2.connect(fmod $ ST, .3 /* span 0..1 */, data.tick * 4 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan2 $ ST @=>  last; 

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
stgain.connect(stdelay $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .05 /* mix */, 3 * 10. /* room size */, 3::second /* rev time */, 0.3 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
