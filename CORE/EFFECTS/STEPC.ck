class control_step extends CONTROL {
  Envelope @ st;
  float min;
  float max;
   
  1 => update_on_reg ;
  
  fun void set (float in) {
    (in / 127.) * (max - min) + min => st.target;
    <<<"Step next:", st.target()>>>;
  }
}

public class STEPC {
  Step one => Envelope out;
  1. => one.next;

  control_step cs;
  out @=> cs.st;

  END_CONTROL end;

  fun void init(CONTROLER cont, float min, float max, dur transition_dur) {
    min => cs.min;
    max => cs.max;
    cont.reg(cs);
    end.conf(end, cont ,cs);
    transition_dur => out.duration;
  }

}

