SYNC sy;
sy.sync(32 * data.tick, - 16.25 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 


while(1) {

  LAUNCHPAD_VIRTUAL.on.set(1456); // Break Slide
  
  8 * data.tick => now;
  
  LAUNCHPAD_VIRTUAL.off.set(1411); // Kick
  LAUNCHPAD_VIRTUAL.off.set(1412); // hh snr
  LAUNCHPAD_VIRTUAL.off.set(1421); // BASS

  LAUNCHPAD_VIRTUAL.on.set(1455); // Break beat
  LAUNCHPAD_VIRTUAL.on.set(1458); // Percs
  LAUNCHPAD_VIRTUAL.on.set(1465); // Abos
  LAUNCHPAD_VIRTUAL.on.set(1457); // PADS
  
  8 * data.tick => now;

  LAUNCHPAD_VIRTUAL.on.set(1411); // Kick
  LAUNCHPAD_VIRTUAL.on.set(1412); // hh snr
  LAUNCHPAD_VIRTUAL.on.set(1421); // BASS

  LAUNCHPAD_VIRTUAL.off.set(1455); // Break beat
  LAUNCHPAD_VIRTUAL.off.set(1456); // Break Slide
  LAUNCHPAD_VIRTUAL.off.set(1457); // PADS
  LAUNCHPAD_VIRTUAL.off.set(1458); // Percs
  LAUNCHPAD_VIRTUAL.off.set(1465); // Abos

  3 * 16 * data.tick => now;
}
 
