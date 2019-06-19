SEQ s;  //data.tick * 8 => s.max;  //
SET_WAV.TRIBAL(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*8ts__ :8~__ ____ ____ ____ ____" => s.seq;
.9 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go();     s $ ST @=> ST @ last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 2 / 4 , 1.0);  ech $ ST @=>  last; 

STSYNCRES stsynclpf;
stsynclpf.freq(1100 /* Base */, 4 * 1000 /* Variable */, 4. /* Q */);
stsynclpf.adsr_set(3. /* Relative Attack */, .01/* Relative Decay */, 1. /* Sustain */, .01 /* Relative Sustain dur */, 3. /* Relative release */);
stsynclpf.connect(last $ ST, s.note_info_tx_o); stsynclpf $ ST @=>  last; 

//STSYNCHPF stsyncres;
//stsyncres.freq(100 /* Base */, 3 * 1000 /* Variable */, 4. /* Q */);
//stsyncres.adsr_set(4. /* Relative Attack */, .01/* Relative Decay */, 1. /* Sustain */, .01 /* Relative Sustain dur */, 8. /* Relative release */);
//stsyncres.connect(last $ ST, s.note_info_tx_o); stsyncres $ ST @=>  last; 

STADSR stadsr;
stadsr.set(0::ms /* Attack */, 6::ms /* Decay */, 1. /* Sustain */, data.tick * 2 /* Sustain dur */,  data.tick * 6 /* release */);
stadsr.connect(last $ ST, s.note_info_tx_o);  stadsr  $ ST @=>  last; 

STLIMITER stlimiter;
4. => float in_gainl;
stlimiter.connect(last $ ST , in_gainl /* in gain */, 1./in_gainl /* out gain */, 0.0 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stlimiter $ ST @=>  last;   

16 * data.tick => now;

