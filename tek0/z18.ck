SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);

class ACT extends ACTION {
	  fun int on_time() {
			    <<<"test">>>; 
					  }
}

ACT act; 

//SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); /
//SET_WAV2._1017_BrickSquad_Kit_Vocals_And_Chants(s); // "test.wav" => s.wav["a"];  
act @=> s.action["q"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*2  q___ ____ " => s.seq;
.07 => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go(); 

//STDIGIT dig;
//dig.connect(s $ ST , 1::samp /* sub sample period */ , .01 /* quantization */); 

ST st;

s.mono() => PitShift p => st.mono_in;

.6 =>  p.shift;
1.0 => p.mix;

STDUCK duck;
duck.connect(st $ ST); 

STREV2 rev; // DUCKED
rev.connect(st $ ST, .2 /* mix */); 

while(1) {
	     100::ms => now;
}


