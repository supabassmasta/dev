SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // 
SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*4 k__ku__s ksk_ uk_s" => s.seq;
.9 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> ST @ last; 

STOVERDRIVE stod;
stod.connect(last $ ST, 7.1 /* drive 1 == no drive, > 1 == drive */ ); stod $ ST @=> last; 

STGAIN stgain;
stgain.connect(last $ ST , 0.3 /* static gain */  );       stgain $ ST @=>  last; 

//    class STFILTER extends ST{
//      FILTERX_PATH fpath;
//    
//      fun void connect(ST @ tone, FILTERX_FACTORY @ factory, float f, float q, int order, int channels) {
//        fpath.build(channels,  order, factory);
//         fpath.freq(f);
//         fpath.Q(q);
//       
//         if ( channels == 1  ){
//             tone.left() => fpath.in[0];
//             tone.right() => Gain trash;
//             fpath.out[0] => outl;
//             fpath.out[0] => outr;
//         }
//         else if (channels > 1) {
//            tone.left() => fpath.in[0];
//            tone.right() => fpath.in[1];
//     
//            fpath.out[0] => outl;
//            fpath.out[1] => outr;
//         }
//      }
//    
//    }

STFILTER stfilter; LPF_XFACTORY stfilterfactory;
stfilter.connect(last $ ST ,  stfilterfactory, 9* 100.0 /* freq */ , 1.0 /* Q */ , 3 /* order */, 3 /* channels */ );       stfilter $ ST @=>  last; 
//stfilter.connect(last $ ST ,  new FILTERX_FACTORY, 9* 100.0 /* freq */ , 1.0 /* Q */ , 3 /* order */, 3 /* channels */ );       stfilter $ ST @=>  last; 

//SqrOsc sqr0 => stfilter.fpath.in[2]; 
//100.0 => sqr0.freq;
//0.1 => sqr0.gain;
//0.5 => sqr0.width;
//stfilter.fpath.out[2] => dac; 



//STAUTOPAN autopan;
//autopan.connect(last $ ST, .9 /* span 0..1 */, data.tick * 8 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 




while(1) {
       100::ms => now;
}
 
