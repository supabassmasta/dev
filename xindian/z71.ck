class synt0 extends SYNT{

    inlet => TriOsc s =>  outlet; 
      .5 => s.gain;
    .89 => s.width;

      inlet => NOISE2 s2 =>  outlet; 
      5.5 =>  s2.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c 
____ ____
!8//1 ____
____ ___!5
!8//1__ ____


" => t.seq;
.2 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//STWPDiodeLadder stdl;
//stdl.connect(last $ ST , 3* 100 /* cutoff */  , 9. /* resonance */ , true /* nonlinear */, true /* nlp_type */  );       stdl $ ST @=>  last; 

STSYNCLPF stsynclpf;
stsynclpf.freq(100 /* Base */, 10 * 100 /* Variable */, 7. /* Q */);
stsynclpf.adsr_set(.9 /* Relative Attack */, .000001/* Relative Decay */, 1. /* Sustain */, .000001 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynclpf.connect(t $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 

STHPF hpf;
hpf.connect(last $ ST , 9 * 10 /* freq */  , 1.0 /* Q */  );       hpf $ ST @=>  last; 
//STECHO ech;
//ech.connect(last $ ST , data.tick * 1 / 12 , .6);  ech $ ST @=>  last; 

//STREV1 rev;
//rev.connect(last $ ST, .3 /* mix */);     rev  $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
