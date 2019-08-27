SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(8 * data.tick , - .5*data.tick /* offset */); 

HW.launchpad.virtual_key_off_only(77); 
HW.launchpad.virtual_key_off_only(78); 
HW.launchpad.virtual_key_off_only(65); 
HW.launchpad.virtual_key_off_only(66); 

HW.launchpad.virtual_key_on_only(58); 
HW.launchpad.virtual_key_on_only(55); 
HW.launchpad.virtual_key_on_only(56); 

8 * data.tick => now;
HW.launchpad.virtual_key_off_only(67); 
HW.launchpad.virtual_key_off_only(68); 

HW.launchpad.virtual_key_on_only(51);  // Slide
HW.launchpad.virtual_key_on_only(17);  // Break

12 * data.tick => now;

HW.launchpad.virtual_key_off_only(58); 
HW.launchpad.virtual_key_off_only(55); 

4 * data.tick => now;
HW.launchpad.virtual_key_off_only(51);  // Slide
HW.launchpad.virtual_key_off_only(17);  // Break
HW.launchpad.virtual_key_off_only(56); 

HW.launchpad.virtual_key_on_only(45);
HW.launchpad.virtual_key_on_only(11);
HW.launchpad.virtual_key_on_only(12);
HW.launchpad.virtual_key_on_only(13);

1 * data.tick => now;

while(1) {
       10000::ms => now;
}
 

