class REFSYNC extends CONTROL {
   fun void set(float in) {
     MASTER_SEQ3.update_ref_times(now, data.tick * 4);
   }
}

REFSYNC refsync;

HW.launchpad.controls[1].reg(refsync);

0::ms => dur d;
now => time tref;
dur da [4];
dur dmean;
0 => int dnb;

class REFTICK extends CONTROL {
   fun void set(float in) {
     now - tref => d;
     now => tref;

     if (data.tick * .8 < d && d < data.tick * 1.2) {
       d => da[dnb]; 
       1+=>dnb;
       if (dnb == 4) {
         (da[0] + da[1] + da[2] + da[3]) / 4 => dmean;
         MASTER_SEQ3.update_durations(dmean, 1);
         0=> dnb;
         <<<"UPDATE tick", data.tick, " BPM", 60::second / data.tick>>>; 
       }
     }
     else {
       0 => dnb;
       <<<"Invalid Tick to update BPM reset counter">>>; 
     }

   }
}

REFTICK reftick;
HW.launchpad.controls[1].reg(reftick);

while(1) {
       100::ms => now;
}
 
