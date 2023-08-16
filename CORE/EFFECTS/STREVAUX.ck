public class STREVAUX extends ST{
  STREV1 rev1;
  STTOAUX toaux;

  fun void connect(ST @ tone, float mix) {
    if ( MISC.check_output_nb() >= 4  ){
      toaux.connect(tone, 1. - mix, mix, 1);
      toaux.left() => outl;
      toaux.right() => outr;
    }
    else {
      <<<"STREVAUX: Not enough output, use STREV1 instead">>>;
      mix * 1.5 => mix; // BOOST MIX with this REV
      rev1.connect(tone, mix);
      rev1.left() => outl;
      rev1.right() => outr;
    }

  }



}

