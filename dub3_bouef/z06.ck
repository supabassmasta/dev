  MidiOut  mo;
  mo.open(3);
<<< "MIDI device:", mo.num(), " -> ", mo.name() >>>;

class ACT extends ACTION {
  MidiOut @ mout;
//  mout.open(3);


  1 => int start;
  MidiMsg msg;

  fun int on_time() {
//    if ( start ){

      252 => msg.data1;
      9 => msg.data2;
      0 => msg.data3;
      mout.send(msg);
    242 => msg.data1;
    0 => msg.data2;
    0 => msg.data3;
    mout.send(msg);
    
    250 => msg.data1;
    9 => msg.data2;
    0 => msg.data3;
    mout.send(msg);

////      0=> start;

//    }
//    else {
//      248 => msg.data1;
//      9 => msg.data2;
//      0 => msg.data3;

//      mout.send(msg);
//    }



              <<<"START">>>; 
  }


}

ACT act; 
mo @=> act.mout;

SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); // SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s); // "test.wav" => s.wav["a"];  

act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
" a___ ____" => s.seq;
.9 => s.gain; // s.gain("s", .2); // for single wav 
s.sync(4*data.tick);// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go();     s $ ST @=> ST @ last; 

while(1) {
       100::ms => now;
}
 


