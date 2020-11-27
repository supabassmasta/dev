MIDI_CLOCK_TRACKER mct;
mct.go("Scarlett 2i4 USB MIDI 1" /* device */, 1 * 24 * 4 /* midi_clock_interval_update */, 6::ms /* experimental_offset */);

while(1) {
       100::ms => now;
}
 

