SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(4 * data.tick , -.0 *data.tick /* offset */); 

LAUNCHPAD_VIRTUAL.off.set(311);
LAUNCHPAD_VIRTUAL.off.set(312);
LAUNCHPAD_VIRTUAL.off.set(313);
LAUNCHPAD_VIRTUAL.off.set(321);

LAUNCHPAD_VIRTUAL.on.set(331); // flute

3.5* data.tick => now;

LAUNCHPAD_VIRTUAL.off.set(331); // flute

LAUNCHPAD_VIRTUAL.on.set(311);
.25* data.tick => now;
LAUNCHPAD_VIRTUAL.on.set(321);

LAUNCHPAD_VIRTUAL.on.set(312);
LAUNCHPAD_VIRTUAL.on.set(313);

while(1) {
       100::ms => now;
}
 

