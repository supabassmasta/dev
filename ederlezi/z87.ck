SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(4 * data.tick , -0.5 * data.tick /* offset */); 

HW.launchpad.virtual_key_on(41);
HW.launchpad.virtual_key_on(42);

16 * data.tick => now;

HW.launchpad.virtual_key_on(31);
HW.launchpad.virtual_key_on(32);
HW.launchpad.virtual_key_on(34);
HW.launchpad.virtual_key_on(78);

16 * data.tick => now;
