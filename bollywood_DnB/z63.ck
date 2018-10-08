class synt0 extends SYNT{

    inlet => TriOsc s =>  outlet; 
      .5 => s.gain;
      .5 => s.width;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(HMOD1 s1);  //data.tick * 8 => t.max; //
60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4*2 }c }c

1538" => t.seq;
.5 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 


STDIGITC dig;
dig.connect(last $ ST , HW.lpd8.potar[1][3] /* sub sample period */ , HW.lpd8.potar[1][4] /* quantization */);      dig $ ST @=>  last; 

STLPFC lpfc;
lpfc.connect(last $ ST , HW.lpd8.potar[1][5] /* freq */  , HW.lpd8.potar[1][6] /* Q */  );       lpfc $ ST @=>  last; 

STGAINC gainc;
gainc.connect(last $ ST , HW.lpd8.potar[1][1] /* gain */  , 1. /* static gain */  );       gainc $ ST @=>  last; 

STECHOC0 ech;
ech.connect(last $ ST , data.tick * 8 / 4  /* period */ , HW.lpd8.potar[1][2] /* Gain */ );      ech $ ST @=>  last;   

while(1) {
       100::ms => now;
}
 
