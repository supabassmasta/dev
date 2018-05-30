SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(4 * data.tick , -0.5 * data.tick /* offset */); 

HW.launchpad.virtual_key_on(41);
HW.launchpad.virtual_key_on(42);

16 * data.tick => now;

HW.launchpad.virtual_key_on(21); // KICK HARD
HW.launchpad.virtual_key_on(31); // KICK
HW.launchpad.virtual_key_on(32); // HH SNARE
HW.launchpad.virtual_key_on(34); // BASS
//HW.launchpad.virtual_key_on(78); // SYNT CHASS

4 * data.tick => now;

HW.launchpad.virtual_key_on(41);
HW.launchpad.virtual_key_on(42);

