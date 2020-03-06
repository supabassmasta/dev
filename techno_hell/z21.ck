// CONTROLLERS:
// HW.lpd8.potar[1][1]   HW.lpd8.pad[1][1]  
// HW.kb.updown          HW.kb.leftright
// HW.nano.potar[1][1]   HW.nano.fader[1][1]      HW.nano.button_up[1][1]   HW.nano.button_down[1][1]
// HW.nano.button_back   HW.nano.button_play   HW.nano.button_forward   HW.nano.button_loop    HW.nano.button_stop   HW.nano.button_rec
// HW.launchpad.keys[16*0 + 0] /* pad 1:1 */  HW.launchpad.controls[1] /* ? */ 
// HW.launchpad.red[16*0 + 0]   HW.launchpad.green[16*0 + 0]   HW.launchpad.amber[16*0 + 0]   HW.launchpad.clear[16*0 + 0]
// HW.launchpad.redc[?]  HW.launchpad.greenc[?]  HW.launchpad.amberc[?]  HW.launchpad.clearc[?]    

class TAP extends CONTROL {
  // 0 =>  update_on_reg ;
  32 => int nb_tap;
  186::ms => dur lat;
  48::ms + 20::ms => dur jitter_mean;
  
  0 => int i;
  time r;
  time r_first;
  dur delta_mean;

  fun void set(float in) {
    if ( in == 127  ){
       now - (data.tick * i) => r;

      if ( i == 0  ){
        r => r_first; 
        0::ms =>delta_mean;
      }
      else {
        (r - r_first) + delta_mean => delta_mean;
      }

      <<<"TAP ", i>>>;

      1 +=> i;

      if ( i >= nb_tap   ){
        delta_mean / (nb_tap - 1) => delta_mean;

        MASTER_SEQ3.update_ref_times (r_first + delta_mean - lat + jitter_mean, nb_tap * data.tick);

        0 => i;
      }
    }
  }

} 

LAUNCHPAD lp;
lp.start();

TAP tap;
lp.keys[16*1 + 2].reg(tap);
lp.red(16*1 + 2);

while(1) {
       100::ms => now;
}
 
