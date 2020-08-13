NOREPLACE no;

SYNC sy;
sy.sync(32 * data.tick, - 24.25 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 


while(1) {

  LAUNCHPAD_VIRTUAL.on.set(56); // Break Slide
  
  8 * data.tick => now;
  
  LAUNCHPAD_VIRTUAL.off.set(11); // Kick
  LAUNCHPAD_VIRTUAL.off.set(12); // hh snr
  LAUNCHPAD_VIRTUAL.off.set(21); // BASS

  LAUNCHPAD_VIRTUAL.on.set(54); // Break beat
  LAUNCHPAD_VIRTUAL.on.set(58); // Percs
  LAUNCHPAD_VIRTUAL.on.set(66); // Abos
  LAUNCHPAD_VIRTUAL.on.set(57); // PADS
  
  4 * data.tick => now;
  LAUNCHPAD_VIRTUAL.off.set(54); // Break beat
  4 * data.tick => now;
  LAUNCHPAD_VIRTUAL.off.set(56); // Break Slide
  LAUNCHPAD_VIRTUAL.off.set(58); // Percs
  LAUNCHPAD_VIRTUAL.off.set(66); // Abos
  4 * data.tick => now;
  LAUNCHPAD_VIRTUAL.on.set(54); // Break beat
  4 * data.tick => now;
  LAUNCHPAD_VIRTUAL.off.set(54); // Break beat
  LAUNCHPAD_VIRTUAL.off.set(57); // PADS

  LAUNCHPAD_VIRTUAL.on.set(11); // Kick
  LAUNCHPAD_VIRTUAL.on.set(12); // hh snr
  LAUNCHPAD_VIRTUAL.on.set(21); // BASS


  (3 * 16 - 8) * data.tick => now;
}
 
