SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(8 * data.tick , -0.5 * data.tick /* offset */); 



1 * data.tick => now;
// OFF second part
HW.launchpad.virtual_key_off_only(55); // HH
HW.launchpad.virtual_key_off_only(12); // Kick
HW.launchpad.virtual_key_off_only(52); // rim shot
HW.launchpad.virtual_key_off_only(62); // rim shot
HW.launchpad.virtual_key_off_only(53); // Big Drum

HW.launchpad.virtual_key_off_only(71); // Synt
HW.launchpad.virtual_key_off_only(72); 

// Thunder
HW.launchpad.virtual_key_on_only(65); 

MASTER_SEQ3.offset_ref_times(3 * data.tick);

HW.launchpad.virtual_key_on_only(18); // Chaman

8 * data.tick => now;

HW.launchpad.virtual_key_on_only(12); 
HW.launchpad.virtual_key_on_only(13); 
HW.launchpad.virtual_key_on_only(14); 
HW.launchpad.virtual_key_on_only(15); 

4 * data.tick => now;

HW.launchpad.virtual_key_on_only(25); // Pads 

while(1) {
       10000::ms => now;
}
 

