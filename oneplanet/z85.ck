SYNC sy;
//sy.sync(4 * data.tick);
//sy.sync(16 * data.tick , - 4.5*data.tick /* offset */); 
sy.sync(4 * data.tick , - .5*data.tick /* offset */); 

HW.launchpad.virtual_key_off_only(11); 
HW.launchpad.virtual_key_off_only(12); 

HW.launchpad.virtual_key_on_only(28); 

4 * data.tick => now;


HW.launchpad.virtual_key_on_only(11); 
HW.launchpad.virtual_key_on_only(12); 

.45 * data.tick => now;

HW.launchpad.virtual_key_off_only(28); 


while(1) {
       100::ms => now;
}
 
