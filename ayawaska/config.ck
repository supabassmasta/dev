// RYTHM
115 => data.bpm;   (60.0/data.bpm)::second => data.tick;
16 => data.meas_size;
// SCALE
"MIN" => data.scale.my_string; // MAJ PENTA_MAJ PENTA_MIN  BLUES  ALL  ADONAI_MALAKH  ALGERIAN  BI_YU AEOLIAN_FLAT_1  CHAD_GADYO   CHAIO CHROMATIC_BEBOP   ESKIMO_HEXATONIC_2   HAWAIIAN   HIRA_JOSHI   HONCHOSHI_PLAGAL_FORM                      
55 => data.ref_note;

// Start synchro
HW.launchpad.virtual_key_on(7);

// Start forest
HW.launchpad.virtual_key_on(31);


HW.ledstrip.open();
HW.ledstrip._load_preset('2');

1::ms => now;
