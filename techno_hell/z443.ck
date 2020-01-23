SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(8 * data.tick , -4.0 *data.tick /* offset */); 
//sy.sync(4 * data.tick , -.0 *data.tick /* offset */); 
LAUNCHPAD_VIRTUAL.on.set(431);
8 * data.tick => now;
LAUNCHPAD_VIRTUAL.off.set(431);



LAUNCHPAD_VIRTUAL.off.set(411);
LAUNCHPAD_VIRTUAL.off.set(412);
LAUNCHPAD_VIRTUAL.off.set(421);


1.5* data.tick => now;
LAUNCHPAD_VIRTUAL.on.set(434);
2 * data.tick => now;
LAUNCHPAD_VIRTUAL.off.set(434);

LAUNCHPAD_VIRTUAL.on.set(411);
.25* data.tick => now;
LAUNCHPAD_VIRTUAL.on.set(412);
LAUNCHPAD_VIRTUAL.on.set(421);


while(1) {
       100::ms => now;
}
 

