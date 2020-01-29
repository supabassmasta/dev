SYNC sy;
sy.sync(8 * data.tick);
//sy.sync(4 * data.tick , -.0 *data.tick /* offset */); 

//LAUNCHPAD_VIRTUAL.off.set(411);
////LAUNCHPAD_VIRTUAL.off.set(412);
//LAUNCHPAD_VIRTUAL.off.set(421);
LAUNCHPAD_VIRTUAL.on.set(631); // slide
LAUNCHPAD_VIRTUAL.on.set(652); // alarm

4* data.tick => now;

LAUNCHPAD_VIRTUAL.kill_page.set(5);

3.5* data.tick => now;

LAUNCHPAD_VIRTUAL.on.set(611);
LAUNCHPAD_VIRTUAL.off.set(631);
.25* data.tick => now;
LAUNCHPAD_VIRTUAL.on.set(621);


while(1) {
       100::ms => now;
}
 

