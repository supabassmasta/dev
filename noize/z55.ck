class synt0 extends SYNT{

    inlet => PowerADSR padsr => SawOsc s =>  outlet; 
    padsr.set(3::ms, 20::ms, .5 , 20::ms);
    padsr.setCurves(.6, .4, .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
      .5 => s.gain;

        fun void on()  { }  fun void off() {padsr.keyOff(); }  fun void new_note(int idx)  {padsr.keyOn(); } 0 => own_adsr;
} 


TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*8 {c 
29_2 99_2 _92_
" => t.seq;
.5 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STSYNCLPF stsynclpf;
stsynclpf.freq(100 /* Base */, 7 * 100 /* Variable */, 4. /* Q */);
stsynclpf.adsr_set(.02 /* Relative Attack */, .4/* Relative Decay */, .000001 /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpf.connect(t $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 

STHPF hpf;
hpf.connect(last $ ST , 100 /* freq */  , 1.0 /* Q */  );       hpf $ ST @=>  last; 

STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 5 /* Q */, 2 * 100 /* f_base */ , 4 * 100  /* f_var */, 5::second / (7 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 1 / 4 + 30::ms , .7);  ech $ ST @=>  last; 

STLIMITER stlimiter;
7. => float in_gainl;
stlimiter.connect(last $ ST , in_gainl /* in gain */, 1./in_gainl + .1 /* out gain */, 0.0 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stlimiter $ ST @=>  last;   


STAUTOPAN autopan;
autopan.connect(last $ ST, .7 /* span 0..1 */, 5*data.tick /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
