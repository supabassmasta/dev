SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(8 * data.tick , - .5*data.tick /* offset */); 

HW.launchpad.virtual_key_off_only(24); // Beat Dub
HW.launchpad.virtual_key_off_only(25); // Niap
HW.launchpad.virtual_key_off_only(26); // BASS
HW.launchpad.virtual_key_off_only(27); // Big Kick
HW.launchpad.virtual_key_off_only(13); // HH

HW.launchpad.virtual_key_on_only(53);  // Slide
HW.launchpad.virtual_key_on_only(57); // Kick
HW.launchpad.virtual_key_on_only(76); // blips
HW.launchpad.virtual_key_on_only(44); // Slide BAss END

HW.launchpad.virtual_key_on_only(72); // SNR echo

4 * data.tick => now;

HW.launchpad.virtual_key_off_only(35); // ECHO ARP
HW.launchpad.virtual_key_off_only(76); // Glitch

4 * data.tick => now;

HW.launchpad.virtual_key_off_only(53);  // Slide
HW.launchpad.virtual_key_off_only(57); // Kick
HW.launchpad.virtual_key_off_only(76); // blips
HW.launchpad.virtual_key_off_only(44); // Slide BAss END

4 * data.tick => now;

HW.launchpad.virtual_key_off_only(72); // SNR echo

while(1) {
       10000::ms => now;
}

