SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
SET_WAV.ACOUSTIC(s); // SET_WAV.ACOUSTICTOM(s);// SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*2 khsh k_kt" => s.seq;
.6 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> ST @ last; 

//STGAIN stgain;
//stgain.connect(s.out("s") , 0. /* static gain */  );       stgain $ ST @=>  last; 
//   STECHO ech;
//   ech.connect(s.out("s") , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 
//   //ech.connect(s.out("t") , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 
//   
//     STGVERB stgverb;
//     stgverb.connect(s.out("s"), .9 /* mix */, 4 * 10. /* room size */, 3::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 
//     3. => stgverb.gain;
//  
  STADSR stadsr;
  stadsr.set(0::ms /* Attack */, 51::ms /* Decay */, .0 /* Sustain */, 100::ms /* Sustain dur of Relative release pos (float) */,  10::ms /* release */);
//  stadsr.connect(s.out("h"), s.note_info_tx_o);  stadsr  $ ST @=>  last;
  stadsr.connect(last, s.note_info_tx_o);  stadsr  $ ST @=>  last;
  //stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
  // stadsr.keyOn(); stadsr.keyOff(); 
1::samp => now;
0 => int i;
while(1) {
       s.s.duration => now;
       <<<i>>>; 1 +=> i;

}
 
