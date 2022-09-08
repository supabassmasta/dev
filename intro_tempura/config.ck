// RYTHM
88 => data.bpm;   (60.0/data.bpm)::second => data.tick;
16 => data.meas_size;
// SCALE
"MIN" => data.scale.my_string; // MAJ PENTA_MAJ PENTA_MIN  BLUES  ALL  ADONAI_MALAKH  ALGERIAN  BI_YU AEOLIAN_FLAT_1  CHAD_GADYO   CHAIO CHROMATIC_BEBOP   ESKIMO_HEXATONIC_2   HAWAIIAN   HIRA_JOSHI   HONCHOSHI_PLAGAL_FORM                      
48 => data.ref_note;

1.1 => data.master_gain;

// D#/G     //    Bb/B - C/B

// Start ECHO
HW.launchpad.virtual_key_on(38);
//HW.launchpad.virtual_key_on(48); // REV

HW.ledstrip.open();
HW.ledstrip._load_preset('&');

3::ms => now;
