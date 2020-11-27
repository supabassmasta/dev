ST st;

STEPC stepc; stepc.init(HW.lpd8.potar[1][1], 0.05 /* min */, 3 /* max */, 50::ms /* transition_dur */);
stepc.out => Phasor p => Wavetable w => SinOsc sin0 =>  st.mono_in;
  1 => w.sync;
  0 => w.interpolate;
//10.0 => sin0.freq;
0.1 => sin0.gain;

47 + 1 *12 => int base; // C -1
   //  Std.mtof(base + 3), // D
   //  Std.mtof(base + 4), // D#
   //  Std.mtof(base + 7), // G
   //  Std.mtof(base + 9), // A
   //  Std.mtof(base + 10), // A#
   //  
   //  Std.mtof(base - 12 + 3), // D
   //  Std.mtof(base - 12 + 4), // D#
   //  Std.mtof(base - 12 + 7), // G
   //  Std.mtof(base - 12 + 9), // A
   //  Std.mtof(base - 12 + 10) // A#
[
Std.mtof(base + 7), // G
Std.mtof(base + 9), // A
Std.mtof(base + 7), // G
Std.mtof(base + 9), // A
Std.mtof(base + 3), // D
Std.mtof(base + 7), // G
Std.mtof(base + 9), // A
Std.mtof(base + 3), // D
Std.mtof(base + 3), // D
Std.mtof(base + 4), // D#
Std.mtof(base + 10), // A#
Std.mtof(base + 4), // D#
Std.mtof(base + 10), // A#
Std.mtof(base + 7), // G
Std.mtof(base + 9), // A
Std.mtof(base + 4), // D#
Std.mtof(base + 3), // D
Std.mtof(base - 12 + 10), // A#
Std.mtof(base - 12 + 9), // A
Std.mtof(base - 12 + 4), // D#
Std.mtof(base - 12 + 7), // G
Std.mtof(base - 12 + 3), // D
Std.mtof(base - 12 + 4), // D#
Std.mtof(base - 12 + 7), // G
Std.mtof(base - 12 + 3), // D
Std.mtof(base - 12 + 10) // A#
] @=> float myTable[];

w.setTable (myTable);



while(1) {
       100::ms => now;
}
 
