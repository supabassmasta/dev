SYNC sy;
//sy.sync(8 * data.tick);
sy.sync(32 * data.tick , -8.5 *data.tick /* offset */); 

LAUNCHPAD_VIRTUAL.on.set(731); // slide


4* data.tick => now;
LAUNCHPAD_VIRTUAL.on.set(732); // Break

LAUNCHPAD_VIRTUAL.off.set(711); // kick 
LAUNCHPAD_VIRTUAL.off.set(738); // Frogs
LAUNCHPAD_VIRTUAL.off.set(771); // Noizy slide
LAUNCHPAD_VIRTUAL.off.set(772); // Noizy slide
LAUNCHPAD_VIRTUAL.off.set(788); // Glitchy scratch




4* data.tick => now;

LAUNCHPAD_VIRTUAL.off.set(731);  // slide

LAUNCHPAD_VIRTUAL.on.set(711); // kick 
LAUNCHPAD_VIRTUAL.on.set(712); // hh snr
LAUNCHPAD_VIRTUAL.on.set(721); // Bass

LAUNCHPAD_VIRTUAL.on.set(718);  
LAUNCHPAD_VIRTUAL.on.set(728);  
LAUNCHPAD_VIRTUAL.on.set(738);  
LAUNCHPAD_VIRTUAL.on.set(748);  

.5 * data.tick => now;
LAUNCHPAD_VIRTUAL.off.set(732); // Break

//.25* data.tick => now;
//LAUNCHPAD_VIRTUAL.on.set(721);


while(1) {
       100::ms => now;
}
 

