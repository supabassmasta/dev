class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
//4=> int n;
//2=> int k;
3=> int n;
2=> int k;
t.reg(SERUM0 s0);  s0.config(n, k);
t.reg(SERUM0 s1);  s1.config(n, k);
t.reg(SERUM0 s2);  s2.config(n, k);
t.reg(SERUM0 s3);  s3.config(n, k);
//data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*8 1|5|8_1|5|8_ 1|5|8 1|5|8 1|5|8 1|5|8 ____ ____ 
    ____ ____ ____ ____

" => t.seq;
.4 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //
t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

class STOVERDRIVE extends ST{
  Overdrive ol => outl;
  Overdrive or => outr;

  1. => ol.drive => or.drive;

  fun void connect(ST @ tone, float d) {
    tone.left() => ol;
    tone.right() => or;

    d => ol.drive => or.drive;
  }


}

STSYNCLPF stsynclpf;
stsynclpf.freq(100 /* Base */, 99 * 100 /* Variable */, 1. /* Q */);
stsynclpf.adsr_set(.05 /* Relative Attack */, .7/* Relative Decay */, 0.7 /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpf.nio.padsr.setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stsynclpf.connect(last $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 

STOVERDRIVE stod;
stod.connect(last $ ST, 9.1 /* drive 1 == no drive, > 1 == drive */ ); stod $ ST @=> last;

STFILTERMOD fmod;
fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 1 /* Q */, 15 * 100 /* f_base */ , 30* 100  /* f_var */, 1::second / (13 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

//STLHPFC lhpfc;
//lhpfc.connect(last $ ST , HW.lpd8.potar[1][1] /* freq */  , HW.lpd8.potar[1][2] /* Q */  );       lhpfc $ ST @=>  last; 

STGAIN stgain;
stgain.connect(last $ ST , .3 /* static gain */  );       stgain $ ST @=>  last; 

//STECHO ech;
//ech.connect(last $ ST , data.tick * 1 / 4 , .6);  ech $ ST @=>  last; 
STGVERB stgverb;
stgverb.connect(last $ ST, .0001 /* mix */, 6 * 10. /* room size */, 4::second /* rev time */, 0.1 /* early */ , 0.4 /* tail */ ); stgverb $ ST @=>  last; 

//STLIMITER stlimiter;
//4. => float in_gainl;
//stlimiter.connect(last $ ST , in_gainl /* in gain */, 1./in_gainl /* out gain */, 0.0 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stlimiter $ ST @=>  last;   


while(1) {
       100::ms => now;
}
 
