ST st;
PowerADSR pa1;
PowerADSR pa2;
pa1.set(0::ms , data.tick / 4 , .0000001, data.tick / 4);
pa1.setCurves(2.0, .2, .5);
pa2.set(0::ms , data.tick *4  , .0000001, data.tick / 4);
pa2.setCurves(2.0, 4.0, .5);
5 => pa2.gain;
LPF res;
GVerb gverb0;
SndBuf buf => pa1  =>  res =>  pa2;
Gain gainrev;
pa2 => gainrev => gverb0  => st.mono_in;
.3 => gainrev.gain;

pa2 =>  st.mono_in;
30 => gverb0.roomsize;        // roomsize: (float) [1.0 - 300.0], default 30.0   
2::second => gverb0.revtime;   // revtime: (dur), default 5::second
0.9 => gverb0.dry;             // dry (float) [0.0 - 1.0], default 0.6                
0.0 => gverb0.early;           // early (float) [0.0 - 1.0], default 0.4
0.15 => gverb0.tail;            // tail (float) [0.0 - 1.0], default 0.5       

"../_SAMPLES/HIHAT_02.WAV" => buf.read;
8.6 => buf.gain;
buf.samples() => buf.pos;

60 => res.freq;
19 => res.Q;

.6 => buf.rate;

class ACT extends ACTION {
  SndBuf @ sb;
  PowerADSR @ a1;
  PowerADSR @ a2;
  fun int on_time() {
    0=> sb.pos;
    a1.keyOn();
    a2.keyOn();
    <<<"test">>>; 
  }

}

ACT act; 
buf @=> act.sb; 
pa1@=> act.a1;
pa2@=> act.a2;

SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s); // "test.wav" => s.wav["a"];  // 
act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*2 a__a __a_ a___ aa__" => s.seq;
.9 => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go(); 

while(1) {
       100::ms => now;
}
 
