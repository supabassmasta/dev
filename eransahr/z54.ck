SYNC sy;
//sy.sync(8 * data.tick);
sy.sync(8 * data.tick , - 0.5 * data.tick /* offset */); 

// Off dub
LAUNCHPAD_VIRTUAL.off.set(16);
LAUNCHPAD_VIRTUAL.off.set(17);

// On flute effects
LAUNCHPAD_VIRTUAL.on.set(38);
LAUNCHPAD_VIRTUAL.on.set(48);

// Slow beat
LAUNCHPAD_VIRTUAL.on.set(31);

16 * data.tick => now;
LAUNCHPAD_VIRTUAL.on.set(32); // HH

3 * 16 * data.tick => now;
LAUNCHPAD_VIRTUAL.off.set(31); // slow beat
LAUNCHPAD_VIRTUAL.off.set(32); // HH

LAUNCHPAD_VIRTUAL.on.set(11); // High beat

// Off flute effects
LAUNCHPAD_VIRTUAL.off.set(38);
LAUNCHPAD_VIRTUAL.off.set(48);


while(1) {
       100::ms => now;
}
 
