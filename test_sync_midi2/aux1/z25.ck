MIDI_BPM_TRACKER mbt;
mbt.go("Midi Through Port-0" /* device */, 1 * 24  /* midi_clock_interval_update */,  2 * 24  /* bpm_interval_update */, 6::ms /* experimental_offset */, 0 /* BPM TRACK enable */);

while(1) {
       100::ms => now;
}
 

