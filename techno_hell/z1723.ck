class synt0 extends SYNT{

    inlet => SawOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {
          0.0 => s.phase;
          } 0 => own_adsr;
} 
TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
//t.reg(PSYBASS4 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 {c{c
 __!1!1__!1!1__!1!1__!1!1  __!1!1__!1!1__!1!1__!1!1  __8//1 __!1!1__!1!1__!1!1  __!1!1__!1!1________ 
 __!1!1__!1!1__!1!1__!1!1  __!1!1__!1!1__!1!1__!1!1 :2 _8/1______ ________" => t.seq;
1.5 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//STFLANGER flang;
//flang.connect(last $ ST); flang $ ST @=>  last; 
//flang.add_line(2 /* 0 : left, 1: right 2: both */, .5 /* delay line gain */,  4::ms /* dur base */, 3::ms /* dur range */, .12 /* freq */); 

STSYNCLPF stsynclpf;
stsynclpf.freq(10 * 10 /* Base */, 4 * 100 /* Variable */, 1.3 /* Q */);
stsynclpf.adsr_set(.0004 /* Relative Attack */, .25/* Relative Decay */, .3 /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpf.nio.padsr.setCurves(1.0, .3, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpf.connect(last $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 


STLPFN lpfn;
lpfn.connect(last $ ST , 33 * 10 /* freq */  , 1.1 /* Q */ , 4 /* order */ );       lpfn $ ST @=>  last;  

while(1) {
       100::ms => now;
}
 
