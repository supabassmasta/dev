SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(8 * data.tick , -0.5 * data.tick /* offset */); 

// Off first part
HW.launchpad.virtual_key_off_only(11); 
HW.launchpad.virtual_key_off_only(12); 
HW.launchpad.virtual_key_off_only(13); 
HW.launchpad.virtual_key_off_only(14); 
HW.launchpad.virtual_key_off_only(15); 
HW.launchpad.virtual_key_off_only(16); 
HW.launchpad.virtual_key_off_only(18); 
HW.launchpad.virtual_key_off_only(21); 
HW.launchpad.virtual_key_off_only(22); 
HW.launchpad.virtual_key_off_only(25); 
HW.launchpad.virtual_key_off_only(27); 
HW.launchpad.virtual_key_off_only(28); 
HW.launchpad.virtual_key_off_only(31); 
HW.launchpad.virtual_key_off_only(32); 
HW.launchpad.virtual_key_off_only(35); 
HW.launchpad.virtual_key_off_only(36); 
HW.launchpad.virtual_key_off_only(37); 
HW.launchpad.virtual_key_off_only(38); 
HW.launchpad.virtual_key_off_only(39); 

// Bridge
HW.launchpad.virtual_key_on_only(57); // Hit
HW.launchpad.virtual_key_on_only(55); // HH
HW.launchpad.virtual_key_on_only(56); // Slide

15 * data.tick => now;
HW.launchpad.virtual_key_off_only(57); // Hit
1 * data.tick => now;

HW.launchpad.virtual_key_off_only(56); // Slide

HW.launchpad.virtual_key_on_only(12); // Kick
HW.launchpad.virtual_key_on_only(52); // rim shot
HW.launchpad.virtual_key_on_only(53); // Big Drum

HW.launchpad.virtual_key_on_only(54); // Leds

while(1) {
       10000::ms => now;
}
 

