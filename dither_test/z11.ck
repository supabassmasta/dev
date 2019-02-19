	SndBuf buf;
	SndBuf buf2;

//  .5 => buf.gain;
  "../_SAMPLES/EC/Indian kid projectMaster32.wav" =>buf.read;
//  "../_SAMPLES/EC/Indian kid projectMaster16powr2.wav" =>buf.read;
//  "../_SAMPLES/EC/Indian kid projectMaster16powr3.wav" =>buf2.read;
//  "../_SAMPLES/EC/Indian kid projectMaster16nodith.wav" =>buf.read;
  "../_SAMPLES/EC/Indian kid projectMaster16nodith.wav" =>buf2.read;


  buf => Delay d => Gain sub => dac;
  buf2 => Delay d2 => sub;
  2 => sub.op;
  
1000::ms => d.max => d.delay;
1000::ms => d2.max => d2.delay;

  while(1) {
    LPD8.pot[0][0] => int a;
    LPD8.pot[0][1] => int b;
    //    <<<"a ", a , "b ", b>>>;
    (a *10 + b)*1::samp => dur de; 
    if (de > 640::samp) {
      de - 640::samp => d.delay;
      0::samp => d2.delay; 
    }
    else {
      de  => d2.delay;
      0::samp => d.delay; 
    }
    <<<"d.delay " ,d.delay(),"d2.delay " ,d2.delay()>>>;

    100::samp => now;
  }
   
