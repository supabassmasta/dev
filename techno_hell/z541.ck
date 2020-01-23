SYNC sy;
sy.sync(8 * data.tick);
//sy.sync(4 * data.tick , -.0 *data.tick /* offset */); 

//LAUNCHPAD_VIRTUAL.off.set(411);
////LAUNCHPAD_VIRTUAL.off.set(412);
//LAUNCHPAD_VIRTUAL.off.set(421);
LAUNCHPAD_VIRTUAL.on.set(531);

4* data.tick => now;

LAUNCHPAD_VIRTUAL.kill_page.set(4);

3.5* data.tick => now;

LAUNCHPAD_VIRTUAL.on.set(511);
LAUNCHPAD_VIRTUAL.off.set(531);
.25* data.tick => now;
LAUNCHPAD_VIRTUAL.on.set(521);


while(1) {
       100::ms => now;
}
 

