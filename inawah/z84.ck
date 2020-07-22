SYNC sy;
sy.sync(8 * data.tick, -0.5 * data.tick /* offset */);


HW.launchpad.virtual_key_off_only(71); // Synt
HW.launchpad.virtual_key_off_only(72); 

HW.launchpad.virtual_key_on_only(75); // Synt transition
HW.launchpad.virtual_key_on_only(76); 

9 * data.tick => now;

HW.launchpad.virtual_key_off_only(12); // Kick
HW.launchpad.virtual_key_off_only(52); // rim shot
HW.launchpad.virtual_key_off_only(53); // Big Drum

HW.launchpad.virtual_key_off_only(54); // Leds

HW.launchpad.virtual_key_off_only(75); // Synt transition
HW.launchpad.virtual_key_off_only(76); // Synt transition


HW.launchpad.virtual_key_on_only(65); // Thunder

8 * data.tick => now;

HW.launchpad.virtual_key_off_only(65); // Thunder

while(1) {
       10000::ms => now;
}
 

