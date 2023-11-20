<<<"MULTIPISTE REC TEST">>>;
<<<"MULTIPISTE REC TEST">>>;
<<<"MULTIPISTE REC TEST">>>;
<<<"MULTIPISTE REC TEST">>>;


class MULTIREC {
  ST probe[0]; // will be inserted in the code
  ST in[0];
  STREC strec[0];
  string track_name[0];
  1::second => dur rec_dur;
  0 => int disable;

  fun void  add_track (string name){ 
     if ( ! disable  ){
       track_name << name;
       new STREC @=> strec[name];
       new ST @=> in[name];
     }
  } 

  fun void  _rec  (){ 
     if ( ! disable  ){
       for (0 => int i; i < track_name.size()  ; i++) {
         <<<"Start rec" + track_name[i]>>>;

         strec[track_name[i]].connect(in[track_name[i]], rec_dur, track_name[i], 0 * data.tick /* sync_dur, 0 == sync on full dur */, 1 /* no sync */ );
       }
       rec_dur + 10::ms => now; 
     }
  } 

  
  fun void  rec (){ 
     if ( ! disable  ){
       spork ~   _rec (); 
    }
  } 

  fun ST @ rec_on_track (ST @ inpt, string n) {
     if ( ! disable  ){
       1 => int not_exist;
       for (0 => int i; i <  track_name.size() &&  not_exist    ; i++) {
         if (track_name[i] == n) 0 => not_exist;
       }
       if ( not_exist  ){
         <<<"!!! ERROR MULTIREC: " + n + " not created (add_track()) !!!">>>;
         new ST @=> ST @ st;
         return st;
       }
       else {
         new ST @=> ST @ st;
         probe << st;
         inpt.left() => st.outl;
         inpt.right() => st.outr;
         st.outl => in[n].outl;
         st.outr => in[n].outr;
         return st;
       }


    }
    else {
      // if disabled return input => passthrough
      return inpt;
    }
  }
}


"bewafa_mrec_" => string mrpath;
MULTIREC mrec;  4 * data.tick => mrec.rec_dur; // 1 => mrec.disable;
mrec.add_track(mrpath + "kick");
mrec.add_track(mrpath + "snr");

mrec.rec();
// PROBE to insert in ST paths
//mrec.rec_on_track( last, mrpath + "kick") @=> last;

SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); //
SET_WAV.ACOUSTIC(s); // SET_WAV.ACOUSTICTOM(s);// SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s); // SET_WAV.DUB(s); // SET_WAV.TRANCE(s); // SET_WAV.TRANCE_VARIOUS(s); //
//SET_WAV.TRANCE_KICK(s);// SET_WAV.TEK_VARIOUS(s);// SET_WAV.TEK_VARIOUS2(s);// SET_WAV2.__SAMPLES_KICKS(s); // SET_WAV2.__SAMPLES_KICKS_1(s); // SET_WAV.BLIPS(s);  // SET_WAV.TRIBAL(s);// "test.wav" => s.wav["a"];  // act @=> s.action["a"]; 
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"SSS" => s.seq;
.9 * data.master_gain => s.gain; // s.gain("s", .2); // for single wav 
//s.sync(4*data.tick);// s.element_sync(); //
s.no_sync(); //s.full_sync(); // 1 * data.tick => s.the_end.fixed_end_dur;  // 16 * data.tick => s.extra_end;   //s.print(); // => s.wav_o["a"].wav0.rate; // s.out("k") /* return ST */
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); s.add_subwav("K", s2.wav["s"]); // s.gain_subwav("K", 0, .3);
s.go();     s $ ST @=> ST @ last; 

mrec.rec_on_track( last, mrpath + "kick") @=> last;

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 

5 * data.tick => now;



