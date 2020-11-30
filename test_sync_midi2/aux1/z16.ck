MIDI_CLOCK_TRACKER mct;
mct.go("Midi Through Port-0" /* device */, 4 * 24 * 4 /* midi_clock_interval_update */, 6::ms /* experimental_offset */);

while(1) {
       100::ms => now;
}
 

