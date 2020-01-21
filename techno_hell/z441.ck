SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(4 * data.tick , -.0 *data.tick /* offset */); 

LAUNCHPAD_VIRTUAL.off.set(411);
LAUNCHPAD_VIRTUAL.off.set(412);
LAUNCHPAD_VIRTUAL.off.set(421);


3.5* data.tick => now;

LAUNCHPAD_VIRTUAL.on.set(411);
.25* data.tick => now;
LAUNCHPAD_VIRTUAL.on.set(421);


while(1) {
       100::ms => now;
}
 

