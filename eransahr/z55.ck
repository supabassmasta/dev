SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 

3 * data.tick => now;

LAUNCHPAD_VIRTUAL.off.set(11);

4 * data.tick => now;

LAUNCHPAD_VIRTUAL.on.set(16);
LAUNCHPAD_VIRTUAL.on.set(17);


while(1) {
       100::ms => now;
}
 
