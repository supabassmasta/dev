class synt0 extends SYNT{

    inlet => SqrOsc s =>  outlet; 
      .5 => s.gain;
    

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {0=> s.phase; } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" *8 {c
8_5_ 1___ ____ ____
}c
8_5_ 1___ ____ ____

" => t.seq;
.4 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STSYNCLPF stsynclpf;
stsynclpf.freq(3 * 100 /* Base */, 8 * 100 /* Variable */, 2. /* Q */);
stsynclpf.adsr_set(.04 /* Relative Attack */, .2/* Relative Decay */, 0.00001 /* Sustain */, .4 /* Relative Sustain dur */, 0.5 /* Relative release */);
stsynclpf.connect(last $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 
//////////////////////////////////////////////////////////

STEPC stepc; stepc.init(HW.lpd8.potar[1][1], 0 /* min */, 3000 /* max */, 50::ms /* transition_dur */);
stepc.out => Gain mult => s0.inlet;
3 => mult.op;

SinOsc s => mult;

STEPC stepc1; stepc1.init(HW.lpd8.potar[1][2], .1 /* min */, 60 /* max */, 50::ms /* transition_dur */);
stepc1.out =>  blackhole;

fun void f1 (){ 
while(1) {
  stepc1.out.last() => s.freq;
  1::samp => now;
}
 
   } 
   spork ~ f1 ();
    


//////////////////////////////////////////////////


STGVERB stgverb;
stgverb.connect(last $ ST, .1 /* mix */, 5 * 10. /* room size */, 5::second /* rev time */, 0.2 /* early */ , 0.04 /* tail */ ); stgverb $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
