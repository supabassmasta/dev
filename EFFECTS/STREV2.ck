public class STREV2 extends ST{
  Gain directl => outl;
  Gain directr => outr;

  Gain revl => global_mixer.rev2_left;
  Gain revr => global_mixer.rev2_right;

  fun void connect(ST @ tone, float mix) {
    1. - mix => directl.gain => directr.gain;
    mix => revl.gain => revr.gain;
//    <<<"directl.gain", directl.gain()>>>; 
//    <<<"directr.gain", directr.gain()>>>; 
//    <<<"revl.gain ", revl.gain() >>>; 
//    <<<"revr.gain", revr.gain()>>>; 

    tone.left() => directl;
    tone.right() => directr;

    tone.left() => revl;
    tone.right() => revr;

  }
}

