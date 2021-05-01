// VIRTUAL LAUNCHER
//LAUNCHPAD_VIRTUAL.on.set(0);
//LAUNCHPAD_VIRTUAL.off.set(0);


MASTER_SEQ3.update_ref_times(now - 15 * data.tick , data.tick * 16 * 128 );

SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(16 * data.tick , 0.0*data.tick /* offset */); 

LAUNCHPAD_VIRTUAL.on.set(21); // BASS
LAUNCHPAD_VIRTUAL.on.set(32); // PLOC


4 * data.tick => now;
LAUNCHPAD_VIRTUAL.on.set(11); // Percs Echo

8 * data.tick => now;
LAUNCHPAD_VIRTUAL.off.set(11); // Percs Echo

4 * data.tick => now;
LAUNCHPAD_VIRTUAL.on.set(12); // Percs Echo

8 * data.tick => now;
LAUNCHPAD_VIRTUAL.off.set(12); // Percs Echo

7 * data.tick => now;
LAUNCHPAD_VIRTUAL.on.set(48); // Trip hop

while(1) {
    4 * data.tick => now;
}
 
