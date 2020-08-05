SYNC sy;
sy.sync(32 * data.tick, - 8.25 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 



  LAUNCHPAD_VIRTUAL.on.set(56); // Break Slide
  
  8 * data.tick => now;
  
  LAUNCHPAD_VIRTUAL.off.set(56); // Break Slide

  LAUNCHPAD_VIRTUAL.off.set(11); // Kick
  LAUNCHPAD_VIRTUAL.off.set(12); // hh snr
  LAUNCHPAD_VIRTUAL.off.set(21); // BASS

  LAUNCHPAD_VIRTUAL.on.set(72); //Kick HPF 
  LAUNCHPAD_VIRTUAL.on.set(73); // BASS HPF
  LAUNCHPAD_VIRTUAL.on.set(75); // PADS
  
  30 * data.tick => now;
  LAUNCHPAD_VIRTUAL.off.set(72); //Kick HPF 
  LAUNCHPAD_VIRTUAL.off.set(73); // BASS HPF
  LAUNCHPAD_VIRTUAL.off.set(75); // PADS
  2 * data.tick => now;

  LAUNCHPAD_VIRTUAL.on.set(11); // Kick
  LAUNCHPAD_VIRTUAL.on.set(21); // BASS

  1 * data.tick => now;

  LAUNCHPAD_VIRTUAL.on.set(12); // hh snr

while(1) {
10::ms => now;
}
 
