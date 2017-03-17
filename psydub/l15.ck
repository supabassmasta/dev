SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s);
SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);
//SET_WAV.CYMBALS(s); // "test.wav" => s.wav["a"];  
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
" *4  
    _+8)3g__ g_g_
    g_g_ _gg_
    _g__ g_g_
    g_g_ G___

    " => s.seq;
.9 => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go(); 


//s.mono()  => dac;
//s.mono() => LPF lpf => dac;
//27 * 100 => lpf.freq;
//2 => lpf.Q;

while(1) {
       100::ms => now;
}
 
