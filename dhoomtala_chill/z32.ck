class STECHO1 extends ST{

 Gain fbl => outl;
 fbl => Delay dl => BPF bpf0 => fbl;

 Gain fbr => outr;
 fbr => Delay dr=> BPF bpf1  => fbr;

 2 * 1000 => bpf0.freq => bpf1.freq;
 1 => bpf0.Q => bpf1.Q;

  fun void connect(ST @ tone, dur d, float g) {
    tone.left() => fbl;
    tone.right() => fbr;

    g =>  dl.gain => dr.gain;
    d => dl.max => dl.delay => dr.max => dr.delay;

  }

}


TONE t;
t.reg(NOISE0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" *2 }c
_0/P_G/f__f//G
" => t.seq;

.4 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .9 /* span 0..1 */, 1*data.tick /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO1 ech;
ech.connect(last $ ST , data.tick * 2 / 4 , .9);  ech $ ST @=>  last; 

while(1) {
       100::ms => now;
}


