147 => data.bpm;   (60.0/data.bpm)::second => data.tick;

51 => data.ref_note;

SYNC sy;
//sy.sync(64 * data.tick);
sy.sync(4 * data.tick , - .5 * data.tick /* offset */); 

LAUNCHPAD_VIRTUAL.on.set(1433); // PADS

32 * data.tick => now;

LAUNCHPAD_VIRTUAL.on.set(1431); // Big Precs
LAUNCHPAD_VIRTUAL.on.set(1432); // Slides
LAUNCHPAD_VIRTUAL.on.set(1424); // ABOs

32 * data.tick => now;

LAUNCHPAD_VIRTUAL.off.set(1431); // Big Precs
LAUNCHPAD_VIRTUAL.off.set(1432); // Slides
LAUNCHPAD_VIRTUAL.off.set(1433); // PADS

LAUNCHPAD_VIRTUAL.on.set(1411); // Kick

1 * data.tick => now;

LAUNCHPAD_VIRTUAL.on.set(1421); // BASS

3 * data.tick => now;

LAUNCHPAD_VIRTUAL.on.set(1451); // Mod synt

12 * data.tick => now;

LAUNCHPAD_VIRTUAL.on.set(1412); // hh snr

while(1) {
       100::ms => now;
}
 
