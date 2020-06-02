SYNC sy;
//sy.sync(4 * data.tick);
//sy.sync(16 * data.tick , - 4.5*data.tick /* offset */); 
sy.sync(8 * data.tick , - .5*data.tick /* offset */); 

HW.launchpad.virtual_key_on_only(81); // VS

(32 * 2 + 8 ) * data.tick => now;

HW.launchpad.virtual_key_off_only(11); 
HW.launchpad.virtual_key_off_only(12); // BASS light
HW.launchpad.virtual_key_off_only(13); // BASS hard
HW.launchpad.virtual_key_off_only(17); // Congas and co

HW.launchpad.virtual_key_off_only(61); 
HW.launchpad.virtual_key_off_only(62); 


HW.launchpad.virtual_key_on_only(26); 
HW.launchpad.virtual_key_on_only(76); 

8 * data.tick => now;


HW.launchpad.virtual_key_off_only(11); 
HW.launchpad.virtual_key_off_only(14); 
HW.launchpad.virtual_key_off_only(15); 
HW.launchpad.virtual_key_off_only(16); 

HW.launchpad.virtual_key_off_only(21); 
HW.launchpad.virtual_key_off_only(22); 
HW.launchpad.virtual_key_off_only(23); 
HW.launchpad.virtual_key_off_only(24); 

HW.launchpad.virtual_key_off_only(51); 
HW.launchpad.virtual_key_off_only(52); 


.45 * data.tick => now;

HW.launchpad.virtual_key_off_only(26); 
HW.launchpad.virtual_key_off_only(76); 
HW.launchpad.virtual_key_off_only(81); // VS
HW.launchpad.virtual_key_off_only(78); // ECHO FLUTE
HW.launchpad.virtual_key_off_only(88); // REV FLUTE


while(1) {
       100::ms => now;
}
 
