 SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); //
 SET_WAV.ACOUSTIC(s); // SET_WAV.ACOUSTICTOM(s);// SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s); //SET_WAV.TRANCE_KICK(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
 // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
 "*2
 __h_ __h_  h_h_ __hh
 __h_ __h_  h_h_ __*2hhhh :2
 __h_ __h_  h_h_ __hh
 __h_ __h_  h_h_ __*4hhhh hhhh:4
 " => s.seq;
 1.3 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
 //s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate; // s.out("k") /* return ST */
 // s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
 //// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
 s.go();     s $ ST @=> ST @ last; 

STPADSR stpadsr;
stpadsr.set(1::ms /* Attack */, 62::ms /* Decay */, 0.1 /* Sustain */, 10::ms /* Sustain dur of Relative release pos (float)*/,  10::ms /* release */);
stpadsr.setCurves(1.0, 2.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
stpadsr.connect(last $ ST, s.note_info_tx_o); stpadsr $ ST @=>  last;
//stpadsr.connect(s $ ST);  stpadsr  $ ST @=>  last; 
// stpadsr.keyOn(); stpadsr.keyOff(); 


STFILTERX sthpfx0; HPF_XFACTORY sthpfx0_fact;
sthpfx0.connect(last $ ST ,  sthpfx0_fact, 11* 100.0 /* freq */ , 2.0 /* Q */ , 1 /* order */, 1 /* channels */ );       sthpfx0 $ ST @=>  last;  

 while(1) {
        100::ms => now;
 }
  