SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(4 * data.tick , -0.5 * data.tick /* offset */); 

HW.launchpad.virtual_key_on(81); // Bells 1

16 * data.tick => now;

HW.launchpad.virtual_key_on(82); // Bass 1

16 * data.tick => now;

HW.launchpad.virtual_key_on(61); // Beat 1
1 * data.tick => now;

HW.launchpad.virtual_key_on(62); // hh

1 * data.tick => now;

