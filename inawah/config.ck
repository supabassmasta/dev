// RYTHM
76 => data.bpm;   (60.0/data.bpm)::second => data.tick;
16 => data.meas_size;
// MIX
0.7 => data.master_gain;
// SCALE
"MIN" => data.scale.my_string; // MAJ PENTA_MAJ PENTA_MIN  BLUES  ALL  ADONAI_MALAKH  ALGERIAN  BI_YU AEOLIAN_FLAT_1  CHAD_GADYO   CHAIO CHROMATIC_BEBOP   ESKIMO_HEXATONIC_2   HAWAIIAN   HIRA_JOSHI   HONCHOSHI_PLAGAL_FORM                      
48 => data.ref_note;

// Start synchro
//HW.launchpad.virtual_key_on(7);
//1::ms => now;

HW.ledstrip.open();
HW.ledstrip._load_preset('B');

1::ms => now;

/*
Umma maka tha iwateyah yah yah yah
Inawah teyah yah yah yah
Tonosha umma kayae hé hé hé
Umma maka tha iwateyoh yoh yoh yoh
Inawah teyoh yoh yoh yoh
Tonosha umma kayae hé hé hé
*/

