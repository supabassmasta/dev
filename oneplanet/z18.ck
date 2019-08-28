SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(4 * data.tick , - .5*data.tick /* offset */); 

HW.launchpad.virtual_key_off_only(51); 
HW.launchpad.virtual_key_off_only(52); 
HW.launchpad.virtual_key_off_only(61); 
HW.launchpad.virtual_key_off_only(62); 

HW.launchpad.virtual_key_on_only(11); 
HW.launchpad.virtual_key_on_only(12); 

HW.launchpad.virtual_key_on_only(21); 


while(1) {
       100::ms => now;
}
 
