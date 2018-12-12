// RYTHM
126.81 => data.bpm;   (60.0/data.bpm)::second => data.tick;
16 => data.meas_size;
// SCALE
"MIN" => data.scale.my_string; // MAJ PENTA_MAJ PENTA_MIN  BLUES  ALL  ADONAI_MALAKH  ALGERIAN  BI_YU AEOLIAN_FLAT_1  CHAD_GADYO   CHAIO CHROMATIC_BEBOP   ESKIMO_HEXATONIC_2   HAWAIIAN   HIRA_JOSHI   HONCHOSHI_PLAGAL_FORM                      
53 => data.ref_note;

// Start synchro
HW.launchpad.virtual_key_on(7);

HW.ledstrip.open();
HW.ledstrip._load_preset('6');

1::ms => now;

//fa fa# la sib do re#
//fa mixolydian

// 8 * 1 fa fa# then 8*2 fa do


// faire des syren et de echo pour la parti dub take your time
