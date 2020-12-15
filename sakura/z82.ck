SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); //
SET_WAV.ACOUSTIC(s); // SET_WAV.ACOUSTICTOM(s);// SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"s___  ____ ____ ____" => s.seq;
.5 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //
s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate;
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> ST @ last; 


class STECHOV extends ST{
  dur rate;

  Gain fbl => outl;
  fbl => Delay dl => fbl;

  Gain fbr => outr;
  fbr => Delay dr => fbr;

  .5 =>  dl.gain => dr.gain;


  Gain del => blackhole;
  Gain g  => blackhole;

  fun void f1 (){ 
    while(1) {
      del.last() * 1::samp => dl.delay => dr.delay;
      g.last() => dl.gain => dr.gain;

      rate => now;
    }
  } 
  spork ~ f1 ();

  fun void control(dur delsart, dur delstop, dur del_trans_dur, float gainstart, float gainstop, dur gain_trans_dur) {  
    Step stp0 =>  Envelope e0 =>  del;
    delsart / 1::samp => e0.value;
    delstop / 1::samp => e0.target;
    del_trans_dur => e0.duration ;// => now;

    1.0 => stp0.next;

    stp0 => Envelope e1 => g;  
    gainstart => e1.value;
    gainstop => e1.target;
    gain_trans_dur => e1.duration; 
    
    // keep Env connected after transitions
    while(1) {
           100::ms => now;
    }
     
  }


  fun void connect(ST @ tone, dur dmax, dur r) {
    tone.left() => fbl;
    tone.right() => fbr;

    dmax => dl.max => dl.delay => dr.max => dr.delay;

    r => rate;

  }

}


STECHOV echv;
echv.connect(last $ ST , data.tick * 2 , 1::samp);  echv $ ST @=>  last; 
// spork ~ echv.control (data.tick * 3 /4 /* delay sart */ , data.tick * 1 /8/* delay stop */, data.tick * 4 /* delay transition dur */, .8 /* gainstart */, 0.6 /* gainstop */, data.tick * 4 /* gain_trans_dur */ ); 
// =>  echv.del; /* Delay in samp */
// => echv.g;   /* Gain */


// Step stp0 =>  Envelope e0 =>  echv.del;
// 3*data.tick/ 4::samp => e0.value;
// 14::ms/ 1::samp => e0.target;
// 2.0 * data.tick => e0.duration ;// => now;
// 
// 1.0 => stp0.next;
// 
// stp0 => Envelope e1 => echv.g;  
// 0.8 => e1.value;
// 0.8 => e1.target;
// 8.0 * data.tick => e1.duration  => now;

16 * data.tick => now;

 


