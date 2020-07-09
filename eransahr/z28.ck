SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 

2 * data.tick => now;

LAUNCHPAD_VIRTUAL.off.set(51); // High beat

6.5 * data.tick => now;
LAUNCHPAD_VIRTUAL.on.set(35); // Break
3.0 * data.tick => now;

LAUNCHPAD_VIRTUAL.on.set(13); // Dub
LAUNCHPAD_VIRTUAL.on.set(14);

.5 * data.tick => now;

LAUNCHPAD_VIRTUAL.off.set(35); // Break

while(1) {
       100::ms => now;
}
 
