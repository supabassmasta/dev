class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 
class synt1 extends SYNT{

    inlet => SqrOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 


POLYTONE pt;

3 => pt.size;

// data.tick * 5 => pt.max; // 60::ms => pt.t[0].glide;//
1 * data.tick => pt.t[0].the_end.fixed_end_dur; // 16 * data.tick => pt.extra_end;  

// /!\ Not managed for all TONE in POLY TONE
//pt.t[0].force_off_action();
// pt.t[0].mono() => dac;//  pt.t[0].left() => dac.left; // pt.t[0].right() => dac.right; // pt.t[0].raw => dac;

pt.dor();// pt.lyd();// pt.ion();// pt.mix();// pt.aeo();// pt.phr();// pt.loc();// pt.double_harmonic();// pt.gypsy_minor();
//pt.sync(4*data.tick);// pt.element_sync();//  pt.no_sync();//  pt.full_sync();

.6 * data.master_gain =>  pt.gain_common;
.2 * data.master_gain => pt.t[1].gain; // For individual gain
.2 * data.master_gain => pt.t[2].gain; // For individual gain

pt.t[0].reg(PLOC0 s0); 
pt.t[1].reg(synt0 s1); 
pt.t[2].reg(synt1 s2);

pt.adsr0_set(10::ms, 1000::ms, .8, 300::ms); // Only works for ADSR 0
pt.adsr0_setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave

// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"1___ ___B 1___ ____ " +=> pt.tseq[0];
"1___ ___3 1___ ____ " +=> pt.tseq[0];

" }c __*4 8765 4321 :4 ____ ____ ____" +=> pt.tseq[1];
"  __*4 8756 3421 :4 ____ ____ ____" +=> pt.tseq[1];

"{c{c{c{c ____ ____ __d/D_ ____ " +=> pt.tseq[2];
" __G/f_ ____ ____ ____ " +=> pt.tseq[2];
" ____ ____ __D/dd/D ____ " +=> pt.tseq[2];
" __G/z_ ____ ____ ____ " +=> pt.tseq[2];


pt.go();

// CONNECTIONS
//pt.stout_connect(); pt.stout $ ST  @=> ST @ last; // comment to connect each TONE separately
 pt.t[0] $ ST @=> ST @ last; 

STGAIN stgain;
stgain.connect(last $ ST , 3. /* static gain */  );       stgain $ ST @=>  last; 
stgain.connect(pt.t[1]  $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .1 /* mix */, 14 * 10. /* room size */, 11::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb $ ST @=>  last; 

 pt.t[2] $ ST @=>  last; 

STSYNCLPF stsynclpf;
stsynclpf.freq(100 /* Base */, 61 * 100 /* Variable */, 5. /* Q */);
stsynclpf.adsr_set(.02 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .02 /* Relative Sustain dur */, 0.9 /* Relative release */);
stsynclpf.nio.padsr.setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpf.connect(last $ ST, pt.t[2].note_info_tx_o); stsynclpf $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
