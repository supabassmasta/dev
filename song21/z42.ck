class STGVERB2 extends ST{

  GVerb gverbl  => outl;
  GVerb gverbr  => outr;

  .0 => gverbl.gain => gverbr.gain;

  30        => gverbl.roomsize=> gverbr.roomsize;        // roomsize: (float) [1.0 - 300.0], default 30.0   
  1::second => gverbl.revtime; gverbl.revtime() - 10::ms => gverbr.revtime;    // revtime: (dur), default 5::second
  0.8       => gverbl.dry     => gverbr.dry;             // dry (float) [0.0 - 1.0], default 0.6                
  0.5       => gverbl.early;  gverbl.early()  - 0.01  => gverbr.early;           // early (float) [0.0 - 1.0], default 0.4
  0.3       => gverbl.tail ;  gverbl.tail()  -0.02   => gverbr.tail;            // tail (float) [0.0 - 1.0], default 0.5       


  fun void connect(ST @ tone, float mix, float rooms, dur rt, float earl, float tail) {
    tone.left() => gverbl;
    tone.right() => gverbr;

    rooms     => gverbl.roomsize=> gverbr.roomsize;        // roomsize: (float) [1.0 - 300.0], default 30.0   
    rt        => gverbl.revtime => gverbr.revtime;   // revtime: (dur), default 5::second
    1. - mix  => gverbl.dry     => gverbr.dry;             // dry (float) [0.0 - 1.0], default 0.6         
    earl      => gverbl.early   => gverbr.early;           // early (float) [0.0 - 1.0], default 0.4
    tail      => gverbl.tail    => gverbr.tail;            // tail (float) [0.0 - 1.0], default 0.5       

    1.0 => gverbl.gain => gverbr.gain;

  }


}


SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); //
SET_WAV.TRIBAL(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"__s_" => s.seq;
.9 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go();     s $ ST @=> ST @ last; 

//STCOMPRESSOR stcomp;
//12. => float in_gain;
//stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain + .1 /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stcomp $ ST @=>  last;   


//STGVERB stgverb2;
//stgverb2.connect(last $ ST, .2 /* mix */, 1 * 10. /* room size */, 1::second /* rev time */, 0.4 /* early */ , 0.2 /* tail */ ); stgverb2 $ ST @=>  last;

STGVERB2 stgverb;
stgverb.connect(last $ ST, .5 /* mix */, 14 * 10. /* room size */, 11::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb $ ST @=>  last;


while(1) {
       100::ms => now;
}
 
