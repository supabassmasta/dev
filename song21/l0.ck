
class ACT extends ACTION {
  SerialIO.list() @=> string list[];

  for(int i; i < list.cap(); i++)
  {
    chout <= i <= ": " <= list[i] <= IO.newline();
  }

  0 => int device;
  if(me.args()) me.arg(0) => Std.atoi => device;

  SerialIO cereal;
  cereal.open(device, SerialIO.B115200, SerialIO.BINARY);

  ['k'] @=> int bytes[];
  fun int on_time() {
    <<<"test">>>; 
    cereal.writeBytes(bytes);
  }

}

ACT act; 


SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); 
SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s); // "test.wav" => s.wav["a"];  // 
act @=> s.action["k"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"k" => s.seq;
.9 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go();     s $ ST @=> ST @ last; 

 




while(true)
{
  
//    cereal.writeBytes(bytes);

    500::ms => now;

}

