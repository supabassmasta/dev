SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(4 * data.tick , -0.5 * data.tick /* offset */); 

// OFF DnB theme 2
HW.launchpad.virtual_key_off_only(84); // Bass 2
HW.launchpad.virtual_key_off_only(38); // DnB beat
HW.launchpad.virtual_key_off_only(37); // hh Drum
HW.launchpad.virtual_key_off_only(85); // cocotte
HW.launchpad.virtual_key_off_only(83); // Bells 2

// Ragga Kids
HW.launchpad.virtual_key_on_only(86); // kids
HW.launchpad.virtual_key_on_only(87); // Bass 3
HW.launchpad.virtual_key_on_only(66); // Beat ragga
HW.launchpad.virtual_key_on_only(67); // hh ragga

1 * 16 * data.tick => now;

// OFF Ragga Kids
HW.launchpad.virtual_key_off_only(86); // kids
HW.launchpad.virtual_key_off_only(87); // Bass 3
HW.launchpad.virtual_key_off_only(66); // Beat ragga
HW.launchpad.virtual_key_off_only(67); // hh ragga

// STEPPA
HW.launchpad.virtual_key_on_only(36); // Steppa
HW.launchpad.virtual_key_on_only(37); // hh Drum
HW.launchpad.virtual_key_on_only(26); // Slide

8 * data.tick => now;
HW.launchpad.virtual_key_off_only(26); //  OFF Slide
16 * data.tick => now;
HW.launchpad.virtual_key_on_only(81); // Bells 1

1 * data.tick => now;
