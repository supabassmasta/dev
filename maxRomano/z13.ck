SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); //
SET_WAV.ACOUSTIC(s); // SET_WAV.ACOUSTICTOM(s);// SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // S
SEQ s3;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); //
//SET_WAV.ACOUSTIC(s3);  
SET_WAV.ACOUSTICTOM(s3);
s3.wav["A"] => s.wav["A"];  // act @=> s.action["a"]; 
s3.wav["B"] => s.wav["B"];  // act @=> s.action["a"]; 
s3.wav["C"] => s.wav["C"];  // act @=> s.action["a"]; 
//s3.wav["b"] => s.wav["y"];  // act @=> s.action["a"]; 
//s3.wav["c"] => s.wav["z"];  // act @=> s.action["a"]; 
//
s.wav["U"] => s.wav["u"];  // act @=> s.action["a"]; 
s.wav["M"] => s.wav["K"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  

//K_sA AsAA B_BB CC_u
"*4
P|K___ A_A_ u___ AbA_
K___ A_A_ u__b AbA_
K___ A_A_ u___ AbA_
K___ A_A_ u__b A_A|aa

Y|K___ A_A_ u___ AbA_
K___ A_A_ u__b AbA_
K___ A_A_ u___ AbA_
K___ A_A_ u__b A_Au

" => s.seq;
.9 * data.master_gain => s.gain; 
 s.gain("K", 2.2); // for single wav 
 s.gain("b", 0.4); // for single wav 
 s.gain("a", 0.4); // for single wav 
 s.gain("x", 0.2); // for single wav 
 s.gain("y", 0.2); // for single wav 
 s.gain("z", 0.2); // for single wav 
 s.gain("A", 0.25); // for single wav 
 s.gain("B", 0.25); // for single wav 
 s.gain("C", 0.25); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); //
1.35=> s.wav_o["A"].wav0.rate; // s.out("k") /* return ST */
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// 
SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("T", s2.wav["u"]);  s.gain_subwav("u", 0, .9);
s.go();     s $ ST @=> ST @ last;

STCOMPRESSOR stcomp;
4. => float in_gain;
stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.3 /* thresh */, 3::ms /* attackTime */ , 23::ms /* releaseTime */);   stcomp $ ST @=>  last;   

STBELL stbell0; 
stbell0.connect(last $ ST , 50 /* freq */ , 1.0 /* Q */ , 1 /* order */, 1 /* channels */, 0.8 /* Gain */ );       stbell0 $ ST @=>  last;   


while(1) {
       100::ms => now;
}
 
