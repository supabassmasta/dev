SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); //
SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s); // "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"a_" => s.seq;
.9 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//s.go();   
s $ ST @=> ST @ last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .7);  ech $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .9 /* span 0..1 */, 8*data.tick /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 


STRECCONV strecconv;
10 * 1000 => strecconv.inputl.gain => strecconv.inputr.gain; // input signal into reverb only
.3 => strecconv.dry;
0::ms => strecconv.predelay;

//"../_SAMPLES/ConvolutionImpulseResponse/in_the_silo_revised.wav" => strecconv.ir.read; 
//"../_SAMPLES/ConvolutionImpulseResponse/on_a_star_jsn_fade_out.wav" => strecconv.ir.read;
//"../_SAMPLES/ConvolutionImpulseResponse/chateau_de_logne_outside.wav" => strecconv.ir.read;
"../_SAMPLES/ConvolutionImpulseResponse/st_nicolaes_church.wav" => strecconv.ir.read;
strecconv.loadir();

/////   /!\ make seq start after loading IR /!\   ///////////////////
s.no_sync(); // Config it no_sync
s.go();
////////////////////////////////////////////////////////////////

strecconv.connect(last $ ST /* ST */);
strecconv.process();
strecconv.rec(32 * data.tick /* length */, "test4.wav" /* file name */ ); 

while(1) {
       100::ms => now;
}
 
