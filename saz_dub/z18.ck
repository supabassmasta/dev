
SYNC sy;
//sy.sync(64 * data.tick);
sy.sync(32 * data.tick , -4.5 * data.tick /* offset */); 

LAUNCHPAD_VIRTUAL.on.set(12); // Echo percs
LAUNCHPAD_VIRTUAL.on.set(41); // Flanger Bass

4 * data.tick => now;
while(1) {

  LAUNCHPAD_VIRTUAL.off.set(12); // Echo percs
  LAUNCHPAD_VIRTUAL.on.set(15); // Kick slow
  LAUNCHPAD_VIRTUAL.on.set(16); // Snare
  LAUNCHPAD_VIRTUAL.on.set(13); // Clics
  LAUNCHPAD_VIRTUAL.on.set(31); // niap
  LAUNCHPAD_VIRTUAL.on.set(35); // Voices
  LAUNCHPAD_VIRTUAL.on.set(42); // Slide

  4 => int i;
  while(i) {
    14::data.tick => now;
    LAUNCHPAD_VIRTUAL.on.set(12); // Echo percs
    2::data.tick => now;
    LAUNCHPAD_VIRTUAL.off.set(12); // Echo percs

    14::data.tick => now;
    LAUNCHPAD_VIRTUAL.on.set(23); // Echo Darbouka
    2::data.tick => now;
    LAUNCHPAD_VIRTUAL.off.set(23); // Darbouk

    1 -=> i;
  }

  LAUNCHPAD_VIRTUAL.off.set(15); // Kick slow
  LAUNCHPAD_VIRTUAL.off.set(13); // Clics
  LAUNCHPAD_VIRTUAL.off.set(41); // Flanger Bass
  LAUNCHPAD_VIRTUAL.on.set(11); // Kick 
  LAUNCHPAD_VIRTUAL.on.set(14); // HH
  LAUNCHPAD_VIRTUAL.on.set(24); // BASS
  4 =>  i;
  while(i) {
    7::data.tick => now;
    LAUNCHPAD_VIRTUAL.on.set(12); // Echo percs
    1::data.tick => now;
    LAUNCHPAD_VIRTUAL.off.set(12); // Echo percs

    7::data.tick => now;
    LAUNCHPAD_VIRTUAL.on.set(23); // Darbouka
    1::data.tick => now;
    LAUNCHPAD_VIRTUAL.off.set(23); // Darbouk

    1 -=> i;
  }

  LAUNCHPAD_VIRTUAL.on.set(22); // Darbouka
  60 * data.tick => now;

  LAUNCHPAD_VIRTUAL.off.set(11); // Kick 
  LAUNCHPAD_VIRTUAL.off.set(14); // HH
  LAUNCHPAD_VIRTUAL.off.set(24); // BASS

  LAUNCHPAD_VIRTUAL.on.set(13); // Clics
  LAUNCHPAD_VIRTUAL.on.set(41); // Flanger Bass

  LAUNCHPAD_VIRTUAL.off.set(22); // Darbouka

  LAUNCHPAD_VIRTUAL.on.set(23); // Darbouka
  2 * data.tick => now;
  LAUNCHPAD_VIRTUAL.off.set(23); // Darbouka
  2 * data.tick => now;

}


