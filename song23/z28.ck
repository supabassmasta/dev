SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); //
//SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// 
SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"
*6
ZML___M__L___LZM____ZZ___ __



" => s.seq;
.8 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go();     s $ ST @=> ST @ last; 


STADSR stadsr;
stadsr.set(0::ms /* Attack */, 9::ms /* Decay */, 0.0001/* Sustain */, 100::ms /* Sustain dur */,  30::ms /* release */);
stadsr.connect(last $ ST, s.note_info_tx_o);  stadsr  $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .5);  ech $ ST @=>  last; 

STFILTERMOD fmod;
fmod.connect( last , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 4 /* Q */, 600 /* f_base */ , 4400  /* f_var */, 1::second / (5 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STFILTERMOD fmod2;
fmod2.connect( ech , "ResonZ" /* "HPF" "BPF" BRF" "ResonZ" */, 3 /* Q */, 600 /* f_base */ , 4400  /* f_var */, 1::second / (7 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
stgain.connect(fmod $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .8 /* span 0..1 */, 6*data.tick /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech2;
ech2.connect(last $ ST , data.tick * 8 / 4 , .6);  ech2 $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .4 /* mix */, 4 * 10. /* room size */, 11::second /* rev time */, 0.0 /* early */ , 0.4 /* tail */ ); stgverb $ ST @=>  last; 


STDUCK duck;
duck.connect(last $ ST);      duck $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
