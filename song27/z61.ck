SYNC sy;
//sy.sync(4 * data.tick);
MASTER_SEQ3.update_ref_times(now - 31*data.tick, data.tick * 16 * 128 );

sy.sync(16 * data.tick , -.5 * data.tick /* offset */); 

LAUNCHPAD_VIRTUAL.on.set(71);

while(1) {
       100::ms => now;
}
 
