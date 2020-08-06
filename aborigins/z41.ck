
NOREPLACE no;


MASTER_SEQ3.update_ref_times(now - 30*data.tick, data.tick * 16 * 128 );

SYNC sy;
//sy.sync(64 * data.tick);
sy.sync(4 * data.tick , - .5 * data.tick /* offset */); 

LAUNCHPAD_VIRTUAL.on.set(33); // PADS

32 * data.tick => now;

LAUNCHPAD_VIRTUAL.on.set(31); // Big Precs
LAUNCHPAD_VIRTUAL.on.set(32); // Slides
//LAUNCHPAD_VIRTUAL.on.set(24); // ABOs
LAUNCHPAD_VIRTUAL.on.set(23); // ABOs

32 * data.tick => now;

LAUNCHPAD_VIRTUAL.off.set(31); // Big Precs
LAUNCHPAD_VIRTUAL.off.set(32); // Slides
LAUNCHPAD_VIRTUAL.off.set(33); // PADS

LAUNCHPAD_VIRTUAL.on.set(11); // Kick

//0.5 * data.tick => now;

LAUNCHPAD_VIRTUAL.on.set(21); // BASS

4 * data.tick => now;

LAUNCHPAD_VIRTUAL.on.set(45); // Mod synt

LAUNCHPAD_VIRTUAL.off.set(23); // ABOs

12 * data.tick => now;

LAUNCHPAD_VIRTUAL.on.set(12); // hh snr

while(1) {
       100::ms => now;
}
 
