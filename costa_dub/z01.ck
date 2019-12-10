MASTER_SEQ3.update_ref_times(now - 15 * data.tick , data.tick * 16 * 128 );

SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(16 * data.tick , -0.5*data.tick /* offset */); 

<<<"SYNC">>>;


HW.launchpad.virtual_key_on_only(12);

16 * data.tick => now;

HW.launchpad.virtual_key_on_only(15);
HW.launchpad.virtual_key_on_only(16);

16 * data.tick => now;

HW.launchpad.virtual_key_on_only(13);

16 * data.tick => now;

HW.launchpad.virtual_key_on_only(14);

while(1) {
       100::ms => now;
}
 
