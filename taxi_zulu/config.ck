// RYTHM
147 => data.bpm;   (60.0/data.bpm)::second => data.tick;
16 => data.meas_size;
// MIX
0.7 => data.master_gain;
// SCALE
"MIN" => data.scale.my_string; // MAJ PENTA_MAJ PENTA_MIN  BLUES  ALL  ADONAI_MALAKH  ALGERIAN  BI_YU AEOLIAN_FLAT_1  CHAD_GADYO   CHAIO CHROMATIC_BEBOP   ESKIMO_HEXATONIC_2   HAWAIIAN   HIRA_JOSHI   HONCHOSHI_PLAGAL_FORM                      
53 => data.ref_note;

// Start synchro
HW.launchpad.virtual_key_on(7);

// LED STRIP
//HW.ledstrip.open();
//HW.ledstrip._load_preset('0');

//1::ms => now;


10 => int mixer;

class STECHOONLY extends ST{

 Gain fbl => outl;
 fbl => Delay dl => fbl;

 Gain fbr => outr;
 fbr => Delay dr => fbr;

  fun void connect(ST @ tone, dur d, float g) {
    tone.left() => dl;
    tone.right() => dr;

    g =>  dl.gain => dr.gain;
    d => dl.max => dl.delay => dr.max => dr.delay;

  }

}

fun void EFFECT1   (){ 
  STMIX stmix;
  stmix.receive(mixer + 1); stmix $ ST @=> ST @ last; 
STECHOONLY ech;
ech.connect(last $ ST , data.tick * 2 / 4 + 5::ms , .7);  ech $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .3 /* span 0..1 */, data.tick * 2 / 3 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

  STMIX stmix2;
  stmix2.send(last, mixer + 2);

  while(1) {
         100::ms => now;
  }
   
} 
spork ~  EFFECT1();

fun void EFFECT2   (){ 
  STMIX stmix;
  stmix.receive(mixer + 2); stmix $ ST @=> ST @ last; 

STCONVREV stconvrev;
stconvrev.connect(last $ ST , 119/* ir index */, 1 /* chans */, 10::ms /* pre delay*/, .05 /* rev gain */  , 0.9 /* dry gain */  );       stconvrev $ ST @=>  last;  


  while(1) {
         100::ms => now;
  }
   
} 
spork ~  EFFECT2();





while(1) {
       100::ms => now;
}
 
