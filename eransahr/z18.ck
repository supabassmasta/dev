SYNC sy;
//sy.sync(8 * data.tick);
sy.sync(4 * data.tick , - 0.5 * data.tick /* offset */); 

2 * data.tick => now;

// Off dub
LAUNCHPAD_VIRTUAL.off.set(13);
LAUNCHPAD_VIRTUAL.off.set(14);

// On flute effects
LAUNCHPAD_VIRTUAL.on.set(68); // Rev
//LAUNCHPAD_VIRTUAL.on.set(58); // echo

LAUNCHPAD_VIRTUAL.on.set(34); // break

2 * data.tick => now;


// Slow beat
LAUNCHPAD_VIRTUAL.on.set(31);

1 * data.tick => now;

LAUNCHPAD_VIRTUAL.off.set(34); // break

15 * data.tick => now;
LAUNCHPAD_VIRTUAL.on.set(32); // HH

(3 * 16 - 2) * data.tick => now;
LAUNCHPAD_VIRTUAL.off.set(31); // slow beat
LAUNCHPAD_VIRTUAL.off.set(32); // HH

LAUNCHPAD_VIRTUAL.on.set(34); // break
LAUNCHPAD_VIRTUAL.on.set(44); // slide
2 * data.tick => now;

LAUNCHPAD_VIRTUAL.on.set(51); // High beat

// Off flute effects
LAUNCHPAD_VIRTUAL.off.set(68); // rev
//LAUNCHPAD_VIRTUAL.off.set(58);

2 * data.tick => now;
LAUNCHPAD_VIRTUAL.off.set(34); // break
LAUNCHPAD_VIRTUAL.off.set(44); // slide

while(1) {
       100::ms => now;
}
 
