class SYNTWAV extends SYNT{
  ST stout;
  float g; dur attack; dur release;  string file; dur update;  

  fun void  config  (float G, dur ATTACK, dur RELEASE,  string FILE , dur UPDATE){ 
    G => g;
    ATTACK => attack;
    RELEASE => release;
    FILE => file;
    UPDATE => update;
  } 

  0 => int spork_cnt;

  fun void  KEY  ( int own_cnt){ 

    1::ms => now;
    inlet.last() => float freq;
    Std.ftom(freq) $ int => int note;

    <<<"SYNTWAV f: ", freq, " note: ", note>>>;

    SndBuf2 buf;

    file + note + ".wav" => buf.read;
    g => buf.gain;

    buf.chan(0) => ADSR al => stout.outl;
    buf.chan(1)=> ADSR ar => stout.outr;

    al.set(attack, 0::ms, 1. , release);
    ar.set(attack, 0::ms, 1. , release);


    al.keyOn();
    ar.keyOn();

    while(own_cnt == spork_cnt) {
      update => now;
    }

    al.keyOff();
    ar.keyOff();

    release => now;

    al =< stout.outl;
    ar =< stout.outr;  

    1::samp => now;

  }

    inlet => blackhole;

    // TEMP TODO TONE Stereo out
    stout.left() => outlet;

    fun void on()  { }
    
    fun void off() {
      1 +=> spork_cnt;
    } 
    
    fun void new_note(int idx)  {
      1 +=> spork_cnt;
      spork ~   KEY (spork_cnt); 
     
    }
    
    1 => own_adsr;
}


TONE t;
t.reg(SYNTWAV s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(.5 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, "../_SAMPLES/ambient_universe/SYNTTEST" /* FILE */, 100::ms /* UPDATE */);
t.reg(SYNTWAV s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s1.config(.4 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, "../_SAMPLES/ambient_universe/SYNTTEST" /* FILE */, 100::ms /* UPDATE */);
t.reg(SYNTWAV s2);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s2.config(.3 /* G */, 1::second /* ATTACK */, 1::second /* RELEASE */, "../_SAMPLES/ambient_universe/SYNTTEST" /* FILE */, 100::ms /* UPDATE */);



t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c :2 !1|5|7_5|2_8|5" => t.seq;
.6 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); //
8 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//STGVERB stgverb;
//stgverb.connect(last $ ST, .05 /* mix */, 7 * 10. /* room size */, 4::second /* rev time */, 0.2 /* early */ , 0.8 /* tail */ ); stgverb $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
