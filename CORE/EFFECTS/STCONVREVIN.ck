public class STCONVREVIN extends ST{
  ConvRev cr;

  Gain dryl => outl;
  Gain dryr => outr;


  0 => int start_sample;

  fun void read_ir(ST @ tone, UGen @ ir, dur rev_dur, float rev_g) {
    ir =>  blackhole ;

    // Record samples one by one
    now + rev_dur => time end;
    0 => int i;
    while (now < end ) {
      1::samp => now;
      cr.coeff(i, ir.last()); 
      1 +=> i;
    }

    256 => cr.blocksize ; // set to any power of 2
    cr.init();  // initialize the conv rev engine

    rev_g => cr.gain;
    tone.left() => cr => outl;
    tone.right() => cr => outr;

  }


  fun void connect(ST @ tone, UGen @ ir, dur rev_dur, float rev_g, float dry_g) {
      (rev_dur/ 1::samp) $ int + 1 => cr.order;
      spork ~ read_ir(tone, ir, rev_dur, rev_g);

      // Dry will be alone during the ir loading
      dry_g => dryl.gain => dryr.gain;

      tone.left() => dryl;
      tone.right() => dryr;
  }

}



