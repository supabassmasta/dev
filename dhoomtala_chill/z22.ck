LOOP_WAV l;
"../_SAMPLES/dhoomtala_chill/glitch.wav" => l.read;
1.7 * data.master_gain => l.buf.gain;
l.AttackRelease(1::ms, 100::ms);
l.start(1 * data.tick /* sync */ ,   1 * data.tick /* END sync */); l $ ST @=> ST @ last;   

STHPF hpf;
hpf.connect(last $ ST , 20 * 10 /* freq */  , 1.0 /* Q */  );       hpf $ ST @=>  last; 


while(1) {
       100::ms => now;
}


