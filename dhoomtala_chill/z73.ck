SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(4 * data.tick , -0.5 * data.tick /* offset */); 

// Off first part
HW.launchpad.virtual_key_on(81); // Bells 1
HW.launchpad.virtual_key_on(82); // Bass 1

// Bridge with theme 2
HW.launchpad.virtual_key_on(83); // Bells 2
HW.launchpad.virtual_key_on(84); // Bass 2


2 * 16 * data.tick => now;

// Off part 2
HW.launchpad.virtual_key_on(83); // Bells 2
HW.launchpad.virtual_key_on(84); // Bass 2

// Re play part 1
HW.launchpad.virtual_key_on(81); // Bells 1
HW.launchpad.virtual_key_on(82); // Bass 1

1 * data.tick => now;

