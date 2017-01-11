SEQ s;  //data.tick * 8 => s.max;  // SET_WAV.DUBSTEP(s);// SET_WAV.VOLCA(s); 
SET_WAV.ACOUSTIC(s); // SET_WAV.TABLA(s);// SET_WAV.CYMBALS(s);
// _ = pause , ~ = special pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = rate , ? = proba , $ = autonomous  
"s_" => s.seq;
.9 => s.gain; // s.gain("s", .2); // for single wav 
// s.element_sync(); //s.no_sync(); //s.full_sync();  // 16 * data.tick => s.extra_end;   //s.print();
// s.mono() => dac; //s.left() => dac.left; //s.right() => dac.right;
s.go(); 

class STECHOC extends ST{

  Gain fbl => outl;
  fbl => Delay dl => fbl;

  Gain fbr => outr;
  fbr => Delay dr => fbr;

  0. =>  dl.gain => dr.gain;
  data.tick => dl.max => dl.delay => dr.max => dr.delay;

  class control_gain extends CONTROL {
    Delay @ dlp;
    Delay @ drp;
    fun void set (float in) {
      <<<"control_gain", in>>>;
      in / 127. =>  dlp.gain => drp.gain;

    }
  }

  class control_delay extends CONTROL {
    Delay @ dlp;
    Delay @ drp;
     fun void set (float in) {
      <<<"control_delay", in>>>;

      data.tick * (in + 1) / 32. =>  dlp.max => dlp.delay => drp.max => drp.delay; 
    }
  }
  
  control_gain cgain;
  dr @=> cgain.drp; 
  dl @=> cgain.dlp; 

  control_delay cdelay;
  dr @=> cdelay.drp; 
  dl @=> cdelay.dlp; 

  fun void connect(ST @ tone, CONTROLER d, CONTROLER g) {
    tone.left() => fbl;
    tone.right() => fbr;

    d.reg(cdelay);
    g.reg(cgain);

  }

}
//NANO_CONTROLER nano;
STECHOC ech;
ech.connect(s $ ST , HW.nano.potar[1][1] , HW.nano.fader[1][1] ); 

HW.nano.fader[1][1].set(64);

HW.nano.potar[1][1].set(16);

4 * data.tick => now;

HW.nano.potar[1][1].set(8);

4 * data.tick => now;

HW.nano.potar[1][1].set(4);

4 * data.tick => now;



while(1) {
       100::ms => now;
}
 
