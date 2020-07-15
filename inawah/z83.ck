SYNC sy;
//sy.sync(4 * data.tick);

HW.launchpad.virtual_key_on_only(87); // Short slide 

1 * data.tick => now;

MASTER_SEQ3.update_ref_times(now - 7*data.tick, data.tick * 16 * 128 );

sy.sync(8 * data.tick , -0.5 * data.tick /* offset */); 

HW.launchpad.virtual_key_on_only(62); //  Break rim shot

2 * data.tick => now;

HW.launchpad.virtual_key_off_only(87); // Short slide 

HW.launchpad.virtual_key_off_only(62); //  Break rim shot

HW.launchpad.virtual_key_off_only(56); // Slide

HW.launchpad.virtual_key_on_only(12); // Kick
HW.launchpad.virtual_key_on_only(52); // rim shot
HW.launchpad.virtual_key_on_only(53); // Big Drum

HW.launchpad.virtual_key_on_only(54); // Leds

.5 * data.tick => now;

HW.launchpad.virtual_key_on_only(71); // Synt
HW.launchpad.virtual_key_on_only(72); // Synt

while(1) {
       10000::ms => now;
}
 

