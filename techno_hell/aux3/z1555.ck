SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"../../_SAMPLES/lsd/lsd.wav" => s.wav["a"];
"../../_SAMPLES/lsd/once.wav" => s.wav["b"];
"../../_SAMPLES/lsd/reallychange.wav" => s.wav["c"];
"../../_SAMPLES/lsd/aware.wav" => s.wav["d"];
"../../_SAMPLES/lsd/happening.wav" => s.wav["e"];
"../../_SAMPLES/lsd/thelsd.wav" => s.wav["f"];
"../../_SAMPLES/lsd/full.wav" => s.wav["g"];
//aware.wav  full.wav  happening.wav    once.wav  reallychange.wav  thelsd.wav

"a___ ____" => s.seq;
.4 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> ST @ last; 

//STFLANGER flang;
//flang.connect(last $ ST); flang $ ST @=>  last; 
//flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  3::ms /* dur base */, 1::ms /* dur range */, .02 /* freq */); 

SinOsc sin0 =>  OFFSET ofs0 => blackhole;
1.3 => ofs0.offset;
0.6 => ofs0.gain;

0.1 => sin0.freq;
1.0 => sin0.gain;


fun void f1 (){ 
    while(1) {
       ofs0.last () => s.wav_o["a"].wav0.rate;
       1::ms => now;
    }
     
   } 
spork ~ f1 ();
    

 STECHO ech;
 ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .6 /* span 0..1 */, data.tick * 5 / 2 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

while(1) {
       100::ms => now;
}


