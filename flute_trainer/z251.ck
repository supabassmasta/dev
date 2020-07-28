STRECCONV strecconv;
10 * 1000 => strecconv.inputl.gain => strecconv.inputr.gain; // input signal into reverb only
.2 => strecconv.dry;
0::ms => strecconv.predelay;

//"../_SAMPLES/ConvolutionImpulseResponse/in_the_silo_revised.wav" => strecconv.ir.read; 
//"../_SAMPLES/ConvolutionImpulseResponse/on_a_star_jsn_fade_out.wav" => strecconv.ir.read;
//"../_SAMPLES/ConvolutionImpulseResponse/chateau_de_logne_outside.wav" => strecconv.ir.read;
"../_SAMPLES/ConvolutionImpulseResponse/st_nicolaes_church.wav" => strecconv.ir.read;
strecconv.loadir();

/////   /!\ make seq start after loading IR /!\   ///////////////////

LONG_WAV l;
"/home/toup/EC/Bansuri/LIVE FOR BIRDS (prairie St Martin)/Mix3_no_blank_raw.wav" => l.read;
1.0 * data.master_gain => l.buf.gain;
0 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);
l.start(1 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  


////////////////////////////////////////////////////////////////

strecconv.connect(last $ ST /* ST */);
strecconv.process();
strecconv.rec(34::minute /* length */, "/home/toup/EC/Bansuri/LIVE FOR BIRDS (prairie St Martin)/Mix3_no_blank_Reverb.wav" /* file name */ ); 

while(1) {
       100::ms => now;
}
 
