SYNC sy;
sy.sync(32 * data.tick, - 16.25 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 


while(1) {

  LAUNCHPAD_VIRTUAL.on.set(56); // Break Slide
  
  8 * data.tick => now;
  
  LAUNCHPAD_VIRTUAL.off.set(11); // Kick
  LAUNCHPAD_VIRTUAL.off.set(12); // hh snr
  LAUNCHPAD_VIRTUAL.off.set(21); // BASS

  LAUNCHPAD_VIRTUAL.on.set(55); // Break beat
  LAUNCHPAD_VIRTUAL.on.set(58); // Percs
  LAUNCHPAD_VIRTUAL.on.set(65); // Abos
  LAUNCHPAD_VIRTUAL.on.set(57); // PADS
  
  8 * data.tick => now;

  LAUNCHPAD_VIRTUAL.on.set(11); // Kick
  LAUNCHPAD_VIRTUAL.on.set(12); // hh snr
  LAUNCHPAD_VIRTUAL.on.set(21); // BASS

  LAUNCHPAD_VIRTUAL.off.set(55); // Break beat
  LAUNCHPAD_VIRTUAL.off.set(56); // Break Slide
  LAUNCHPAD_VIRTUAL.off.set(57); // PADS
  LAUNCHPAD_VIRTUAL.off.set(58); // Percs
  LAUNCHPAD_VIRTUAL.off.set(65); // Abos

  3 * 16 * data.tick => now;
}
 
