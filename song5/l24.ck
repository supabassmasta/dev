
SndBuf snd => ADSR a => dac;
.3 => snd.gain;
"../_SAMPLES/AFRICAN_SET/SNARE1P.wav" => snd.read;
snd.samples() => snd.pos;
a.set(0::ms, 100::ms, .0000001, 0::ms);
class ACT extends ACTION {
    SndBuf @ sn;
    ADSR @a; 
    4.7 => float r;
    
    fun int on_time() {
          <<<"test">>>; 
            r => sn.rate;
            a.keyOn();
//            r + .1 => r;
//            if (r > 1) .1 => r;
            0 => sn.pos;
            }
}

ACT act; 
snd @=> act.sn;
a @=> act.a;

SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // "test.wav" => s.wav["a"];  
act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"a" => s.seq;
.9 => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go(); 

while(1) {
       100::ms => now;
}
 
