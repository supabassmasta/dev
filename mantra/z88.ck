LONG_WAV l;
//"../_SAMPLES/Chassin/Mantra tibétain-takeyourtime_NORMALIZED_RESYNC.wav" => l.read;
"../_SAMPLES/Chassin/Mantra II MEL chaton.wav" => l.read;

0.8 => l.buf.gain;
1 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

[ "tabla bass", "synt","BEAT START", "BASS START", "STOP for BRIDGE", "DUB KICK START", "reaggae bass"] @=> string next_s[];
[4,       6,              8,           12,         32,          34 , 54  ] @=> int next[];
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
 
