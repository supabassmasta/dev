public class NANO_CONTROLER extends NANO {

  CONTROLER button_back;
  CONTROLER button_play;
  CONTROLER button_forward;
  CONTROLER button_loop;
  CONTROLER button_stop;
  CONTROLER button_rec;
  CONTROLER fader[4][9];
  CONTROLER potar[4][9];
  CONTROLER button_up[4][9];
  CONTROLER button_down[4][9];

  fun void button_back_ext (int val)    {button_back.set(val); }
  fun void button_play_ext (int val)    {button_play.set(val);}
  fun void button_forward_ext (int val) {button_forward.set(val);}
  fun void button_loop_ext (int val)    {button_loop.set(val);}
  fun void button_stop_ext (int val)    {button_stop.set(val);}
  fun void button_rec_ext (int val)     {button_rec.set(val);}

  fun void fader_ext (int bank, int group, int val) {fader[bank][group].set(val);}
  fun void potar_ext (int bank, int group, int val) {potar[bank][group].set(val);}

  fun void button_up_ext (int bank, int group, int val) { button_up[bank][group].set(val);}
  fun void button_down_ext (int bank, int group, int val) {button_down[bank][group].set(val);}
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

n.start();

n.button_back.set( 33.45 );
n.button_back.set( 33 );
while (1) {

  1000::ms => now;
}
