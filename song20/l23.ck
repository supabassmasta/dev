
class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .9 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
//t.reg(SUPERSAW0 s2);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
//t.reg(SUPERSAW0 s3);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
//t.reg(SUPERSAW0 s4);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":8 {c 1_" => t.seq;
.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(1000::ms, 1000::ms, .5, 4000::ms);
t.adsr[0].setCurves(.3, 2.0, 4.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
//t.adsr[1].set(2000::ms, 10::ms, 1., 4000::ms);
//t.adsr[1].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
//t.adsr[2].set(2000::ms, 10::ms, 1., 4000::ms);
//t.adsr[2].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
//t.adsr[3].set(2000::ms, 10::ms, 1., 4000::ms);
//t.adsr[3].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//STTREMOLO sttrem;
//.2 => sttrem.mod.gain;  5 => sttrem.mod.freq;
//sttrem.pa.set(data.tick *6 , 0::ms , 1., 1700::ms);
//sttrem.connect(last $ ST, t.note_info_tx_o);  sttrem  $ ST @=>  last;  

//STSYNCLPF stsynclpf;
//stsynclpf.freq(100 /* Base */, 19 * 100 /* Variable */, 4. /* Q */);
//stsynclpf.adsr_set(.3 /* Relative Attack */, .01/* Relative Decay */, 1. /* Sustain */, .1 /* Relative Sustain dur */, 0.7 /* Relative release */);
//stsynclpf.connect(t $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 

//STREV1 rev;
//rev.connect(last $ ST, .3 /* mix */);     rev  $ ST @=>  last; 

REC rec;
//rec.rec(8*data.tick, "test.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */);
rec.rec_no_sync(42*data.tick, "test.wav"); 


while(1) {
       100::ms => now;
}
 
