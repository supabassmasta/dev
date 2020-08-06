SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // 
SET_WAV.TRIBAL0(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"
____ ____ D|s|i___ ____
D|s|i__*2 _s|i:2     D|s|i D|s|i_ *2 _s|i:2     D|s|i*2 _s|i D|s|i D|s|i D|s|i _    s|i D|s|i s|i D|s|i  D|s|i_ __ :2
____
" => s.seq;
//"
//*2 _s|i:2     D|s|i D|s|i_ *2 _s|i:2     D|s|i*2 _s|i D|s|i D|s|i D|s|i _    s|i D|s|i s|i D|s|i s|i D|s|i __ :2
//____
//" => s.seq;
1.2 * data.master_gain => s.gain; //
s.gain("s", .5); // for single wav 
s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //
//s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go();     s $ ST @=> ST @ last; 

STREV1 rev;
rev.connect(last $ ST, .1 /* mix */);     rev  $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
