public class STREVAUX extends ST{
//  STREV1 rev1;
  // STTOAUX toaux;
     static STCONVREV @ stconvrev;
     0 => static int revCreated;
      static STGAIN @ stgainRevIn;

      STGAIN stgainToRev;
      STGAIN stgainToDry;

  fun void connect(ST @ tone, float mix) {
    // No need to use external Convolution Rev anymore

    // if ( MISC.check_output_nb() >= 4  ){
    //   toaux.connect(tone, 1. - mix, mix, 1);
    //   toaux.left() => outl;
    //   toaux.right() => outr;
    // }
    // else {
    //   <<<"STREVAUX: Not enough output, use STREV1 instead">>>;
//       mix * 1.5 => mix; // BOOST MIX with this REV
//       rev1.connect(tone, mix);
//       rev1.left() => outl;
//       rev1.right() => outr;
    // }

    // For compatibility use a ConvRev for old songs
//       mix * 4.5 => mix; // BOOST MIX with this REV

   //  stconvrev.connect(tone $ ST , 14/* ir index */, 2 /* chans */, 30::ms /* pre delay*/, mix * 0.5 /* rev gain */  , 1. - mix /* dry gain */  );     
    // stconvrev.left() => outl;
    // stconvrev.right() => outr;

//    tone.left() => outl;
//    tone.right() => outr;

      if ( !revCreated  ){
          // First instance create the Rev. Warning, it must be alive during all the song
          1 => revCreated;
          new STGAIN @=> stgainRevIn;
          new STCONVREV @=> stconvrev;
          stconvrev.connect(stgainRevIn $ ST , 14/* ir index */, 2 /* chans */, 30::ms /* pre delay*/, 1. /* rev gain */  , 0. /* dry gain */  ); 

      }

      stgainToRev.connect(tone $ ST , mix /* static gain */  );       stgainToRev $ ST @=> ST @ last; 
      stgainRevIn.connect(last $ ST , .5 /* static gain */  );   

      stgainToDry.connect(tone $ ST , 1. - mix /* static gain */  );  

  }



}

