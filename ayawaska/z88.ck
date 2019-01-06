
LONG_WAV l;
"../_SAMPLES/Chassin/Icario chant G D C test2.wav" => l.read;
1. => l.buf.gain;
1 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 4 * data.tick /* END sync */); 

["BIRDS", "Chants Alone", "Dub Start", "Melodica", "Slow Dub", "SYNT SOLO", "SOLO END", "Melo 2", "Chorus", "END"] @=> string next_s[];
[4,       6,              8,           16,         26,          39,          43,         59,      63,        77   ] @=> int next[];
fun void f1 (){ 
  SYNC sy;
  0 => int m;
  0 => int n;
  16 => int t;
  sy.sync(4 * data.tick);
  //sy.sync(4 * data.tick , 0::ms /* offset */); 
  while(1) {
    <<<"_____________", "_">>>;
    <<<t, " Meas: ", m, "    Next: ", next[n], "  ", next_s[n]>>>;
    <<<"-------------", "-">>>;

    t - 1 => t;
    if ( t == 0  ){
      16 => t;
      m + 1 => m;
      
      if (m >= next[n] && n < (next.size() - 1) ){
        n + 1 => n;
      }
    }
    1 * data.tick => now;
  }


} 
spork ~ f1 ();
    


while(1) {
	     100::ms => now;
}
 
