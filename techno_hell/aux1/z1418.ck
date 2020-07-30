ST st;
SndBuf s =>   ADSR adsr => st.mono_in; st @=> ST @ last;
adsr.set(3::ms, 0::ms, 1., 3::ms);

"../../_SAMPLES/Aborigines/abo0.wav" => s.read;
s.samples() => s.pos;

STGAIN stgain;
stgain.connect(last $ ST , 0.4 /* static gain */  );       stgain $ ST @=>  last; 

STADSRC stadsrc;
stadsrc.connect(last, HW.launchpad.keys[16*0 + 6] /* pad 1:1 */ /* controler */, 2::ms /* attack */, 2::ms /* release */, 1 /* default_on */, 1  /* toggle */); stadsrc $ ST @=> last; 

//STDIGITC dig;
//dig.connect(last $ ST , HW.lpd8.potar[1][1] /* sub sample period */ , HW.lpd8.potar[1][2] /* quantization */);      dig $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .4 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .3);  ech $ ST @=>  last; 


    


fun void play(dur p, dur l, float r, dur atk, dur rel) {
  adsr.set(atk, 0::ms, 1., rel);
  adsr.keyOn();

  (p/(1::samp)) $ int => s.pos;

  l - rel => now;

  adsr.keyOff();
  rel => now;

  s.samples() => s.pos;
}

SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 

data.tick  => dur d;
while(1) {
  now => time t;

   play( 3*d, d/4, 1. , 2::ms, 2::ms); // Hee
   d/4 => now;
   play( 3*d, d/4, 1. , 2::ms, 2::ms);
   d/2 => now;
   play( 4*d, d/4, 1. , 2::ms, 2::ms); /// Hi
   d/4 => now;
   play( 7*d, d/8, 1. , 2::ms, 2::ms); /// Urrrr
   play( 7*d, d/8, 1. , 2::ms, 2::ms); /// 
   play( 7*d, d/8, 1. , 2::ms, 2::ms); /// 
   play( 7*d, d/8, 1. , 2::ms, 2::ms); /// 
   d/2 => now;
   play( 4*d, d/4, 1. , 2::ms, 2::ms); /// Hi
   d/4 => now;
   play( 6.5*d, d/4, 1. , 2::ms, 2::ms); /// Tu
   d/8 => now;
   play( 7.5*d, d/4, 1. , 2::ms, 2::ms); 
   d/8 => now;
   play( 6.5*d, d/4, 1. , 2::ms, 2::ms);
   d/8 => now;
   play( 4*d, d/8, 1. , 2::ms, 2::ms); /// Hi
   play( 4*d, d/8, 1. , 2::ms, 2::ms); /// Hi
   play( 4*d, d/8, 1. , 2::ms, 2::ms); /// Hi
   play( 4*d, d/8, 1. , 2::ms, 2::ms); /// Hi
   d/4 => now;
   play( 3*d, d/4, 1. , 2::ms, 2::ms); // Hee
   d/4 => now;
   play( 6.5*d, d/4, 1. , 2::ms, 2::ms); /// Tu
   d/8 => now;
 
   play( 4*d, d/4, 1. , 2::ms, 2::ms); /// Hi
   d/2 => now;
 
   play( 4*d, d/4, 1. , 2::ms, 2::ms); /// Hi
   d/2 => now;
 
   play( 6*d, d/4, 1. , 2::ms, 2::ms); /// Hi
   d/2 => now;
 
   play( 6.5*d, d/4, 1. , 2::ms, 2::ms); /// Tu
   play( 6.5*d, d/4, 1. , 2::ms, 2::ms); /// Tu
   play( 6.5*d, d/4, 1. , 2::ms, 2::ms); /// Tu
   d/2 => now;

  play( 8.0*d, d/4, 1. , 2::ms, 2::ms); /// 
  d/8 => now;
  play( 8.0*d, d/4, 1. , 2::ms, 2::ms); /// 
  d/8 => now;
  play( 8.0*d, d/4, 1. , 2::ms, 2::ms); /// 
  d/4 => now;
  play( 6.5*d, d/4, 1. , 2::ms, 2::ms); /// Tu

  play( 6.5*d, d/4, 1. , 2::ms, 2::ms); /// 
  d/4 => now;
  play( 8.0*d, d/4, 1. , 2::ms, 2::ms); /// 
  play( 8.0*d, d/4, 1. , 2::ms, 2::ms); /// 
  play( 6.5*d, d/4, 1. , 2::ms, 2::ms); /// 
  play( 8.0*d, d/4, 1. , 2::ms, 2::ms); /// 

  d/4 => now;
  play( 3*d, d/4, 1. , 2::ms, 2::ms); // Hee
  d/4 => now;
  play( 3*d, d/4, 1. , 2::ms, 2::ms); // Hee
   d/2 => now;

   play( 4*d, d/8, 1. , 2::ms, 2::ms); /// Hi
   play( 4*d, d/8, 1. , 2::ms, 2::ms); /// Hi
   play( 4*d, d/8, 1. , 2::ms, 2::ms); /// Hi
   play( 4*d, d/8, 1. , 2::ms, 2::ms); /// Hi
   d/2 => now;

   play( 6.5*d, d/8, 1. , 2::ms, 2::ms); 
   play( 6.5*d, d/8, 1. , 2::ms, 2::ms); 
   d/4 => now;
   play( 6.5*d, d/8, 1. , 2::ms, 2::ms); 
   play( 6.5*d, d/8, 1. , 2::ms, 2::ms); 
   d/4 => now;


  <<<"DURATION :", (now -t)/data.tick>>>;

}
 
