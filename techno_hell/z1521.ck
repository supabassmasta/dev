class synt0 extends SYNT{

    inlet => SawOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {
          0.0 => s.phase;
          } 0 => own_adsr;
} 


TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
//!1!5!3!1
"*4   {c

!1!1!1!1 !1!1!3!1
!1!1!1!1 !1!1!0!1
!1!1!1!1 !1!1!3!1
!1!1!1!1 !1!1!1!1 


" => t.seq;
.6 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STSYNCLPF stsynclpf;
stsynclpf.freq(10 * 10 /* Base */, 8 * 100 /* Variable */, 1.5 /* Q */);
stsynclpf.adsr_set(.0004 /* Relative Attack */, .25/* Relative Decay */, .3 /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpf.nio.padsr.setCurves(1.0, .4, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpf.connect(last $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 


STLPFN lpfn;
lpfn.connect(last $ ST , 5 * 100 /* freq */  , 1.0 /* Q */ , 3 /* order */ );       lpfn $ ST @=>  last;  

STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
