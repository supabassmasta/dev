//<<<"TEST", data.tick * 8 / 1::ms>>>;


HW.launchpad.virtual_key_on_only(17); // The Hopi way
6::second => now;
MASTER_SEQ3.update_ref_times(now, data.tick * 16 * 128 );

0.5::data.tick => now;

//HW.launchpad.virtual_key_on_only(21); // Snakes

7.0::data.tick => now;


// Start Beat
HW.launchpad.virtual_key_on_only(12); 
HW.launchpad.virtual_key_on_only(13); 
HW.launchpad.virtual_key_on_only(14); 
HW.launchpad.virtual_key_on_only(15); 
HW.launchpad.virtual_key_on_only(21); // Snakes


4.0::data.tick => now;
HW.launchpad.virtual_key_off_only(17); // The Hopi way
12.0::data.tick => now;

HW.launchpad.virtual_key_on_only(25); // Pads

8.0::data.tick => now;
HW.launchpad.virtual_key_on_only(24); // Slide

8.0::data.tick => now;

HW.launchpad.virtual_key_on_only(18); // Singer

while(1) {
       100::ms => now;
}
 
