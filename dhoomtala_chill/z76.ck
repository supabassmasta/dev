SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(4 * data.tick , -0.5 * data.tick /* offset */); 

// Off first part
HW.launchpad.virtual_key_on(81); // Bells 1
HW.launchpad.virtual_key_on(82); // Bass 1
HW.launchpad.virtual_key_on(61); // Beat 1
HW.launchpad.virtual_key_on(62); // hh

// OFF 4 ticks
4 * data.tick => now;

// Ragga Kids
HW.launchpad.virtual_key_on(86); // kids
HW.launchpad.virtual_key_on(87); // Bass 3
HW.launchpad.virtual_key_on(66); // Beat ragga
HW.launchpad.virtual_key_on(67); // hh ragga

2 * 16 * data.tick => now;

// OFF Ragga Kids
HW.launchpad.virtual_key_on(86); // kids
HW.launchpad.virtual_key_on(87); // Bass 3
HW.launchpad.virtual_key_on(66); // Beat ragga
HW.launchpad.virtual_key_on(67); // hh ragga

// Bridge with theme 2
HW.launchpad.virtual_key_on(83); // Bells 2
HW.launchpad.virtual_key_on(84); // Bass 2
HW.launchpad.virtual_key_on(63); // Beat 2
HW.launchpad.virtual_key_on(62); // hh 1

1 * data.tick => now;

