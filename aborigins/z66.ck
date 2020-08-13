


SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
//"../../_SAMPLES/Aborigines/abo1.wav" => s.wav["a"];
"../_SAMPLES/Aborigines/aboscream7 warp.wav" => s.wav["b"];
"../_SAMPLES/Aborigines/aboscream1 warp.wav" => s.wav["d"];
"../_SAMPLES/Aborigines/aboscream2 warp.wav" => s.wav["e"];
"../_SAMPLES/Aborigines/aboscream3 warp.wav" => s.wav["f"];
"../_SAMPLES/Aborigines/aboscream4 warp.wav" => s.wav["g"];
"../_SAMPLES/Aborigines/aboscream5 warp.wav" => s.wav["h"];
"../_SAMPLES/Aborigines/aboscream6 warp comp.wav" => s.wav["i"];

 "
 ____ i___
 " => s.seq;
//"
//____ i___
//" => s.seq;
1.2 * data.master_gain => s.gain; //
s.gain("i", 0.4); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); //
24 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> ST @ last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .1 /* mix */, 6 * 10. /* room size */, 3::second /* rev time */, 0.1 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 

6 * data.tick => now;

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .83);  ech $ ST @=>  last; 

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 


4 * data.tick => now;
STGAIN stgain2;
stgain2.connect(ech $ ST , 0.7 /* static gain */  );       stgain2 $ ST @=>  last; 

STFADEIN fadein;
fadein.connect(last, 2*data.tick);     fadein  $ ST @=>  last; 

//STOVERDRIVE stod;
//stod.connect(last $ ST, 10.1 /* drive 1 == no drive, > 1 == drive */ ); stod $ ST @=> last; 

STFLANGER flang;
flang.connect(last $ ST); flang $ ST @=>  last; 
flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  3::ms /* dur base */, 1::ms /* dur range */, 8 /* freq */); 

STAUTOPAN autopan;
autopan.connect(last $ ST, .8 /* span 0..1 */, data.tick * 1 / 2 /* period */, 0.99 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STGAIN stgain3;
stgain3.connect(last $ ST , 1.0 /* static gain */  );       stgain3 $ ST @=>  last; 
stgain3.connect(stgain $ ST , 1.0 /* static gain */  );       stgain3 $ ST @=>  last; 

STLIMITER stlimiter;
2. => float in_gainl;
stlimiter.connect(last $ ST , in_gainl /* in gain */, 1./in_gainl /* out gain */, 0.0 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stlimiter $ ST @=>  last;   
while(1) {
       100::ms => now;
}
 
