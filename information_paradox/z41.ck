13 => int mixer;

////////////////////////////////////////////////////////////////////////////////////////////

fun void  SINGLEWAV  (string file, float g){ 
   ST st; st $ ST @=> ST @ last;
   SndBuf s => st.mono_in;

//   STMIX stmix;
//   stmix.send(last, mixer);
   
   g => s.gain;

   file => s.read;

   s.length() => now;
} 

//   spork ~   SINGLEWAV("../_SAMPLES/", .4); 

////////////////////////////////////////////////////////////////////////////////////////////

fun void  SINGLEWAVRATE  (string file, float r, float g){ 
   ST st; st $ ST @=> ST @ last;
   SndBuf s => st.mono_in;

//   STMIX stmix;
//   stmix.send(last, mixer);
   r => s.rate;
   g => s.gain;

   file => s.read;

   s.length() * (1./r) => now;
} 



////////////////////////////////////////////////////////////////////////////////////////////

fun void  SINGLEWAVRATEECHO  (string file, float r, float g){ 
   ST st; st $ ST @=> ST @ last;
   SndBuf s => st.mono_in;

   STECHO ech;
   ech.connect(last $ ST , data.tick * 4 / 4 , .8);  ech $ ST @=>  last; 
//   STMIX stmix;
//   stmix.send(last, mixer);

   r => s.rate;
   g => s.gain;

   file => s.read;

   12 * data.tick => now;
}

//spork ~   SINGLEWAVRATEECHO("../_SAMPLES/", 1.8, .6); 


////////////////////////////////////////////////////////////////////////////////////////////

// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 

SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
8 *data.tick => w.fixed_end_dur;


while(1) {

  spork ~   SINGLEWAVRATE("../_SAMPLES/Hawking/smallamount.wav", 1., 0.8); 
  8 * data.tick =>  w.wait; 
  spork ~   SINGLEWAVRATE("../_SAMPLES/Hawking/everyhtingislost.wav", 1., 0.8); 
  8 * data.tick =>  w.wait; 
  spork ~   SINGLEWAVRATE("../_SAMPLES/Hawking/cantreconstructthepast.wav", 1., 0.8); 
  8 * data.tick =>  w.wait; 
  spork ~   SINGLEWAVRATE("../_SAMPLES/Hawking/cantreconstructthefuture.wav", 1., 0.8); 
  8 * data.tick =>  w.wait; 
  spork ~   SINGLEWAVRATE("../_SAMPLES/Hawking/information_paradox.wav", 1., 1.2); 
  8 * data.tick =>  w.wait; 
  spork ~   SINGLEWAVRATE("../_SAMPLES/Hawking/information_paradox.wav", 1., 1.2); 
  8 * data.tick =>  w.wait; 
  spork ~   SINGLEWAVRATEECHO("../_SAMPLES/Hawking/information_paradox.wav", 1., 1.2); 
  8 * data.tick =>  w.wait; 
  8 * data.tick =>  w.wait; 


}


