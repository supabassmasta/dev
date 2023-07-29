// RYTHM
88 => data.bpm;   (60.0/data.bpm)::second => data.tick;
16 => data.meas_size;
// SCALE
"MIN" => data.scale.my_string; // MAJ PENTA_MAJ PENTA_MIN  BLUES  ALL  ADONAI_MALAKH  ALGERIAN  BI_YU AEOLIAN_FLAT_1  CHAD_GADYO   CHAIO CHROMATIC_BEBOP   ESKIMO_HEXATONIC_2   HAWAIIAN   HIRA_JOSHI   HONCHOSHI_PLAGAL_FORM                      
48 => data.ref_note;

1.6 => data.master_gain;

// Start synchro
HW.launchpad.virtual_key_on(7);
// ECHO
HW.launchpad.virtual_key_on(58);

HW.ledstrip.open();
HW.ledstrip._load_preset('3');

1::ms => now;


// D#/G     //    Bb/B - C/B

// START: 2 kid samples

// END : kid 1_1_1_1_11 *2 11 There



