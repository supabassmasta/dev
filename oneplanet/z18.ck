MASTER_SEQ3.update_ref_times(now - 11 * data.tick , data.tick * 16 * 128 );

SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(16 * data.tick , -4.5*data.tick /* offset */); 

//MASTER_SEQ3.update_ref_times(now + .5 * data.tick, data.tick * 16 * 128 );
//MASTER_SEQ3.update_ref_times(now , data.tick * 16 * 128 );




HW.launchpad.virtual_key_on_only(75); 

4 * data.tick => now;

HW.launchpad.virtual_key_off_only(75); 

HW.launchpad.virtual_key_off_only(51); 
HW.launchpad.virtual_key_off_only(52); 
HW.launchpad.virtual_key_off_only(61); 
HW.launchpad.virtual_key_off_only(62); 

HW.launchpad.virtual_key_on_only(11); 
//HW.launchpad.virtual_key_on_only(12);  // BASS 1

HW.launchpad.virtual_key_on_only(21); 

.5 * data.tick => now;


HW.launchpad.virtual_key_on_only(56);  // BASS 
//HW.launchpad.virtual_key_on_only(67);  // BASS 






while(1) {
       100::ms => now;
}
 
