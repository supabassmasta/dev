SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); //
SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s); // "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*4K_+9hh K|T_hh" => s.seq;
.7 => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go();     s $ ST @=> ST @ last; 

/*
class STBREAK extends ST{
    Break bl => outl;
    Break br => outr;

  fun void connect(ST @ tone, int break_number) {
    bl.register(break_number * 2);
    br.register(break_number * 2 + 1);

    tone.left() => bl;
    tone.right() => br;
  }

}
*/

//ST st;
//s.mono() => st.mono_in;
//st @=>last;

STBREAK stbreak;
stbreak.connect(last $ ST, 0 /* break_number, max 3 */);   stbreak $ ST @=>last; 
// To add in break script
//Break.stbreak_set(0) @=> s.action["a"];  "" => s.wav["a"]; 
//Break.stbreak_release(0) @=> s.action["b"]; "" => s.wav["b"];
// Release a break : Break.release(0);

/*
Break b0;

s.mono() => b0 => dac;
b0.register(0);
*/

//STDUCKMASTER duckm;
//duckm.connect(last $ ST, 9. /* In Gain */, .14 /* Tresh */, .2 /* Slope */, 2::ms /* Attack */, 30::ms /* Release */ );      duckm $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
