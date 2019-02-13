class synt0 extends SYNT{

    inlet => SqrOsc s =>  outlet; 
      .7 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 


TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*2
{c{c
!1!1!1!1!5___" => t.seq;
2.2 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STSYNCWPDiodeLadder stsyncdl;
stsyncdl.freq(2*100 /* Base */, 5 * 100 /* Variable */, 4. /* resonance */ , true /* nonlinear */, false /* nlp_type */ );
stsyncdl.adsr_set(.1 /* Relative Attack */, .7/* Relative Decay */, 0.00001 /* Sustain */, .0 /* Relative Sustain dur */, 0.0 /* Relative release */);
stsyncdl.connect(t $ ST, t.note_info_tx_o); stsyncdl $ ST @=>  last;  

//STWPDiodeLadder stdl;
//stdl.connect(last $ ST , 7* 100 /* cutoff */  , 2. /* resonance */ , true /* nonlinear */, true /* nlp_type */  );       stdl $ ST @=>  last; 

//STLPF lpf;
//lpf.connect(last $ ST , 4*100 /* freq */  , 2.0 /* Q */  );       lpf $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
