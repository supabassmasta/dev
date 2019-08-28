SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(4 * data.tick , - .5*data.tick /* offset */); 

HW.launchpad.virtual_key_off_only(11); 
HW.launchpad.virtual_key_off_only(12); 
HW.launchpad.virtual_key_off_only(13); 
HW.launchpad.virtual_key_off_only(14); 
HW.launchpad.virtual_key_off_only(15); 

HW.launchpad.virtual_key_off_only(21); 
HW.launchpad.virtual_key_off_only(22); 
HW.launchpad.virtual_key_off_only(23); 
HW.launchpad.virtual_key_off_only(24); 

HW.launchpad.virtual_key_on_only(51); 
HW.launchpad.virtual_key_on_only(52); 
HW.launchpad.virtual_key_on_only(61); 
HW.launchpad.virtual_key_on_only(62); 

while(1) {
       100::ms => now;
}
 
