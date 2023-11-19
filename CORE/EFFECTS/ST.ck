public class ST {
  
  NULL @=> ST @ next;

  Gain outl => dac.left;
  Gain outr => dac.right;

  fun void gain(float g) {
    g => outl.gain => outr.gain;
  }

  0=> int left_out_active;
  Gain left_out;
  fun UGen left() {
    if (!left_out_active) {
      outl =< dac.left;
      outl => left_out;
      1 => left_out_active;
    } 
    return left_out;
  }
  
  0 => int right_out_active;
  Gain right_out;
  fun UGen right() {
    if (!right_out_active) {
      outr =< dac.right;
      outr => right_out;
      1 => right_out_active; 
    }
    return right_out;
  }


  0 => int mono_out_active;
  Gain mono_out_g;
  fun UGen mono() {
    if (!mono_out_active) {
//      if (!right_out_active) {
//        outr =< dac.right;
//        outr => right_out;
//        1 => right_out_active; 
//      }    
//      right_out => mono_out_g;
        right() => mono_out_g;

//      if (!left_out_active) {
//        outl =< dac.left;
//        outl => left_out;
//        1 => left_out_active;
//      }
//      left_out  => mono_out_g;
        left()  => mono_out_g;

      1 => mono_out_active;
    }
    return mono_out_g;
  }

  0 => int mono_in_active;
  Gain mono_in_g;
  fun void mono_in (UGen @ in) {
    if (!mono_in_active) {
//      .5 => mono_in_g.gain;
      in => mono_in_g => outl;
      mono_in_g => outr;
      1 => mono_in_active;
    }
    else {
      in => mono_in_g;
    }
  }

  fun void disconnect() {
    outl =< dac.left;
    outr =< dac.right;
    outl =< left_out;
    outr =< right_out;
  }

}
