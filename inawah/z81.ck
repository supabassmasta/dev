SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(8 * data.tick , -0.5 * data.tick /* offset */); 



//1 * data.tick => now;
HW.launchpad.virtual_key_off_only(71); // Synt
HW.launchpad.virtual_key_off_only(72); 

HW.launchpad.virtual_key_on_only(75); // Synt transition
HW.launchpad.virtual_key_on_only(76); 
9 * data.tick => now;
// OFF second part
HW.launchpad.virtual_key_off_only(55); // HH
HW.launchpad.virtual_key_off_only(12); // Kick
HW.launchpad.virtual_key_off_only(52); // rim shot
HW.launchpad.virtual_key_off_only(62); // rim shot
HW.launchpad.virtual_key_off_only(53); // Big Drum
HW.launchpad.virtual_key_off_only(75); // Synt transition
HW.launchpad.virtual_key_off_only(76); 

// Thunder
HW.launchpad.virtual_key_on_only(65); 
//HW.ledstrip.cereal.writeByte('o'); // Thunder leds

MASTER_SEQ3.offset_ref_times(3 * data.tick);

HW.launchpad.virtual_key_on_only(18); // Chaman
HW.launchpad.virtual_key_off_only(54); // leds: remove last script

8 * data.tick => now;

HW.launchpad.virtual_key_on_only(12); 
HW.launchpad.virtual_key_on_only(13); 
HW.launchpad.virtual_key_on_only(14); 
HW.launchpad.virtual_key_on_only(15); 

.5 * data.tick + 186::ms => now;
HW.ledstrip.cereal.writeByte('D'); // leds last part
3.5 * data.tick  - 186::ms=> now;

HW.launchpad.virtual_key_on_only(25); // Pads 

// Thunder
HW.launchpad.virtual_key_off_only(65); 

while(1) {
       10000::ms => now;
}
 

