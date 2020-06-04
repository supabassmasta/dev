LONG_WAV l;
"../_SAMPLES/oneplanet/trance_synts_and_bells.wav" => l.read;
1.0 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 100::ms);
l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 32 * data.tick /* loop (0::ms == disable) */ , 4 * data.tick /* END sync */); l $ ST @=> ST @ last;  

SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 

while(1) {
   if ( HW.ledstrip.opened ){
       HW.ledstrip.cereal.writeByte('o');
   }
       16 * data.tick => now;
}
 
