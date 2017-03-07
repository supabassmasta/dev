public class ST {
  
  Gain outl => dac.left;
  Gain outr => dac.right;


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

/*
  0 => int mono_out_active;
  Gain mono_out;
  fun UGen mono() {
    if (!mono_out_active) {
      if (!right_out_active) {
        outr =< dac.right;
        outr => right_out;
        1 => right_out_active; 
      }    
      right_out => mono_out;

      if (!left_out_active) {
        outl =< dac.left;
        outl => left_out;
        1 => left_out_active;
      }
      left_out  => mono_out;

      1 => mono_out_active;
    }
    return mono_out;
  }
*/

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
}
