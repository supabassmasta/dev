SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(4 * data.tick , -0.5 * data.tick /* offset */); 

HW.launchpad.virtual_key_on_only(41); // Girls
HW.launchpad.virtual_key_on_only(42); // Slide
HW.launchpad.virtual_key_on_only(43); // Horse

16 * data.tick => now;

HW.launchpad.virtual_key_on_only(21); // KICK HARD
HW.launchpad.virtual_key_on_only(31); // KICK
HW.launchpad.virtual_key_on_only(37); // HH SNARE
HW.launchpad.virtual_key_on_only(32); // HH SNARE Trigger toggle ARDSRC
HW.launchpad.virtual_key_on_only(34); // BASS

HW.launchpad.virtual_key_off_only(43);

4 * data.tick => now;

HW.launchpad.virtual_key_off_only(41);
HW.launchpad.virtual_key_off_only(42);

1 * data.tick => now;
