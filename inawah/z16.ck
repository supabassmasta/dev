SEQ s[5];
0 => int idx;
ST @ last;
 
 //data.tick * 8 => s[idx].max;  //
 SET_WAV.TRIBAL0(s[idx]);// SET_WAV.VOLCA(s[idx]); // SET_WAV.ACOUSTIC(s[idx]); // SET_WAV.TABLA(s[idx]);// SET_WAV.CYMBALS(s[idx]); // SET_WAV.DUB(s[idx]); // SET_WAV.TRANCE(s[idx]); // SET_WAV.TRANCE_VARIOUS(s[idx]);// SET_WAV.TEK_VARIOUS(s[idx]);// SET_WAV.TEK_VARIOUS2(s[idx]);// SET_WAV2.__SAMPLES_KICKS(s[idx]); // SET_WAV2.__SAMPLES_KICKS_1(s[idx]); // SET_WAV.BLIPS(s[idx]); // "test.wav" => s[idx].wav["a"];  // act @=> s[idx].action["a"]; 
 // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
 "
 *4
 __a_
 __<1a_
 __<2a_
 " => s[idx].seq;
 0.4 * data.master_gain => s[idx].gain; // s[idx].gain("s", .2); // for single wav 
 //s[idx].sync(4*data.tick);// s[idx].element_sync(); //s[idx].no_sync(); //s[idx].full_sync();  // 16 * data.tick => s[idx].extra_end;   //s[idx].print();
 // s[idx].mono() => dac; //s[idx].left() => dac.left; //s[idx].right() => dac.right;
 s[idx].go();     s[idx] $ ST @=>  last; 
  
  1 +=> idx; 

 //data.tick * 8 => s[idx].max;  //
 SET_WAV.TRIBAL0(s[idx]);// SET_WAV.VOLCA(s[idx]); // SET_WAV.ACOUSTIC(s[idx]); // SET_WAV.TABLA(s[idx]);// SET_WAV.CYMBALS(s[idx]); // SET_WAV.DUB(s[idx]); // SET_WAV.TRANCE(s[idx]); // SET_WAV.TRANCE_VARIOUS(s[idx]);// SET_WAV.TEK_VARIOUS(s[idx]);// SET_WAV.TEK_VARIOUS2(s[idx]);// SET_WAV2.__SAMPLES_KICKS(s[idx]); // SET_WAV2.__SAMPLES_KICKS_1(s[idx]); // SET_WAV.BLIPS(s[idx]); // "test.wav" => s[idx].wav["a"];  // act @=> s[idx].action["a"]; 
 // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
 "
 *4
 __b_
 __<1b_
 " => s[idx].seq;
 0.8 * data.master_gain => s[idx].gain; // s[idx].gain("s", .2); // for single wav 
 //s[idx].sync(4*data.tick);// s[idx].element_sync(); //s[idx].no_sync(); //s[idx].full_sync();  // 16 * data.tick => s[idx].extra_end;   //s[idx].print();
 // s[idx].mono() => dac; //s[idx].left() => dac.left; //s[idx].right() => dac.right;
 s[idx].go();     s[idx] $ ST @=>  last; 
  
  1 +=> idx; 

 //data.tick * 8 => s[idx].max;  //
 SET_WAV.TRIBAL0(s[idx]);// SET_WAV.VOLCA(s[idx]); // SET_WAV.ACOUSTIC(s[idx]); // SET_WAV.TABLA(s[idx]);// SET_WAV.CYMBALS(s[idx]); // SET_WAV.DUB(s[idx]); // SET_WAV.TRANCE(s[idx]); // SET_WAV.TRANCE_VARIOUS(s[idx]);// SET_WAV.TEK_VARIOUS(s[idx]);// SET_WAV.TEK_VARIOUS2(s[idx]);// SET_WAV2.__SAMPLES_KICKS(s[idx]); // SET_WAV2.__SAMPLES_KICKS_1(s[idx]); // SET_WAV.BLIPS(s[idx]); // "test.wav" => s[idx].wav["a"];  // act @=> s[idx].action["a"]; 
 // _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
 "
 *4
 __c_
 __>2c_
 __<1c_
 __>1c_
 __c_
 " => s[idx].seq;
 0.7 * data.master_gain => s[idx].gain; // s[idx].gain("s", .2); // for single wav 
 //s[idx].sync(4*data.tick);// s[idx].element_sync(); //s[idx].no_sync(); //s[idx].full_sync();  // 16 * data.tick => s[idx].extra_end;   //s[idx].print();
 // s[idx].mono() => dac; //s[idx].left() => dac.left; //s[idx].right() => dac.right;
 s[idx].go();     s[idx] $ ST @=>  last; 
  
  1 +=> idx; 


  while(1) {
         100::ms => now;
  }
   
