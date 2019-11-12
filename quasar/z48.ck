HW.launchpad.virtual_key_on_only(87); // Slide


SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(8 * data.tick , - .5*data.tick /* offset */); 

HW.launchpad.virtual_key_off_only(87); // Slide

HW.launchpad.virtual_key_off_only(24);
HW.launchpad.virtual_key_off_only(25);
HW.launchpad.virtual_key_off_only(26);
HW.launchpad.virtual_key_off_only(27);
HW.launchpad.virtual_key_off_only(35);
HW.launchpad.virtual_key_off_only(76);

HW.launchpad.virtual_key_off_only(11); 
HW.launchpad.virtual_key_off_only(12); 
HW.launchpad.virtual_key_off_only(13); 
HW.launchpad.virtual_key_off_only(45); 
HW.launchpad.virtual_key_off_only(46); 


HW.launchpad.virtual_key_on_only(86); 
HW.launchpad.virtual_key_on_only(81); 
HW.launchpad.virtual_key_on_only(82); 
HW.launchpad.virtual_key_on_only(83); 
HW.launchpad.virtual_key_on_only(84); 
HW.launchpad.virtual_key_on_only(85); 

12 * data.tick => now;
HW.launchpad.virtual_key_off_only(83); 

HW.launchpad.virtual_key_on_only(67); 
HW.launchpad.virtual_key_on_only(68); 
HW.launchpad.virtual_key_off_only(81); 
HW.launchpad.virtual_key_off_only(82); 
HW.launchpad.virtual_key_off_only(86); 


4 * data.tick => now;
HW.launchpad.virtual_key_off_only(84); 
HW.launchpad.virtual_key_off_only(85); 


HW.launchpad.virtual_key_on_only(76); 
HW.launchpad.virtual_key_on_only(77); 
HW.launchpad.virtual_key_on_only(78); 
HW.launchpad.virtual_key_on_only(65); 
HW.launchpad.virtual_key_on_only(66); 


while(1) {
       10000::ms => now;
}
 

