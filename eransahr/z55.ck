SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 

2 * data.tick => now;

LAUNCHPAD_VIRTUAL.off.set(11);

6.5 * data.tick => now;
LAUNCHPAD_VIRTUAL.on.set(35); // Break
3.0 * data.tick => now;

LAUNCHPAD_VIRTUAL.on.set(16); // Dub
LAUNCHPAD_VIRTUAL.on.set(17);

.5 * data.tick => now;

LAUNCHPAD_VIRTUAL.off.set(35); // Break

while(1) {
       100::ms => now;
}
 
