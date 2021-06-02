public class SYNTWAV extends SYNT{
  1 => own_adsr;
  1 => stereo;

  // TO allow hack
  0 => int pos;
  1.0 => float rate;
  SndBuf2 @ lastbuf;

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
/* 0 */    str << "../_SAMPLES/SYNTWAVS/MULTI2SIN0";
/* 1 */    str << "../_SAMPLES/SYNTWAVS/MULTI2SIN1";
/* 2 */    str << "../_SAMPLES/SYNTWAVS/MULTI2SIN2";
/* 3 */    str << "../_SAMPLES/SYNTWAVS/MULTI2GROAN0";
/* 4 */    str << "../_SAMPLES/SYNTWAVS/MULTI2GROAN1";
/* 5 */    str << "../_SAMPLES/SYNTWAVS/MULTI2GENTLESPEECH0";
/* 6 */    str << "../_SAMPLES/SYNTWAVS/MULTI2GENTLESPEECH1";
/* 7 */    str << "../_SAMPLES/SYNTWAVS/MELLOTRON_Cello_";
/* 8 */    str << "../_SAMPLES/SYNTWAVS/MELLOTRON_CombinedChoir_";
/* 9 */    str << "../_SAMPLES/SYNTWAVS/MELLOTRON_GC3Brass_";
/* 10 */    str << "../_SAMPLES/SYNTWAVS/MELLOTRON_M300B_";
/* 11 */    str << "../_SAMPLES/SYNTWAVS/MELLOTRON_MkIIBrass_";
/* 12 */    str << "../_SAMPLES/SYNTWAVS/MELLOTRON_MkIIFlute_";
/* 13 */    str << "../_SAMPLES/SYNTWAVS/MELLOTRON_MkIIViolins_";
/* 14 */    str << "../_SAMPLES/SYNTWAVS/MELLOTRON_StringSection_";
/* 15 */    str << "../_SAMPLES/SYNTWAVS/MELLOTRON_Woodwind2_";
/* 16 */    str<<"../_SAMPLES/SYNTWAVS/Agitato";
/* 17 */    str<<"../_SAMPLES/SYNTWAVS/Breathchoir";
/* 18 */    str<<"../_SAMPLES/SYNTWAVS/FlangOrg";
/* 19 */    str<<"../_SAMPLES/SYNTWAVS/Stalactite";
/* 20 */    str<<"../_SAMPLES/SYNTWAVS/AnalogStr";
/* 21 */    str<<"../_SAMPLES/SYNTWAVS/BriteString";
/* 22 */    str<<"../_SAMPLES/SYNTWAVS/FreezePad";
/* 23 */    str<<"../_SAMPLES/SYNTWAVS/Neptune";
/* 24 */    str<<"../_SAMPLES/SYNTWAVS/AnaOrch";
/* 25 */    str<<"../_SAMPLES/SYNTWAVS/ClearBell";
/* 26 */    str<<"../_SAMPLES/SYNTWAVS/GlassChoir";
/* 27 */    str<<"../_SAMPLES/SYNTWAVS/No.9String";
/* 28 */    str<<"../_SAMPLES/SYNTWAVS/Telesa";
/* 29 */    str<<"../_SAMPLES/SYNTWAVS/AnLayer";
/* 30 */    str<<"../_SAMPLES/SYNTWAVS/CloudNine";
/* 31 */    str<<"../_SAMPLES/SYNTWAVS/GlassMan";
/* 32 */    str<<"../_SAMPLES/SYNTWAVS/Phasensemble";
/* 33 */    str<<"../_SAMPLES/SYNTWAVS/VelocityEns";
/* 34 */    str<<"../_SAMPLES/SYNTWAVS/Apollo";
/* 35 */    str<<"../_SAMPLES/SYNTWAVS/ComeOnHigh";
/* 36 */    str<<"../_SAMPLES/SYNTWAVS/HollowPad";
/* 37 */    str<<"../_SAMPLES/SYNTWAVS/PulseString";
/* 38 */    str<<"../_SAMPLES/SYNTWAVS/BigStrings+";
/* 39 */    str<<"../_SAMPLES/SYNTWAVS/Dreamsphere";
/* 40 */    str<<"../_SAMPLES/SYNTWAVS/Kemuri";
/* 41 */    str<<"../_SAMPLES/SYNTWAVS/SkyOrgan";
/* 42 */    str<<"../_SAMPLES/SYNTWAVS/BigWave";
/* 43 */    str<<"../_SAMPLES/SYNTWAVS/DynaPWM";
/* 44 */    str<<"../_SAMPLES/SYNTWAVS/SmokePad";
/* 45 */    str<<"../_SAMPLES/SYNTWAVS/BottledOut";
/* 46 */    str<<"../_SAMPLES/SYNTWAVS/EnsembleMix";
/* 47 */    str<<"../_SAMPLES/SYNTWAVS/Mars";
/* 48 */    str<<"../_SAMPLES/SYNTWAVS/SoftString";
/* 49 */    str<<"../_SAMPLES/SYNTWAVS/StereoString";
/* 50 */    str<<"../_SAMPLES/SYNTWAVS/MellowStrings";

    if ( i >= str.size() ){
      <<<"ERROR SYNTWAV : FILE number TOO HIGH">>>;
      0=> i; 
    }

    <<<"LOADING ", str [i] >>>;

    config  (G, ATTACK, RELEASE,  str[i], UPDATE);
} 

0 => int spork_cnt;

  fun void  KEY  ( int own_cnt){ 

    1::ms => now;
    inlet.last() => float freq;
    Math.round(Std.ftom(freq)) $ int  => int note;

    <<<"SYNTWAV f: ", freq, " note: ", note>>>;

    SndBuf2 buf;
    buf @=> lastbuf;
    file + note + ".wav" => buf.read;
    g => buf.gain;

    buf.chan(0) => ADSR al => stout.outl;
    buf.chan(1)=> ADSR ar => stout.outr;

    al.set(attack, 0::ms, 1. , release);
    ar.set(attack, 0::ms, 1. , release);

    pos => buf.pos;
    rate => buf.rate;

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

