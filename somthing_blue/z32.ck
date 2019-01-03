SEQ s;  //data.tick * 8 => s.max;  //
SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s); // "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to _current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"
*8
____ ____  ___(4s _)4s__
____ ____  __)4s(4t )4s(4t)4t_
____ ____  _(4s_)4s __(4t_
____ _(4s_)4s  _(4s_)4t _(4t)4t_

" => s.seq;
.2 * data.master_gain => s.gain; //
s.gain("k", 1.0); // for single wav 
s.gain("c", .5); // for single wav 
//s.gain("h", 1.7); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go();     s $ ST @=> ST @ last; 

STADSR stadsr;
stadsr.set(0::ms /* Attack */, 19::ms /* Decay */, .6 /* Sustain */, 0::ms /* Sustain dur */,  10::ms /* release */);
stadsr.connect(last $ ST, s.note_info_tx_o);  stadsr  $ ST @=>  last; 

STREV2 rev; // DUCKED
rev.connect(last $ ST, .1 /* mix */);      rev $ ST @=>  last; 
while(1) {
	     100::ms => now;
}
 
