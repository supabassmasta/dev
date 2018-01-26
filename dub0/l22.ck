SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); 
SET_WAV.DUB(s); // SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s); // "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
//"*8
//    ____ ____ ____ ____ 
//    ____ +0G___ _I__ +0H___ 
//    G__G __H_ I__I _+G_++G
//    _H_+H ++H__+++H +4H+5H+6H_ +4G+5G+6G+7G 
//    " => s.seq;
"*8
    ____ ____ ____ __H_ 
    " => s.seq;
//    _G_G _I__ H_I_ G_GG 
.5 => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); 
s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go(); 

STECHO ech;
ech.connect(s $ ST , data.tick * 1 / 2 , .7); 

STREV1 rev;
rev.connect(ech $ ST, .4 /* mix */); 

while(1) {
       100::ms => now;
}
 

