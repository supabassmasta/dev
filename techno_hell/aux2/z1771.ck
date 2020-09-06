TONE t;
t.reg(SERUM0 s0); s0.config(17, 1); //data.tick * 8 => t.max; //
30::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 }c 

84523 10B21
84523 10B21
84523 10B21

" => t.seq;
.3 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 4 /* Q */, 600 /* f_base */ , 3400  /* f_var */, 1::second / (13 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 

STADSR stadsr;
stadsr.set(3::ms /* Attack */, 6::ms /* Decay */, 1.0 /* Sustain */, 100::ms /* Sustain dur */,  10::ms /* release */);
//stadsr.connect(last $ ST, s.note_info_tx_o);  stadsr  $ ST @=>  last;
stadsr.connect(fmod $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff(); 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 

SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(32 * data.tick , - 6 * data.tick /* offset */); 

while(1) {
stadsr.keyOn();
4 * data.tick => now;
stadsr.keyOff(); 
28 * data.tick => now;
}

while(1) {
       100::ms => now;
}
 
