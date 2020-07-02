SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 

1.5 * data.tick => now;

LAUNCHPAD_VIRTUAL.off.set(61);

.5 * data.tick => now;

LAUNCHPAD_VIRTUAL.off.set(16);
LAUNCHPAD_VIRTUAL.off.set(17);
LAUNCHPAD_VIRTUAL.off.set(18);
LAUNCHPAD_VIRTUAL.off.set(26);
LAUNCHPAD_VIRTUAL.off.set(27);


1.5 * data.tick => now;

LAUNCHPAD_VIRTUAL.on.set(16);
.5 * data.tick => now;
LAUNCHPAD_VIRTUAL.on.set(17);
LAUNCHPAD_VIRTUAL.on.set(18);
LAUNCHPAD_VIRTUAL.on.set(26);
LAUNCHPAD_VIRTUAL.on.set(27);

LAUNCHPAD_VIRTUAL.on.set(61);

while(1) {
       100::ms => now;
}
 
