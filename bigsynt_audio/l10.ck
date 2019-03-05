SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s); //
"../bigsynt_silent/test8.wav" => s.wav["a"];  // act @=> s.action["a"]; 
"../bigsynt_silent/test2.wav" => s.wav["b"];  // act @=> s.action["a"]; 
"../bigsynt_silent/test3.wav" => s.wav["c"];  // act @=> s.action["a"]; 
"../bigsynt_silent/test4.wav" => s.wav["d"];  // act @=> s.action["a"]; 
"../bigsynt_silent/test5_pop_removed.wav" => s.wav["e"];  // act @=> s.action["a"]; 
"../bigsynt_silent/test6.wav" => s.wav["f"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
//ab$a$ba_$a__b$b_a$b$a__
":8
a___
" => s.seq;
2.8 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go();     s $ ST @=> ST @ last; 

//STFILTERMOD fmod;
//fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 2 /* Q */, 500 /* f_base */ , 300  /* f_var */, 1::second / (7 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

//STAUTOPAN autopan;
//autopan.connect(last $ ST, .3 /* span 0..1 */, 8*data.tick /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

//STECHO ech;
//ech.connect(last $ ST , data.tick * 3 - 10::ms , .4);  ech $ ST @=>  last; 

//STBPF bpf;
//bpf.connect(last $ ST , 230 /* freq */  , 4.0 /* Q */  );       bpf $ ST @=>  last; 

//STLPF lpf;
//lpf.connect(last $ ST , 1000 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 

//STREV2 rev;
//rev.connect(last $ ST, .3 /* mix */);     rev  $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
