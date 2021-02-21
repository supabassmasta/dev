13 => int mixer;



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
}



// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 

SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

STROTATE strot;
strot.connect(last $ ST , 0.6 /* freq */  , 0.8 /* depth */, 1.0 /* width */, 1::samp /* update rate */ ); strot$ ST @=>  last; 
// => strot.sin0;  => strot.sin1; // connect to make freq change 
.5 => strot.gain;

STGAIN stgain;
stgain.connect(last $ ST , 1. /* static gain */  );       stgain $ ST @=>  last; 
stgain.connect(stmix $ ST , 0.5 /* static gain */  );       stgain $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .05 /* mix */, 4 * 10. /* room size */, 4::second /* rev time */, 0.3 /* early */ , 0.7 /* tail */ ); stgverb $ ST @=>  last; 

WAIT w;
8 *data.tick => w.fixed_end_dur;

"../_SAMPLES/ambient_universe/SYNTTEST" => string f1;

while(1) {
 

spork ~  KEY(60     /* note */, .2 /* g */, 12 * data.tick /* d */, 4::second /* attack */, 4::second/*  release */,  f1 /* file */);
spork ~  KEY(60 + 4 /* note */, .2 /* g */, 12 * data.tick /* d */, 4::second /* attack */, 4::second/*  release */,  f1 /* file */);
spork ~  KEY(60 + 7 /* note */, .2 /* g */, 12 * data.tick /* d */, 4::second /* attack */, 4::second/*  release */,  f1 /* file */);

8 * data.tick =>  w.wait; 

spork ~  KEY(60 + 2 /* note */, .2 /* g */, 12 * data.tick /* d */, 4::second /* attack */, 4::second/*  release */,  f1 /* file */);
spork ~  KEY(60 + 5 /* note */, .2 /* g */, 12 * data.tick /* d */, 4::second /* attack */, 4::second/*  release */,  f1 /* file */);
spork ~  KEY(60 + 9 /* note */, .2 /* g */, 12 * data.tick /* d */, 4::second /* attack */, 4::second/*  release */,  f1 /* file */);
 
8 * data.tick =>  w.wait; 

spork ~  KEY(60 + 3 /* note */, .2 /* g */, 12 * data.tick /* d */, 4::second /* attack */, 4::second/*  release */,  f1 /* file */);
spork ~  KEY(60 + 7 /* note */, .2 /* g */, 12 * data.tick /* d */, 4::second /* attack */, 4::second/*  release */,  f1 /* file */);
spork ~  KEY(60 + 10 /* note */, .2 /* g */, 12 * data.tick /* d */, 4::second /* attack */, 4::second/*  release */,  f1 /* file */);
 
8 * data.tick =>  w.wait; 

spork ~  KEY(60 + 12 /* note */, .2 /* g */, 12 * data.tick /* d */, 4::second /* attack */, 4::second/*  release */,  f1 /* file */);
spork ~  KEY(60 + 9 /* note */, .2 /* g */, 12 * data.tick /* d */, 4::second /* attack */, 4::second/*  release */,  f1 /* file */);
spork ~  KEY(60 + 5 /* note */, .2 /* g */, 12 * data.tick /* d */, 4::second /* attack */, 4::second/*  release */,  f1 /* file */);
spork ~  KEY(60 + 3 /* note */, .2 /* g */, 12 * data.tick /* d */, 4::second /* attack */, 4::second/*  release */,  f1 /* file */);
 
8 * data.tick =>  w.wait; 

}
