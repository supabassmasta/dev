class ACT extends ACTION {
    SndBuf @ s;
    fun int on_time() {
              1.3 => s.rate;
              14::ms =>now;
              0.51 => s.rate;
            }
}

ACT act; 

SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.ACOUSTICTOM(s);// SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s); //
SET_WAV.TRANCE_KICK(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // 
act @=> s.action["k"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"k" => s.seq;
0.59 * data.master_gain => s.gain; //
s.gain("L", .4); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); //
//.6 => s.wav_o["k"].wav0.rate; // s.out("k") /* return ST */
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);

s.wav_o["k"].wav0 @=> act.s;

s.go();     s $ ST @=> ST @ last; 

STADSR stadsr;
stadsr.set(18::samp/* Attack */, 6::ms /* Decay */, 1.0 /* Sustain */, 16*10::ms /* Sustain dur of Relative release pos (float) */,  10::ms /* release */);
stadsr.connect(last $ ST, s.note_info_tx_o);  stadsr  $ ST @=>  last;
//stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff(); 


STFILTERX stbpfx0; BPF_XFACTORY stbpfx0_fact;
stbpfx0.connect(last $ ST ,  stbpfx0_fact, 16* 10.0 /* freq */ , 0.1 /* Q */ , 1 /* order */, 1 /* channels */ );       stbpfx0 $ ST @=>  last;  


STDUCKMASTER duckm;
duckm.connect(last $ ST, 7. /* In Gain */, .04 /* Tresh */, .4 /* Slope */, 2::ms /* Attack */, 20::ms /* Release */ );      duckm $ ST @=>  last; 



while(1) {
       100::ms => now;
}
 
