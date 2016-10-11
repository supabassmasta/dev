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

}
