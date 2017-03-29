fun static void BLIPS ( SEQ @ s) {
	"../_SAMPLES/Dirt_samples/bleep/"  => string dir;

	dir + "bleep.wav" => s.wav["a"];
	dir + "boip.wav" => s.wav["b"];
	dir + "breathy-blip.wav" => s.wav["c"];
	dir + "breathy-blip2.wav" => s.wav["d"];
	dir + "checkpoint-hit.wav" => s.wav["e"];
	dir + "ninjanote.wav" => s.wav["f"];
	dir + "pc_beep.wav" => s.wav["g"];
	dir + "shortsaxish.wav" => s.wav["h"];
	dir + "tiniest.wav" => s.wav["i"];
	dir + "tinynote.wav" => s.wav["j"];
	dir + "vidgame-bleep1.wav" => s.wav["k"];
	dir + "vidgame-bleep2.wav" => s.wav["l"];
	dir + "watch_beep.wav" => s.wav["m"];
	dir + "000_blipp01.wav" => s.wav["n"];
	dir + "001_blipp02.wav" => s.wav["o"];
	dir + "high.wav" => s.wav["p"];
	dir + "low.wav" => s.wav["q"];
  
	"../_SAMPLES/Dirt_samples/click/"  =>  dir;
	dir + "000_click0.wav" => s.wav["r"];
	dir + "001_click1.wav" => s.wav["s"];
	dir + "002_click2.wav" => s.wav["t"];
	dir + "003_click3.wav" => s.wav["u"];

	"../_SAMPLES/Dirt_samples/glitch/"  =>  dir;


	dir + "003_HH.wav" => s.wav["v"];
	dir + "006_P2.wav" => s.wav["w"];
}

SEQ s;
BLIPS(s);
//data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*8 __va__ da_b__qq_ler_m__x s " => s.seq;
.6 => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go(); 

while(1) {
       100::ms => now;
}
 
