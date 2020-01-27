class synt0 extends SYNT{

    inlet => SqrOsc s =>  outlet; 
      .5 => s.gain;
      .05 => s.width;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"
*4
__1_ _5_1 __1!1  __0_
__1_ _5_5 __8!1  __0!0
__1_ _5_1 __1!1  __0_
__1!1 _5!1_ __1!1  _7!0_


" => t.seq;
.3 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//STFLANGER flang;
//flang.connect(last $ ST); flang $ ST @=>  last; 
//flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  6::ms /* dur base */, 2::ms /* dur range */, .2 /* freq */); 

STSYNCLPF2 stsynclpf;
stsynclpf.freq(100 /* Base */, 12 * 100 /* Variable */, 3. /* Q */);
stsynclpf.adsr_set(.05 /* Relative Attack */, .6/* Relative Decay */, .00001 /* Sustain */, .0 /* Relative Sustain dur */, 0.4 /* Relative release */); 
stsynclpf.nio.padsr.setCurves(2.0, 0.9, .5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave

stsynclpf.connect(last $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 


STFILTERMOD fmod;
fmod.connect( last , "HPF" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 100 /* f_base */ , 7 * 100  /* f_var */, 1::second / (7 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .1);  ech $ ST @=>  last; 

//STLHPFC lhpfc;
//lhpfc.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       lhpfc $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
