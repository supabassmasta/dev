LONG_WAV l;
"../_SAMPLES/Chassin/Ederlezi Do dorien full_NORMALIZED.wav" => l.read;
1.0 => l.buf.gain;
1 => l.update_ref_time;
l.AttackRelease(0::ms, 0::ms);

// FULL
//l.start(3 * data.tick /* sync */ ,0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  


// KICK START
//l.start(4 * data.tick /* sync */ ,80 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

// PONT
l.start(4 * data.tick /* sync */ ,112 * data.tick  /* offset */ , 16 * data.tick /* loop (1::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

// BASS START REFRAIN
//l.start(4 * data.tick /* sync */ ,128 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

// STEPPA
//l.start(4 * data.tick /* sync */ , (128 + 64) * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

// REFRAIN
//l.start(4 * data.tick /* sync */ , (128 + 64 + 32) * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=> ST @ last;  

//l.start(4 * data.tick /* sync */ , (128 + 32 + 16 ) * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 4 * data.tick /* END sync */); l $ ST @=> ST @ last;  
data.tick/8 => dur att;

digit di;
l.mono() => PowerADSR padsr;
di.connect(padsr)=> dac;
padsr.set(3::ms, 20::ms, 1. , 3::ms);
padsr.setCurves(3., 1., .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave 

padsr.keyOn();

SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 




	     1*data.tick => now;

			 padsr.keyOff(); att => now; padsr.keyOn(); att => now; 
			 padsr.keyOff(); att => now; padsr.keyOn(); att => now; 
			 padsr.keyOff(); att => now; padsr.keyOn(); att => now; 
			 padsr.keyOff(); att => now; padsr.keyOn(); att => now; 

	     data.tick * 1  / 2. => now;
			 padsr.keyOff(); att => now; padsr.keyOn(); att => now; 
			 padsr.keyOff(); att => now; padsr.keyOn(); att => now; 

	     data.tick * 1.  / 4. => now;
			 padsr.keyOff(); att => now; padsr.keyOn(); att => now; 
			 padsr.keyOff(); att => now; padsr.keyOn(); att => now; 
	     data.tick * 1.  / 4. => now;

///--------------------------------------

	     data.tick * 1  / 2. => now;
			 padsr.keyOff(); att => now; padsr.keyOn(); att => now; 
			 padsr.keyOff(); att => now; padsr.keyOn(); att => now; 

	     data.tick * 1.  / 4. => now;
			 padsr.keyOff(); att => now; padsr.keyOn(); att => now; 
			 padsr.keyOff(); att => now; padsr.keyOn(); att => now; 
	     data.tick * 1.  / 4. => now;

			 padsr.keyOff(); att => now; padsr.keyOn(); att => now; 
			 padsr.keyOff(); att => now; padsr.keyOn(); att => now; 
			 padsr.keyOff(); att => now; padsr.keyOn(); att => now; 
			 padsr.keyOff(); att => now; padsr.keyOn(); att => now; 

	     data.tick * 1.  / 4. => now;
			 padsr.keyOff(); att => now; padsr.keyOn(); att => now; 
			 padsr.keyOff(); att => now; padsr.keyOn(); att => now; 
	     data.tick * 1.  / 4. => now;


///--------------------------------------
	     2*data.tick => now;

//			 padsr.keyOff(); att => now; padsr.keyOn(); att => now; 
//			 padsr.keyOff(); att => now; padsr.keyOn(); att => now; 
//			 padsr.keyOff(); att => now; padsr.keyOn(); att => now; 
//			 padsr.keyOff(); att => now; padsr.keyOn(); att => now; 

	     data.tick * 1  / 2. => now;
			 padsr.keyOff(); att => now; padsr.keyOn(); att => now; 
			 padsr.keyOff(); att => now; padsr.keyOn(); att => now; 

	     data.tick * 1.  / 4. => now;
			 padsr.keyOff(); att => now; padsr.keyOn(); att => now; 
			 padsr.keyOff(); att => now; padsr.keyOn(); att => now; 
	     data.tick * 1.  / 4. => now;

///--------------------------------------
				1.3 => padsr.gain;

			 2::samp=>di.ech;
	     1*data.tick/2. => now;
			 4::samp=>di.ech;
	     1*data.tick/2. => now;

			 8::samp=>di.ech;
	     1*data.tick/2. => now;
			 16::samp=>di.ech;
	     1*data.tick/2.=> now;

			 32::samp=>di.ech;
	     1*data.tick/4. => now;
			 64::samp=>di.ech;
	     1*data.tick/4. => now;
			 128::samp=>di.ech;
	     1*data.tick/4.=> now;
			 256::samp=>di.ech;
	     1*data.tick/4. => now;

	     1*data.tick => now;

			 /*
	     data.tick * 1./4. => now;
			 4::samp=>di.ech;
	     1*data.tick/4. => now;
			 1::samp=>di.ech;
	     data.tick * 1./4. => now;
	     data.tick * 1./4. => now;

			 8::samp=>di.ech;
	     1*data.tick/4. => now;
			 1::samp=>di.ech;
			 padsr.keyOff(); att => now; padsr.keyOn(); att => now; 
			 padsr.keyOff(); att => now; padsr.keyOn(); att => now; 
	     data.tick * 1.  / 4. => now;

				1.3 => padsr.gain;

			 2::samp=>di.ech;
	     1*data.tick/4. => now;
			 4::samp=>di.ech;
	     1*data.tick/4. => now;
			 8::samp=>di.ech;
	     1*data.tick/4. => now;
			 16::samp=>di.ech;
	     1*data.tick/4.=> now;

			 32::samp=>di.ech;
	     1*data.tick/4. => now;
			 64::samp=>di.ech;
	     1*data.tick/4. => now;
			 128::samp=>di.ech;
	     1*data.tick/4.=> now;
			 256::samp=>di.ech;
	     1*data.tick/4. => now;

			 	*/
