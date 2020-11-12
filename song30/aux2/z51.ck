class synt0 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
Step det_amount[synt_nb];
SinOsc s[synt_nb];
Gain final => outlet; .3 => final.gain;

inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  0 => det_amount[i].next;      .6 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  -6.51 => det_amount[i].next;      .02 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final; det_amount[i] => detune[i];  6.51 => det_amount[i].next;      .02 => s[i].gain; i++;   

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 


POLYTONE pt;

3 => pt.size;

// data.tick * 5 => pt.max; // 60::ms => pt.t[0].glide;//
1 * data.tick => pt.t[0].the_end.fixed_end_dur; // 16 * data.tick => pt.extra_end;  

// /!\ Not managed for all TONE in POLY TONE
//pt.t[0].force_off_action();
// pt.t[0].mono() => dac;//  pt.t[0].left() => dac.left; // pt.t[0].right() => dac.right; // pt.t[0].raw => dac;

pt.ion();// pt.lyd();// pt.ion();// pt.mix();// pt.aeo();// pt.phr();// pt.loc();// pt.double_harmonic();// pt.gypsy_minor();
//pt.sync(4*data.tick);// pt.element_sync();//  pt.no_sync();//  pt.full_sync();

.6 * data.master_gain =>  pt.gain_common;
// .6 * data.master_gain => pt.t[0].gain; // For individual gain

pt.t[0].reg(synt0 s0); 
pt.t[1].reg(synt0 s1); 
pt.t[2].reg(synt0 s2); 

pt.adsr0_set(1500::ms, 1000::ms, .8, 3000::ms); // Only works for ADSR 0
pt.adsr0_setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave

// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":4}c " +=> pt.tseq[0];
":4}c " +=> pt.tseq[1];
":4}c " +=> pt.tseq[2];

"111_ 22__  111_ 22__  " +=> pt.tseq[0];
"333_ 444_  333_ 444_  " +=> pt.tseq[1];
"_555 _000  _555 _{c111  " +=> pt.tseq[2];

pt.go();

// CONNECTIONS
pt.stout_connect(); pt.stout $ ST  @=> ST @ last; // comment to connect each TONE separately
// pt.t[0] $ ST @=> ST @ last; 

//STOVERDRIVE stod;
//stod.connect(last $ ST, 15.1 /* drive 1 == no drive, > 1 == drive */ ); stod $ ST @=> last; 

//.04 => stod.gain;

STAUTOFILTERX stautolpfx0; LPF_XFACTORY stautolpfx0_fact;
stautolpfx0.connect(last $ ST ,  stautolpfx0_fact, 1.0 /* Q */, 10 * 100 /* freq base */, 43 * 100 /* freq var */, data.tick * 16 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautolpfx0 $ ST @=>  last;  


STGVERB stgverb;
stgverb.connect(last $ ST, .05 /* mix */, 4 * 10. /* room size */, 2::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
