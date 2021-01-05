15 => int mixer;

fun void  IBNIZ  (string s, int b, dur d, float g){ 

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


STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 

STFILTERX stbpfx0; BPF_XFACTORY stbpfx0_fact;
stbpfx0.connect(last $ ST ,  stbpfx0_fact, 8* 100.0 /* freq */ , 1.0 /* Q */ , 2 /* order */, 1 /* channels */ );       stbpfx0 $ ST @=>  last;  

STFILTERX stlpfx0; LPF_XFACTORY stlpfx0_fact;
stlpfx0.connect(last $ ST ,  stlpfx0_fact, 15* 100.0 /* freq */ , 2.0 /* Q */ , 1 /* order */, 1 /* channels */ );       stlpfx0 $ ST @=>  last;  



STLIMITER stlimiter;
8. => float in_gainl;
stlimiter.connect(last $ ST , in_gainl /* in gain */, 1./in_gainl /* out gain */, 0.0 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stlimiter $ ST @=>  last;   
2.6 => stlimiter.gain;

//STAUTOPAN autopan;
//autopan.connect(last $ ST, .9 /* span 0..1 */, data.tick * 3 / 4 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 
//
//STECHO ech;
//ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 


SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(4 * data.tick , 2 * data.tick /* offset */); 

WAIT w;
1::ms => w.fixed_end_dur;

while(1) {
spork ~   IBNIZ ("3/d2r4B&*", -1,  data.tick * 4 /2 , 0.7); 
  2 * data.tick => w.wait;


 spork ~   IBNIZ ("3*d2r4B&*", -1,  data.tick * 4 /2 , 0.5); 
   2 * data.tick => w.wait;
 spork ~   IBNIZ ("1*d2r4A&*", 2,  data.tick * 4 /2 , 0.07); 
   2 * data.tick => w.wait;
 spork ~   IBNIZ ("3*d2r4A&*", 0,  data.tick * 1 /2 , 0.5); 
   1 * data.tick => w.wait;
 spork ~   IBNIZ ("2*d2r4A&*", 0,  data.tick * 1 /2 , 0.5); 
   1 * data.tick => w.wait;
 
 spork ~   IBNIZ ("7*d1r3B&*", 0,  data.tick * 1 /3 , 0.2); 
   .25 * data.tick => w.wait;
 spork ~   IBNIZ ("7*d1r3B&*", 0,  data.tick * 1 /3 , 0.2); 
   .25 * data.tick => w.wait;
 spork ~   IBNIZ ("7*d1r3B&*", 0,  data.tick * 1 /3 , 0.2); 
   .25 * data.tick => w.wait;
 spork ~   IBNIZ ("9*d1r3B&*", 1,  data.tick * 1 /3 , 0.2); 
   .25 * data.tick => w.wait;
 
 spork ~   IBNIZ ("9*d1r3B&*", 1,  data.tick * 1 /3 , 0.2); 
   .25 * data.tick => w.wait;
 spork ~   IBNIZ ("9*d1r3B&*", 1,  data.tick * 1 /3 , 0.2); 
   .25 * data.tick => w.wait;
 spork ~   IBNIZ ("9*d1r3B&*", 1,  data.tick * 1 /3 , 0.2); 
   .25 * data.tick => w.wait;
 spork ~   IBNIZ ("9*d1r3B&*", 1,  data.tick * 1 /3 , 0.2); 
   .25 * data.tick => w.wait;
 
  spork ~   IBNIZ ("2*d2r4A&*", -1,  data.tick * 4 /2 , 0.5); 
    2 * data.tick => w.wait;
  spork ~   IBNIZ ("2*d2r4A&*", -1,  data.tick * 4 /2 , 0.5); 
    2 * data.tick => w.wait;
  spork ~   IBNIZ ("2*d2r4A&*", 0,  data.tick * 1 /2 , 0.5); 
    1 * data.tick => w.wait;
  spork ~   IBNIZ ("2*d2r4A&*", 0,  data.tick * 1 /2 , 0.5); 
    1 * data.tick => w.wait;
}
 
 
