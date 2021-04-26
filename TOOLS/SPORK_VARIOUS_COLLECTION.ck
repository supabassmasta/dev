
13 => int mixer;

////////////////////////////////////////////////////////////////////////////////////////////

// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 

SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
8 *data.tick => w.fixed_end_dur;
//4 * data.tick =>  w.wait; 



// VIRTUAL LAUNCHER
LAUNCHPAD_VIRTUAL.on.set(0);
LAUNCHPAD_VIRTUAL.off.set(0);

////////////////////////////////////////////////////////////////////////////////////////////

fun void  FROG  (float fstart, float fstop, float lpfstart, float lpfstop, dur d, float g){ 
    ST st; st $ ST @=> ST @ last;

    Step step => Envelope e0 => SqrOsc s => st.mono_in;
    1. => step.next;
    .2 => s.gain;

    fstart => e0.value;
    fstop => e0.target;
    d => e0.duration ;// => now;

    STFREEFILTERX stfreelpfx0; LPF_XFACTORY stfreelpfx0_fact;
    stfreelpfx0.connect(last $ ST , stfreelpfx0_fact, 3 /* Q */, 2 /* order */, 1 /* channels */ , 1::ms /* period */ ); stfreelpfx0 $ ST @=>  last; 

    g => stfreelpfx0.gain;

    Step step2 => Envelope e1 =>  stfreelpfx0.freq; // CONNECT THIS 
    lpfstart => e1.value;
    lpfstop => e1.target;
    d => e1.duration ;// => now;

    1. => step2.next;

    
    STHPF hpf;
    hpf.connect(last $ ST , 5 * 10 /* freq */  , 1.0 /* Q */  );       hpf $ ST @=>  last; 

    STMIX stmix;
    stmix.send(last, mixer);
    //stmix.receive(11); stmix $ ST @=> ST @ last; 
    d => now;

} 

//spork ~   FROG(19 /* fstart */, 4 /* fstop */, 9 * 100 /* lpfstart */, 24 * 100 /* lpfstop */, 1* data.tick /* dur */, .3 /* gain */);

////////////////////////////////////////////////////////////////////////////////////////////
fun void  SLIDE  (float fstart, float fstop, dur d, float width, float g){ 
  3::ms => dur attackRelease;

   
   ST st; st $ ST @=> ST @ last;

   STMIX stmix;
   stmix.send(last, mixer);
    //stmix.receive(11); stmix $ ST @=> ST @ last; 
    
   Step stp0 => Envelope e0 =>  TriOsc s => ADSR a => st.mono_in;
   fstart => e0.value;
   fstop => e0.target;
   d => e0.duration ;// => now;
   
   1.0 => stp0.next;
   
   g => s.gain;
   width => s.width;

   a.set(attackRelease, 0::ms, 1., attackRelease);

   a.keyOn();

   d => now;

   a.keyOff();
   attackRelease => now;
    
} 

//spork ~  SLIDE(200 /* fstart */, 1000 /* fstop */, 1* data.tick /* dur */, .5 /* width */, .03 /* gain */); 

/////////////////////////////////////////////////////////////////////////////////////////

fun void  SLIDENOISE  (float fstart, float fstop, dur d, float width, float g){ 
  3::ms => dur attackRelease;

   
   ST st; st $ ST @=> ST @ last;

   STMIX stmix;
   stmix.send(last, mixer);
    //stmix.receive(11); stmix $ ST @=> ST @ last; 
    
   Step stp0 => Envelope e0 =>  NOISE3 s => ADSR a => st.mono_in;
   fstart => e0.value;
   fstop => e0.target;
   d => e0.duration ;// => now;
   
   1.0 => stp0.next;
   
   g => s.gain;
//   width => s.width;

   a.set(attackRelease, 0::ms, 1., attackRelease);

   a.keyOn();

   d => now;

   a.keyOff();
   attackRelease => now;
    
} 


spork ~  SLIDENOISE(200 /* fstart */, 2000 /* fstop */, 8* data.tick /* dur */, .5 /* width */, .17 /* gain */); 


////////////////////////////////////////////////////////////////////////////////////////////

