SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(4 * data.tick , -0.5 * data.tick /* offset */); 

// OFF Dnb theme 1
HW.launchpad.virtual_key_on(81); // Bells 1
HW.launchpad.virtual_key_on(82); // Bass 1
HW.launchpad.virtual_key_on(38); // DnB beat
HW.launchpad.virtual_key_on(37); // hh Drum

// OFF DnB theme 2
//HW.launchpad.virtual_key_on(84); // Bass 2
//HW.launchpad.virtual_key_on(38); // DnB beat
//HW.launchpad.virtual_key_on(37); // hh Drum
//HW.launchpad.virtual_key_on(85); // cocotte
//HW.launchpad.virtual_key_on(83); // Bells 2

// Ragga Kids
HW.launchpad.virtual_key_on(86); // kids
HW.launchpad.virtual_key_on(87); // Bass 3
HW.launchpad.virtual_key_on(66); // Beat ragga
HW.launchpad.virtual_key_on(67); // hh ragga

1 * 16 * data.tick => now;

// OFF Ragga Kids
HW.launchpad.virtual_key_on(86); // kids
HW.launchpad.virtual_key_on(87); // Bass 3
HW.launchpad.virtual_key_on(66); // Beat ragga
HW.launchpad.virtual_key_on(67); // hh ragga

// Bridge with theme 2
HW.launchpad.virtual_key_on(84); // Bass 2
HW.launchpad.virtual_key_on(38); // DnB beat
HW.launchpad.virtual_key_on(37); // hh Drum
HW.launchpad.virtual_key_on(85); // cocotte
HW.launchpad.virtual_key_on(83); // Bells 2

1 * data.tick => now;

