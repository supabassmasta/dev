class synt0 extends SYNT{

    inlet => SqrOsc s =>  outlet; 
      .99 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 


TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 {c{c{c{c{c
c////1 ____ 
____ ____ 
____ f//F__ 
____ ____ 
___Q/g ____ 
" => t.seq;
.12 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//STSYNCLPF stsynclpf;
//stsynclpf.freq(100 /* Base */, 6 * 100 /* Variable */, 13. /* Q */);
//stsynclpf.adsr_set(.2 /* Relative Attack */, .9/* Relative Decay */, 0.000001 /* Sustain */, .0 /* Relative Sustain dur */, 0.1 /* Relative release */);
//stsynclpf.connect(t $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 

STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 13 /* Q */, 100 /* f_base */ , 6 * 100  /* f_var */, 1::second / (2.4 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STFILTERMOD fmod2;
fmod2.connect( t , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 13 /* Q */, 200 /* f_base */ , 8 * 100  /* f_var */, 1::second / (3.3 * data.tick) /* f_mod */);     fmod2  $ ST @=>  last; 

//STABSATURATOR stabsat;
//stabsat.connect(last, 14.0 /* drive */, 0.00 /* dc offset */); stabsat $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 4 / 4 , .6);  ech $ ST @=>  last; 
ech.connect(fmod $ ST , data.tick * 4 / 4 , .6);  ech $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
