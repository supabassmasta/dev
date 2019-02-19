	SndBuf buf;
	SndBuf buf2;

//  .5 => buf.gain;
//  "../_SAMPLES/EC/Indian kid projectMaster32.wav" =>buf.read;
  "../_SAMPLES/EC/Indian kid projectMaster16powr2.wav" =>buf.read;
  "../_SAMPLES/EC/Indian kid projectMaster16powr3.wav" =>buf2.read;
//  "../_SAMPLES/EC/Indian kid projectMaster16nodith.wav" =>buf.read;
//  "../_SAMPLES/EC/Indian kid projectMaster16nodith.wav" =>buf2.read;


  buf => Gain sub => dac;
  buf2 => sub;
  2 => sub.op;

  while(1) {
         100::ms => now;
  }
   
