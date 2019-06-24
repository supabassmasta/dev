class synt0 extends SYNT{

        8 => int synt_nb; 0 => int i;
        Gain detune[synt_nb];
        SqrOsc s[synt_nb];
        Gain final => outlet; .3 => final.gain;

        inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .13 => s[i].width; .6 => s[i].gain; i++;  
        inlet => detune[i] => s[i] => final;    1.02 => detune[i].gain;    .13 => s[i].width; .6 => s[i].gain; i++;  
        inlet => detune[i] => s[i] => final;    1.03 => detune[i].gain;    .13 => s[i].width; .6 => s[i].gain; i++;  
        inlet => detune[i] => s[i] => final;    2.02 => detune[i].gain;    .13 => s[i].width; .4 => s[i].gain; i++;  
        inlet => detune[i] => s[i] => final;    2.03 => detune[i].gain;    .13 => s[i].width; .4 => s[i].gain; i++;  
        inlet => detune[i] => s[i] => final;    3.01 => detune[i].gain;    .13 => s[i].width; .2 => s[i].gain; i++;  
        inlet => detune[i] => s[i] => final;    3.02 => detune[i].gain;    .13 => s[i].width; .2 => s[i].gain; i++;  

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
}

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // 
t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 
1!1!1_ ____
____ ____
____ ____
____ ____

____ ____
____ ____
____ ____
____ ____

5!1!1_ ____
____ ____
____ ____
____ ____

____ ____
____ ____
____ ____
____ ____

" => t.seq;
1.6 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 
8 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last;


STSYNCLPF stsynclpf;
stsynclpf.freq(100 /* Base */, 54 * 100 /* Variable */, 2. /* Q */);
stsynclpf.adsr_set(.4 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynclpf.connect(t $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 4 / 4 , .8);  ech $ ST @=>  last; 

STFILTERMOD fmod;
fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 4 /* Q */, 600 /* f_base */ , 6500  /* f_var */, 1::second / (7 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STCOMPRESSOR stcomp;
4. => float in_gain;
stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 30::ms /* releaseTime */);   stcomp $ ST @=>  last;   

while(1) {
       100::ms => now;
}


