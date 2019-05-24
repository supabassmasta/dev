SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(4 * data.tick , -0.5 * data.tick /* offset */); 

// Off first part
HW.launchpad.virtual_key_off_only(81); // Bells 1
HW.launchpad.virtual_key_off_only(82); // Bass 1

// Bridge with theme 2
HW.launchpad.virtual_key_on_only(83); // Bells 2
HW.launchpad.virtual_key_on_only(84); // Bass 2


2 * 16 * data.tick => now;

// Off part 2
HW.launchpad.virtual_key_off_only(83); // Bells 2
HW.launchpad.virtual_key_off_only(84); // Bass 2

// Re play part 1
HW.launchpad.virtual_key_on_only(81); // Bells 1
HW.launchpad.virtual_key_on_only(82); // Bass 1

// Let killer terminates
while(1) {
       100::ms => now;
}

