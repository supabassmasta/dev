SYNC sy;
sy.sync(4 * data.tick);


HW.launchpad.virtual_key_on_only(62); //  Break rim shot

2 * data.tick => now;

HW.launchpad.virtual_key_off_only(87); // Short slide 

HW.launchpad.virtual_key_off_only(62); //  Break rim shot

HW.launchpad.virtual_key_off_only(56); // Slide

HW.launchpad.virtual_key_on_only(12); // Kick
HW.launchpad.virtual_key_on_only(52); // rim shot
HW.launchpad.virtual_key_on_only(53); // Big Drum

HW.launchpad.virtual_key_on_only(54); // Leds

HW.launchpad.virtual_key_on_only(71); // Synt
HW.launchpad.virtual_key_on_only(72); // Synt

while(1) {
       10000::ms => now;
}
 

