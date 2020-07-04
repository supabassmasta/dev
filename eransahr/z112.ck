
//////////////////////////////////////////////////////////////////////////////////////////////////

class POLYSEQ {

  SEQ @ s[0];
  string  sseq[0];
  STGAIN stout;

  fun void size(int si) {
    for (0 => int i; i < si      ; i++) {
      s << new SEQ;
      sseq << new string;
    }
  }

  fun void max(dur in){
    for (0 => int i; i <    s.size()   ; i++) {
      in => s[i].max;
    }
  }

  fun void extra_end(dur in){
    for (0 => int i; i <    s.size()   ; i++) {
      in => s[i].extra_end;
    }
  }

  /////////////////////
  fun void sync(dur in){
    for (0 => int i; i <    s.size()   ; i++) {
      in => s[i].sync;
    }
  }
  
  fun void element_sync(){
    for (0 => int i; i <    s.size()   ; i++) {
      s[i].element_sync();
    }
  }

  fun void no_sync(){
    for (0 => int i; i <    s.size()   ; i++) {
      s[i].no_sync();
    }
  }

  fun void full_sync(){
    for (0 => int i; i <    s.size()   ; i++) {
      s[i].full_sync();
    }
  }
  /////////////////////
  float gain_common;

  fun void stout_connect() {
    for (0 => int i; i <    s.size()   ; i++) {
      stout.connect(s[i] $ ST , gain_common /* static gain */  );      
    }
  }

  fun void go(){
    for (1 => int i; i <    s.size()   ; i++) {
      s[0].the_end.fixed_end_dur => s[i].the_end.fixed_end_dur; 
    }

    for (0 => int i; i <    s.size()   ; i++) {
      sseq[i] => s[i].seq;
    }
    for (0 => int i; i <    s.size()   ; i++) {
      s[i].go();
    }
  }

}

POLYSEQ ps;

3 => ps.size;

//data.tick * 8 => ps.max;
// SET_WAV.DUBSTEP(ps.s[0]);// SET_WAV.VOLCA(ps.s[0]); // SET_WAV.ACOUSTIC(ps.s[0]); // SET_WAV.TABLA(ps.s[0]);// SET_WAV.CYMBALS(ps.s[0]); // SET_WAV.DUB(ps.s[0]); // SET_WAV.TRANCE(ps.s[0]); // SET_WAV.TRANCE_VARIOUS(ps.s[0]);// SET_WAV.TEK_VARIOUS(ps.s[0]);// SET_WAV.TEK_VARIOUS2(ps.s[0]);// SET_WAV2.__SAMPLES_KICKS(ps.s[0]); // SET_WAV2.__SAMPLES_KICKS_1(ps.s[0]); // SET_WAV.BLIPS(ps.s[0]);  // SET_WAV.TRIBAL(ps.s[0]);// "test.wav" => ps.s[0].wav["a"];  // act @=> ps.s[0].action["a"];
SET_WAV.TRANCE(ps.s[0]);
SET_WAV.ACOUSTIC(ps.s[1]);
SET_WAV.TRIBAL(ps.s[2]);

//ps.sync(4*data.tick);// ps.element_sync(); //ps.no_sync(); //ps.full_sync(); // 1 * data.tick => ps.s[0].the_end.fixed_end_dur;  // 16 * data.tick => ps.extra_end;   //ps.s[0].print();

// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"*4 " +=> ps.sseq[0];
"*4 " +=> ps.sseq[1];
"*4 " +=> ps.sseq[2];

"kk__ S___" +=> ps.sseq[0];
"__i_" +=> ps.sseq[1];
"____ ___G" +=> ps.sseq[2];

ps.go();

//// SUBWAV //// SEQ s2; SET_WAV.ACOUSTIC(s2); ps.s[0].add_subwav("K", s2.wav["s"]); // ps.s[0].gain_subwav("K", 0, .3);

.3 * data.master_gain =>  ps.gain_common;
.4 * data.master_gain => ps.s[0].gain; // For individual gain
.4 * data.master_gain => ps.s[1].gain; // For individual gain
.4 * data.master_gain => ps.s[2].gain; // For individual gain

// CONNECTIONS
//ps.stout_connect(); ps.stout $ ST  @=> ST @ last; // comment to connect each SEQ separately
 ps.s[2] $ ST @=> ST @ last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 1 / 4 , .6);  ech $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
