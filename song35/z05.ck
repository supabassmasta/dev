MIDI_BPM_TRACKER mbt;
mbt.go("Scarlett 2i4 USB MIDI 1" /* device */, 1 * 24  /* midi_clock_interval_update */,  2 * 24  /* bpm_interval_update */,-1 * 192::ms  /* experimental_offset */, 0 /* BPM TRACK enable */);

while(1) {
       100::ms => now;
}
 

