
class wav {
  SndBuf wav0;

  class play_wav extends ACTION {
    SndBuf @ buf;
    fun int on_time() {
      0 => buf.pos;

      return 0;
    }
  }

  play_wav play;
  wav0 @=> play.buf;

  fun void read(string in) {
    in => wav0.read;
  }

  wav0 => dac;
  0.3 => wav0.gain;
  wav0.samples() => wav0.pos;

}


SEQ3 s;

ELEMENT @ e;
wav @ w0;

wav w1;
"../_SAMPLES/FreeDrumKits.net - 9th Wonder Kit/Hi-Hats/Str_H1.wav" => w1.read;

new wav @=> w0;
"../_SAMPLES/FreeDrumKits.net - 9th Wonder Kit/Snares/Wsc_Snr2.wav" => w0.read;

new ELEMENT @=> e;
e.actions << w0.play $ ACTION ;
e.actions << w1.play $ ACTION ;
300::ms => e.duration;

s.elements << e;

new wav @=> w0;
"../_SAMPLES/FreeDrumKits.net - 9th Wonder Kit/Kicks/Wal_K.wav" => w0.read;

new ELEMENT @=> e;
e.actions << w0.play $ ACTION ;
e.actions << w1.play $ ACTION ;
300::ms => e.duration;

s.elements << e;


s.go();

while(1) {
       100::ms => now;
}
 
