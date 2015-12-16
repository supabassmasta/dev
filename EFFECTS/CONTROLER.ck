public class CONTROLER {
  CONTROL controls[0];
  0.0 => float val;
  
  fun void reg(CONTROL @ in) {
    controls << in;
    if (in.update_on_reg){
      in.set(val);
    }
  }

  fun void unreg(CONTROL @ in) {
    int i;
    -1  => int index;
    // find control index
    for (0 => i; i <  controls.size() ; i++) {
      if (in == controls[i]) {
        i => index;
      }
    }

    if (index != -1){
      // remove control from array
      for (index + 1 => i; i <  controls.size() ; i++) {
        controls[i] @=> controls[i - 1]; 
      }
      controls.size() - 1 => controls.size;
    }
    else {
        <<<"CONTROL not found", in, " cannot unregister">>>;
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
