class synt0 extends SYNT{

    inlet => SqrOsc s =>  outlet; 
      .5 => s.gain;
    
    .12 => s.width;

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
.35 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STSYNCLPF stsynclpf;
stsynclpf.freq(3 * 100 /* Base */, 20 * 100 /* Variable */, 3. /* Q */);
stsynclpf.adsr_set(.04 /* Relative Attack */, .2/* Relative Decay */, 0.00001 /* Sustain */, .4 /* Relative Sustain dur */, 0.5 /* Relative release */);
stsynclpf.connect(last $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 

STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 3 /* Q */, 3 * 100 /* f_base */ , 50 * 100  /* f_var */, 1::second / (14 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .2 /* mix */, 13 * 10. /* room size */, 5::second /* rev time */, 0.2 /* early */ , 0.12 /* tail */ ); stgverb $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
