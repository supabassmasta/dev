public class SYNTWAV extends SYNT{
  1 => own_adsr;
  1 => stereo;

  float g; dur attack; dur release;  string file; dur update;  

  fun void  config  (float G, dur ATTACK, dur RELEASE,  string FILE , dur UPDATE){ 
    G => g;
    ATTACK => attack;
    RELEASE => release;
    FILE => file;
    UPDATE => update;
  } 

  fun void  config  (float G, dur ATTACK, dur RELEASE,  int i , dur UPDATE){ 
    string str[0];    
    str << "../_SAMPLES/SYNTWAVS/MULTI2SIN0";
    str << "../_SAMPLES/SYNTWAVS/MULTI2SIN1";
    str << "../_SAMPLES/SYNTWAVS/MULTI2SIN2";
    str << "../_SAMPLES/SYNTWAVS/MULTI2GROAN0";
    str << "../_SAMPLES/SYNTWAVS/MULTI2GROAN1";
    str << "../_SAMPLES/SYNTWAVS/MULTI2GENTLESPEECH0";
    str << "../_SAMPLES/SYNTWAVS/MULTI2GENTLESPEECH1";

    if ( i >= str.size() ){
      <<<"ERROR SYNTWAV : FILE number TOO HIGH">>>;
      0=> i; 
    }

    config  (G, ATTACK, RELEASE,  str[i], UPDATE);
} 

0 => int spork_cnt;

  fun void  KEY  ( int own_cnt){ 

    1::ms => now;
    inlet.last() => float freq;
    Std.ftom(freq) $ int => int note;

    //<<<"SYNTWAV f: ", freq, " note: ", note>>>;

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
    // Work around try to read a no existing file to close the previous one.
    // Avoid reason: System error : Too many open files.
    "dummmy_not_exist_file" => buf.read;
    1::samp => now;

  }

    inlet => blackhole;

    fun void on()  { }
    
    fun void off() {
      1 +=> spork_cnt;
    } 
    
    fun void new_note(int idx)  {
      1 +=> spork_cnt;
      spork ~   KEY (spork_cnt); 
     
    }
    
}

