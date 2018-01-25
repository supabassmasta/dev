class synt0 extends SYNT{

    inlet => TriOsc s => LPF f =>  outlet;   
    3000 => f.freq;
    Noise n => s;
    300 => n.gain;
        .5 => s.gain;

            fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {   }
} 


TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":4 {c 1/jj/1 " => t.seq;
.2 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(5::ms, 10::ms, 1, 2000::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go(); 

STAUTOPAN autopan;
autopan.connect(t $ ST, .9 /* span 0..1 */, 3*data.tick /* period */, 0.95 /* phase 0..1 */ );  

STDUCK duck;
duck.connect(t $ ST); 

STREV2 rev; // DUCKED
rev.connect(t $ ST, .3 /* mix */); 

while(1) {
       100::ms => now;
}
 
