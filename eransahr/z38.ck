SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 

1.5 * data.tick => now;

LAUNCHPAD_VIRTUAL.off.set(15);

.5 * data.tick => now;

LAUNCHPAD_VIRTUAL.off.set(13);
LAUNCHPAD_VIRTUAL.off.set(14);


1.5 * data.tick => now;

LAUNCHPAD_VIRTUAL.on.set(13);
.5 * data.tick => now;
LAUNCHPAD_VIRTUAL.on.set(14);

LAUNCHPAD_VIRTUAL.on.set(15);

LAUNCHPAD_VIRTUAL.on.set(16); // NAP

while(1) {
       100::ms => now;
}
 
