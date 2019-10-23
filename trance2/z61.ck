class synt0 extends SYNT{

    inlet => blackhole;
    SqrOsc s =>  outlet; 
      .5 => s.gain;
      Std.mtof(53 - 4 *12) => s.freq;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  

"{7{c{c{c *2
_1
"
 => t.seq;
0.5 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 


STSYNCLPF stsynclpf;
stsynclpf.freq(41 * 100 /* Base */, 13 * 100 /* Variable */, 1.6 /* Q */);
stsynclpf.adsr_set(.05 /* Relative Attack */, .8/* Relative Decay */, 0.000001 /* Sustain */, .001 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynclpf.connect(last $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 


//STEPC stepc; stepc.init(HW.lpd8.potar[1][1], 0 /* min */, 20000 /* max */, 50::ms /* transition_dur */);
//stepc.out => stsynclpf.nio.filter_freq;


STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 4 /* Q */, 23 * 10 /* f_base */ , 7 *100  /* f_var */, 1::second / (21 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STHPF hpf;
hpf.connect(last $ ST , 200 /* freq */  , 1.0 /* Q */  );       hpf $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .20 /* mix */, 10 * 12. /* room size */, 2.4::second /* rev time */, 0.1 /* early */ , 0.5 /* tail */ ); stgverb $ ST @=>  last; 

//STECHO ech;
//ech.connect(last $ ST , data.tick * 1 / 6 , .6);  ech $ ST @=>  last; 

//STCOMPRESSOR stcomp;
//17. => float in_gain;
//stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stcomp $ ST @=>  last;   

while(1) {
       100::ms => now;
}
 
