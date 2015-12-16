public class NANO_CONTROLER extends NANO {

  CONTROLER button_back;

  fun void button_up_ext (int bank, int group, int val) { }
  fun void button_down_ext (int bank, int group, int val) {<<<"button down ", bank, group," : ",val>>>;}

  fun void button_back_ext (int val) {
      button_back.set(val);
    }
  fun void button_play_ext (int val) {<<<"button play: ",val>>>;}
  fun void button_forward_ext (int val) {<<<"button forward: ",val>>>;}
  fun void button_loop_ext (int val) {<<<"button loop: ",val>>>;}
  fun void button_stop_ext (int val) {<<<"button stop: ",val>>>;}
  fun void button_rec_ext (int val) {<<<"button rec: ",val>>>;}

  fun void fader_ext (int bank, int group, int val) {<<<"fader: ", bank, group, val>>>;}
  fun void potar_ext (int bank, int group, int val) {<<<"potar: ", bank, group, val>>>;}
}


// TEST
class test_control extends CONTROL {
    fun void set (float in) {
      <<<"test_control", in>>>;
    }
}

test_control t;
NANO_CONTROLER n;

1 => t.update_on_reg;
n.button_back.reg( t );

while (1) {

  1000::ms => now;
}