fun void  SLIDESERUM1  (float fstart, float fstop, dur d, float g){ 
  3::ms => dur attackRelease;

   
   ST st; st $ ST @=> ST @ last;

   STMIX stmix;
   stmix.send(last, mixer);
    //stmix.receive(11); stmix $ ST @=> ST @ last; 
    
   Step stp0 => Envelope e0 =>  SERUM1 s0 => st.mono_in;
   s0.add(0 /* synt nb */ , 0 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  2 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 
   s0.add(10 /* synt nb */ , 1 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  2 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 


   fstart => e0.value;
   fstop => e0.target;
   d => e0.duration ;// => now;
   
   1.0 => stp0.next;
   
   g => st.gain;

   s0.on();

   d => now;

   s0.off();
   attackRelease => now;
    
} 

//spork ~  SLIDESERUM1(2000 /* fstart */, 100 /* fstop */, 16* data.tick /* dur */,  .11 /* gain */); 

//////////////////////////////////////////////////////////////////////////////////////////////////

fun void MOD1 () {
  ST st;

  SinOsc tri0 =>  SinOsc sin0 =>  st.mono_in; st $ ST @=> ST last;
  10.0 => sin0.freq;
  0.01 => sin0.gain;

  6.0 => tri0.freq;
  34.0 *100=> tri0.gain;
//  0.5 => tri0.width;

  STMIX stmix;
  stmix.send(last, mixer);
  //stmix.receive(11); stmix $ ST @=> ST @ last; 

  1 * data.tick => now;

}

//spork ~   MOD1 (); 

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

//   spork ~   SINGLEWAVRATE("../_SAMPLES/HighMaintenance/JpenseQuifautPasAbuser.wav", .8,  .4); 


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

/////////////////////////////////////////////////////////////////////////////////


fun void  IBNIZ  (string s, dur d, float g){ 

  ST st; st @=> ST @ last;

  ibniz I => st.mono_in;
  g => I.gain;
  s => I.code;

  STMIX stmix;
  stmix.send(last, mixer);

  d => now;
} 


//spork ~   IBNIZ ("4*d4r1A&*", data.tick * 4 /2 , 0.08); // "4*d2r1A&*" "4*d3r1A&*"


/////////////////////////////////////////////////////////////////////////



fun void  IBNIZMOD  (string s, int b, dur d, float g){ 

  ST st; st @=> ST @ last;

  ibniz I => SinOsc sin0 => Gain out;

  117 => I.gain;

  10.0 => sin0.freq;
  0.3 => sin0.gain;

  SinOsc sin1 =>  OFFSET ofs0 => sin0;
  Std.mtof(data.ref_note + b * 12) => ofs0.offset;
  1. => ofs0.gain;

  .3 => sin1.freq;
  .0 => sin1.gain;

  
  
  out => st.mono_in;
  g => out.gain;
  s => I.code;

  STMIX stmix;
  stmix.send(last, mixer);

  I.reset();

  d => now;
} 


//spork ~   IBNIZ ("3/d2r4B&*", -1 /* octave offset */,  data.tick * 4 /2 /* dur */ , 0.7 /* gain */); 


///////////////////////////////////////////////////////////////////////////////

fun void  KEY  (int note, float g, dur d, dur attack, dur release,  string file){ 
	SndBuf2 buf;

  file + note + ".wav" => buf.read;
  g => buf.gain;

  ST out; out @=> ST @ last;

	buf.chan(0) => ADSR al => out.outl;
	buf.chan(1)=> ADSR ar => out.outr;

  al.set(attack, 0::ms, 1. , release);
  ar.set(attack, 0::ms, 1. , release);

  STMIX stmix;
  stmix.send(last, mixer);

  al.keyOn();
  ar.keyOn();

  d - release => now;

  al.keyOff();
  ar.keyOff();

  release => now;

  out.disconnect();
  // Work around: try to read a no existing file to close the previous one.
  // Avoid Error: reason: System error : Too many open files.
  "dummmy_not_exist_file" => buf.read;
}

//"../_SAMPLES/SYNTWAVS/MULTI2SIN0" => string f1;
//spork ~  KEY(60     /* note */, .2 /* g */, 12 * data.tick /* d */, 4::second /* attack */, 4::second/*  release */,  f1 /* file */);









