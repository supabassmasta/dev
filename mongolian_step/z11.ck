SEQ s;  //data.tick * 8 => s.max;  // 
SET_WAV.TRIBAL0(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s); // "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*6
pno_ onp__
po_o  _onp__

" => s.seq;
.5 => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 
16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go();     s $ ST @=> ST @ last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 1 / 4 , .8);  ech $ ST @=>  last; 

//STAUTOPAN autopan;
//autopan.connect(last $ ST, .9 /* span 0..1 */, 5*data.tick /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STFILTERMOD fmod;
fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 1.2 /* Q */, 1100 /* f_base */ , 1400  /* f_var */, 2::second / (3 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 

