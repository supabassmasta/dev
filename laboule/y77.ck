<<<"*******************************">>>;
<<<"**        MUTE BEAT !!!      **">>>;
<<<"*******************************">>>;
MASTER_STADSR.keyOff(1);

class END extends end { fun void kill_me () {
  MASTER_STADSR.keyOn(1);
}}; END the_end; me.id() => the_end.shred_id; killer.reg(the_end);  

while(1) {
       100::ms => now;
}
 
