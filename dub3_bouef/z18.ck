  MidiOut  mo;
  mo.open(2);
<<< "MIDI device:", mo.num(), " -> ", mo.name() >>>;

class ACT extends ACTION {
  MidiOut @ mout;
//  mout.open(3);


  1 => int start;
  MidiMsg msg;
		
		0 => int tog;

  fun int on_time() {
		if (tog ==0) {
			0x90 => msg.data1;
			64 => msg.data2;
			0x7F => msg.data3;
			1+tog=>tog;
		}
		else if (tog==1) {
			0x90 => msg.data1;
			65 => msg.data2;
			0x7F => msg.data3;
			1+tog=>tog;

		}
		else {
			0x90 => msg.data1;
			66 => msg.data2;
			0x7F => msg.data3;

			0=>tog;

		}
		/*
			 0xC1 => msg.data1;
			 0x0a => msg.data2;
			 0x1 => msg.data3;
		 */


		mout.send(msg);

		//              <<<"test">>>; 
  }


}

ACT act; 
mo @=> act.mout;

SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s); // "test.wav" => s.wav["a"];  

act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*6*4 a" => s.seq;
.9 => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go();     s $ ST @=> ST @ last; 


60 * 1000::ms / 115 => dur bpm;
<<<bpm/1::ms,  bpm/24::ms >>>; 


2048 * 2 * 1000::ms / 44100 => dur lat;

<<<"lat", lat/1::ms>>>; 

while(1) {
       100::ms => now;
}
 


