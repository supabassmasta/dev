SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(8 * data.tick , - .5*data.tick /* offset */); 

HW.launchpad.virtual_key_off_only(11); 
HW.launchpad.virtual_key_off_only(12); 


HW.launchpad.virtual_key_off_only(76); 
HW.launchpad.virtual_key_off_only(77); 
HW.launchpad.virtual_key_off_only(78); 
HW.launchpad.virtual_key_off_only(65); 
HW.launchpad.virtual_key_off_only(66); 
HW.launchpad.virtual_key_off_only(67); 
HW.launchpad.virtual_key_off_only(68); 


HW.launchpad.virtual_key_on_only(53);  // Slide
HW.launchpad.virtual_key_on_only(57); // Kick
HW.launchpad.virtual_key_on_only(76); // blips
HW.launchpad.virtual_key_on_only(34); // Slide BAss

4 * data.tick => now;
HW.launchpad.virtual_key_off_only(45); 
HW.launchpad.virtual_key_off_only(46); 

4 * data.tick => now;
HW.launchpad.virtual_key_off_only(53);  // Slide
HW.launchpad.virtual_key_off_only(34); // Slide BAss

HW.launchpad.virtual_key_on_only(25);
HW.launchpad.virtual_key_on_only(26);
HW.launchpad.virtual_key_on_only(27);
HW.launchpad.virtual_key_on_only(35);

.35 * data.tick => now;

HW.launchpad.virtual_key_on_only(24);
HW.launchpad.virtual_key_off_only(57); // Kick


while(1) {
       10000::ms => now;
}
 

