.5::second=> now;
FREQ f;
f.freq => SinOsc s=> f.adsr => Gain g => dac;
1=> f.sync_on;
.1 => g.gain;

f.rel_note << 0 << 12;
 f.slide  << 0  << 1 ;
 f.rel_dur << 0.01 << .49;
//f.note << 60 << 60 << 64<< 70;
//f.g    << 1. << 1. << 0. ;
50 => f.base_note;
"BI_YU" => f.scale;
190 => f.bpm;
f.go();



while(1) {
f.tick() * 6 => now;
g=< dac;
f.tick() * 2 => now;
g=> dac;

53 => f.base_note;

f.tick() * 6 => now;
g=< dac;
f.tick() * 2 => now;
g=> dac;

50 => f.base_note;

 }