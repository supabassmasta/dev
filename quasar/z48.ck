

SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(8 * data.tick , - .5*data.tick /* offset */); 



HW.launchpad.virtual_key_on_only(67);  // PAD 1
HW.launchpad.virtual_key_on_only(68);  // PAD 2

8 * data.tick => now;

HW.launchpad.virtual_key_on_only(66); // Soapy synt

16 * data.tick => now;

HW.launchpad.virtual_key_on_only(76); // Glitchs

8 * data.tick => now;

HW.launchpad.virtual_key_on_only(87); // Slide

8 * data.tick => now;

HW.launchpad.virtual_key_off_only(87); // Slide

HW.launchpad.virtual_key_on_only(77); 
HW.launchpad.virtual_key_on_only(78); 

16 * data.tick => now;
// HW.launchpad.virtual_key_on_only(65); // SINGER

while(1) {
       10000::ms => now;
}
 

