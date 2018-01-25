ST st;
SndBuf buf => st.mono_in;
"../_SAMPLES/BluezoneCorporation/GlitchAndDarkMinimalHouse/WAV/Loops 132BPM/Bluezone-GDM-loop-020-132bpm.wav" => buf.read;
.2 => buf.gain;
buf.samples() => buf.pos;
200./132. => buf.rate;

class ACT extends ACTION {
	    SndBuf @ sb;
			    fun int on_time() {
						        0=> sb.pos;
										        <<<"test">>>; 
														    }
}

ACT act; 
buf @=> act.sb; 

SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s); // "test.wav" => s.wav["a"];  // 
act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
":2 _a" => s.seq;
.3 => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go(); 

while(1) {
	     100::ms => now;
}
 
