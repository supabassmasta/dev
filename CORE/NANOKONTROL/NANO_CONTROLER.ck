public class NANO_CONTROLER extends NANO {

  CONTROLER button_back;
  CONTROLER button_play;
  CONTROLER button_forward;
  CONTROLER button_loop;
  CONTROLER button_stop;
  CONTROLER button_rec;
  CONTROLER fader[5][10];
  CONTROLER potar[5][10];
  CONTROLER button_up[5][10];
  CONTROLER button_down[5][10];

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


//NANO_CONTROLER instance;

while(1) {
       100::ms => now;
}
 


// TEST
/*
class test_control extends CONTROL {
    fun void set (float in) {
      <<<"test_control", in>>>;
    }
}

class test_control2 extends CONTROL {
    fun void set (float in) {
      <<<"test_control2", in>>>;
    }
}


test_control t;
test_control2 t2;
NANO_CONTROLER n;

1 => t.update_on_reg;
n.button_back.reg( t );

n.start();

n.button_back.set( 33.45 );
n.button_back.set( 33 );
n.button_back.unreg( t );
n.button_back.unreg( t );
n.button_back.set( 36 );
n.button_back.reg( t2 );
n.button_back.set( 37 );
n.button_back.reg( t );
n.button_back.set( 38 );
n.potar[1][1].reg(t);
n.fader[1][1].reg(t2);
n.button_up[2][2].reg(t2);
n.button_down[2][2].reg(t2);
while (1) {

  1000::ms => now;
}

*/
