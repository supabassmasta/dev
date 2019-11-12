SYNC sy;
//sy.sync(4 * data.tick);
//sy.sync(16 * data.tick , - 4.5*data.tick /* offset */); 
sy.sync(16 * data.tick , - .5*data.tick /* offset */); 

HW.launchpad.virtual_key_on_only(85); // One humanity

12 * data.tick => now;

HW.launchpad.virtual_key_off_only(85); // One humanity


HW.launchpad.virtual_key_off_only(11); 
HW.launchpad.virtual_key_off_only(12);  // BAss hard 
HW.launchpad.virtual_key_off_only(56); // BAss light

HW.launchpad.virtual_key_off_only(82);  // VS 2
HW.launchpad.virtual_key_off_only(16); // Congas and co

HW.launchpad.virtual_key_on_only(26);  // Break
HW.launchpad.virtual_key_on_only(76);// Slide 

4 * data.tick => now;


HW.launchpad.virtual_key_off_only(11); 
HW.launchpad.virtual_key_off_only(13); 
HW.launchpad.virtual_key_off_only(14); 
HW.launchpad.virtual_key_off_only(15); 

HW.launchpad.virtual_key_off_only(21); 
HW.launchpad.virtual_key_off_only(22); 
HW.launchpad.virtual_key_off_only(23); 
HW.launchpad.virtual_key_off_only(24); 

HW.launchpad.virtual_key_on_only(51); 
HW.launchpad.virtual_key_on_only(52); 
//HW.launchpad.virtual_key_on_only(61); 
HW.launchpad.virtual_key_on_only(11); 
//HW.launchpad.virtual_key_on_only(62); 
//HW.launchpad.virtual_key_on_only(12); // BASS HARD
HW.launchpad.virtual_key_on_only(56); // BAss light

//HW.launchpad.virtual_key_on_only(22); 


.45 * data.tick => now;

HW.launchpad.virtual_key_off_only(26); 
HW.launchpad.virtual_key_off_only(76); 


while(1) {
       100::ms => now;
}
 
