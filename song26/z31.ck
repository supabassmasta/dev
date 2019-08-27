SEQ s;
SET_WAV.TRIBAL1(s);

//data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s); // "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
//u_x u_*2z_:2
//*2uu:2_x uy*2zB:2
//u_u x_*2A_:2
//*2BuBu:2x _y*2zB:2
"*3 
u_x u_*2z_:2
uxx u_*2z_:2
u_x uu*2_z:2
uxx u_*2zz:2

uxx u_*2z_:2
u_x uu*2_z:2
uxx u_*2zz:2
:3*4 uuuu :4*3 xxx  

" => s.seq;
.7 => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go();     s $ ST @=> ST @ last; 

STREV1 rev;
rev.connect(last $ ST, .10 /* mix */);     rev  $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
