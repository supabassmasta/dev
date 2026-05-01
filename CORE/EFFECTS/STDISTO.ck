public class STDISTO extends ST{
  Distortion distl  => outl;
  Distortion distr => outr;



  fun void connect(ST @ tone, int mode, float gain_in, int dc_block, float g) {
    if ( mode == -1  ){
       <<<"DISTO BYPASS">>>;
      tone.left() => outl;
      tone.right() => outr;

    }
    else {
      tone.left() => distl;
      tone.right() => distr;

      dc_block => distl.dcBlock => distr.dcBlock;
      
      g => distl.gain => distr.gain;
      gain_in => distl.gainIn=> distr.gainIn;

      if ( mode == 0  ){
        .5 => distl.threshold=> distr.threshold;    
        distl.mode( Distortion.HARD_CLIP);distr.mode( Distortion.HARD_CLIP);
        <<<"DISTO HARD_CLIP, default\n.5 => stdisto.distl.threshold=> stdisto.distr.threshold;","">>>;
      }
      else if ( mode == 1  ){
        .5 => distl.threshold=> distr.threshold;    
        .8 => distl.knee=> distr.knee;    
        distl.mode( Distortion.SOFT_CLIP);distr.mode( Distortion.SOFT_CLIP);
        <<<"DISTO SOFT_CLIP, default\n.5 => stdisto.distl.threshold=> stdisto.distr.threshold;\n.8 => stdisto.distl.knee => stdisto.distr.knee;","">>>;
      }
      else if ( mode == 2  ){
        .4 => distl.foldThreshold=> distr.foldThreshold;    
        distl.mode( Distortion.FOLDBACK);distr.mode( Distortion.FOLDBACK);
        <<<"DISTO FOLDBACK, default\n.4 => stdisto.distl.foldThreshold=> stdisto.distr.foldThreshold;","">>>;
      }
      else if ( mode == 3  ){
        .15 => distl.bias=> distr.bias;    
        .6 => distl.warmth=> distr.warmth;    
        distl.mode( Distortion.TUBE);distr.mode( Distortion.TUBE);
        <<<"DISTO TUBE, default\n.15 => stdisto.distl.bias=> stdisto.distr.bias;\n.6 =>  stdisto.distl.warmth=>  stdisto.distr.warmth;","">>>;
      }
      else if ( mode == 4  ){
        8.0 => distl.drive=> distr.drive;    
        distl.mode( Distortion.ARCTANGENT);distr.mode( Distortion.ARCTANGENT);
        <<<"DISTO ARCTANGENT, default\n8.0 => stdisto.distl.drive=> stdisto.distr.drive;","">>>;
      }
      else if ( mode == 5  ){
        .6 => distl.tone=> distr.tone;    
        .4 => distl.presence=> distr.presence;    
        distl.mode( Distortion.AMPSIM);distr.mode( Distortion.AMPSIM);
        <<<"DISTO AMPSIM, default\n.6 => stdisto.distl.tone=> stdisto.distr.tone;\n.4 => stdisto.distl.presence => stdisto.distr.presence;","">>>;
      }
      else if ( mode == 6  ){
        6.0 => distl.drive=> distr.drive;    
        .1 => distl.bias=> distr.bias;    
        distl.mode( Distortion.OVERDRIVE);distr.mode( Distortion.OVERDRIVE);
        <<<"DISTO OVERDRIVE, default\n6.0 => stdisto.distl.drive=> stdisto.distr.drive;\n.1 => stdisto.distl.bias => stdisto.distr.bias;","">>>;
      }
      else if ( mode == 7  ){
        .4 => distl.tone=> distr.tone;    
        distl.mode( Distortion.FUZZ);distr.mode( Distortion.FUZZ);
        <<<"DISTO FUZZ, default\n.4 => stdisto.distl.tone=> stdisto.distr.tone;\n","">>>;
      }
      else if ( mode == 8  ){
        4.0 => distl.bits=> distr.bits;    
        distl.mode( Distortion.BITCRUSH);distr.mode( Distortion.BITCRUSH);
        <<<"DISTO BITCRUSH, default\n4.0 => stdisto.distl.bits=> stdisto.distr.bits;\n","">>>;
      }
      else if ( mode == 9  ){
        1.5 => distl.shape=> distr.shape;    
        distl.mode( Distortion.WAVESHAPER);distr.mode( Distortion.WAVESHAPER);
        <<<"DISTO WAVESHAPER, default\n1.5 => stdisto.distl.shape=> stdisto.distr.shape;\n","">>>;
      }
      else if ( mode == 10  ){
        0.7 => distl.asymmetry=> distr.asymmetry;    
        distl.mode( Distortion.DIODE);distr.mode( Distortion.DIODE);
        <<<"DISTO DIODE, default\n0.7 => stdisto.distl.asymmetry=> stdisto.distr.asymmetry;\n","">>>;
      }
      else if ( mode == 11  ){
        10 => distl.slope=> distr.slope;    
        distl.mode( Distortion.SIGMOID);distr.mode( Distortion.SIGMOID);
        <<<"DISTO SIGMOID, default\n10 => stdisto.distl.slope=> stdisto.distr.slope;\n","">>>;
      }
      else if ( mode == 12  ){
        .5 => distl.threshold=> distr.threshold;    
        2.0 => distl.foldFreq=> distr.foldFreq;    
        distl.mode( Distortion.SINEFOLD);distr.mode( Distortion.SINEFOLD);
        <<<"DISTO SINEFOLD, default\n.5 => stdisto.distl.threshold=> stdisto.distr.threshold;\n2.0 => stdisto.distl.foldFreq => stdisto.distr.foldFreq;","">>>;
      }
      else if ( mode == 13  ){
        0.9 => distl.sampleHold=> distr.sampleHold;    
        distl.mode( Distortion.DECIMATOR);distr.mode( Distortion.DECIMATOR);
        <<<"DISTO DECIMATOR, default\n0.9 => stdisto.distl.sampleHold=> stdisto.distr.sampleHold;\n","">>>;
      }

    }

  }

}

