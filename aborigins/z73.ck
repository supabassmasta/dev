TONE t;
t.reg(SERUM0 s0); s0.config(1,1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" {c

!1!1 

" => t.seq;
.9 * data.master_gain => t.gain;
t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .1 /* mix */, 9 * 10. /* room size */, 3::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb $ ST @=>  last; 


//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 

STSYNCLPF stsynclpf;
stsynclpf.freq(100 /* Base */, 11 * 100 /* Variable */, 1. /* Q */);
stsynclpf.adsr_set(.2 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpf.nio.padsr.setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpf.connect(last $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 

STGAIN stgain;
stgain.connect(last $ ST , 0. /* static gain */  );       stgain $ ST @=>  last; 

stsynclpf.left() => HPF h => dac;

20 => h.freq;
1.0 => h.Q;

Step stp0 =>  Envelope e0 =>  blackhole;
10 => e0.value;

1.0 => stp0.next;

fun void f1 (){ 
    while(1) {
     
    e0.last() => h.freq;
    10::ms => now;
    }
   } 
 spork ~ f1 ();
    
SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 

while(1) {
<<<"UP">>>;

19 * 100.0 => e0.target;
16.0 * data.tick => e0.duration  => now;
<<<"DOWN">>>;
20.0 => e0.target;
16.0 * data.tick => e0.duration  => now;
}
 
while(1) {
       100::ms => now;
}
 
