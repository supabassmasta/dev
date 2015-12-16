public class CONTROLER {
  CONTROL controls[0];
  0.0 => float val;
  
  fun void reg(CONTROL @ in) {
    controls << in;
    if (in.update_on_reg){
      in.set(val);
    }
  }

  fun void set(float in) {
      0 => int i;
      in => val;
      
      // set all associated controls
      while (i < controls.size()) {
        controls[i].set(val); 
        i++;
      }
  }

}
