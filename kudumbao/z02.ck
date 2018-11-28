// CONTROLLERS:
// HW.lpd8.potar[1][1]   HW.lpd8.pad[1][1]  
// HW.kb.updown          HW.kb.leftright
// HW.nano.potar[1][1]   HW.nano.fader[1][1]      HW.nano.button_up[1][1]   HW.nano.button_down[1][1]
// HW.nano.button_back   HW.nano.button_play   HW.nano.button_forward   HW.nano.button_loop    HW.nano.button_stop   HW.nano.button_rec
// HW.launchpad.keys[16*0 + 0] /* pad 1:1 */  HW.launchpad.controls[1] /* ? */ 
// HW.launchpad.red[16*0 + 0]   HW.launchpad.green[16*0 + 0]   HW.launchpad.amber[16*0 + 0]   HW.launchpad.clear[16*0 + 0]
// HW.launchpad.redc[?]  HW.launchpad.greenc[?]  HW.launchpad.amberc[?]  HW.launchpad.clearc[?]    


class cont extends CONTROL {
   // 0 =>  update_on_reg ;
   0xFFFFFFFF => int last; 
    
   fun void set(float in) {
     int diff;
     if (last ==  0xFFFFFFFF ){
        in $ int => last;    
     }
     else {
        in $ int - last => diff;
        MASTER_SEQ3.offset_ref_times(diff * 1::ms); 
        in $ int => last;
        <<<"Offset REF TIMES: ", diff, " ms">>>; 
     }
   }
}

cont c;
HW.kb.leftright.reg (c);

while(1) {
       100::ms => now;
}
 

