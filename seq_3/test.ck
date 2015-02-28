SndBuf wav0 => dac;
0.3 => wav0.gain;
"../_SAMPLES/FreeDrumKits.net - 9th Wonder Kit/Snares/Wsc_Snr2.wav" => wav0.read;
wav0.samples() => wav0.pos;

class play_wav extends ACTION {
  fun int on_time() {
    <<<"play">>>; 
    0 => wav0.pos;


    return 0;
  }
}

play_wav p;

SEQ3 s;

ELEMENT @ e;

new ELEMENT @=> e;
e.actions << p $ ACTION ;
300::ms => e.duration;

s.elements << e;

s.go();

while(1) {
       100::ms => now;
}
 
