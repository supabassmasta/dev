SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(4 * data.tick , - .5*data.tick /* offset */); 

HW.launchpad.virtual_key_off_only(61); 
HW.launchpad.virtual_key_off_only(62); 
HW.launchpad.virtual_key_on_only(27); 
HW.launchpad.virtual_key_on_only(75); // Slide up 

4 * data.tick => now;


HW.launchpad.virtual_key_on_only(11); 
HW.launchpad.virtual_key_on_only(12); 

HW.launchpad.virtual_key_on_only(21); 

.45 * data.tick => now;

HW.launchpad.virtual_key_off_only(27); 
HW.launchpad.virtual_key_off_only(75); 

HW.launchpad.virtual_key_off_only(51); 
HW.launchpad.virtual_key_off_only(52); 

while(1) {
       100::ms => now;
}
 
