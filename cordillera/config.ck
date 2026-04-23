// RYTHM
132 => data.bpm;   (60.0/data.bpm)::second => data.tick;
16 => data.meas_size;
// MIX
1. => data.master_gain;
// SCALE
"MIN" => data.scale.my_string; // MAJ PENTA_MAJ PENTA_MIN  BLUES  ALL  ADONAI_MALAKH  ALGERIAN  BI_YU AEOLIAN_FLAT_1  CHAD_GADYO   CHAIO CHROMATIC_BEBOP   ESKIMO_HEXATONIC_2   HAWAIIAN   HIRA_JOSHI   HONCHOSHI_PLAGAL_FORM                      
48 => data.ref_note;

// Start synchro
HW.launchpad.virtual_key_on(7);

// LED STRIP
//HW.ledstrip.open();
//HW.ledstrip._load_preset('0');

//1::ms => now;

// C dorian scale: D to Eb
//
// intro solo:  Re Re# Ju en principal sat rempli les trous
//       solo 2 : Sat en principal ju rempli les trous
//
//  Couplet (4 boucle):
// A: d_d_ d__g a_a_
// B: e_e_ e__a b_b_
//  
// Sat A, Ju Freestyle sur les meme notes
// Ju B,  Sat Freestyle
// x2
// Sat+Ju A, Ju Freestyle sur les meme notes
// Ju+Sat B,  Sat Freestyle
// x2
// 
// Montée R# avant refrain
// Refrain
// FFFF EEEE DDDD DDDD
//
// Fin
// Alternance Ré Ré#
////
