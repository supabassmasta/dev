class synt0 extends SYNT{

    inlet => TriOsc s =>  outlet;   
        .8 => s.gain;
       .79 => s.width; 

            fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {   }
} 


TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" {c *4 _11_ " => t.seq;
1.9 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(data.tick/2 , data.tick /4, .00001,data.tick/3  );
t.adsr[0].setCurves(3.4, 3., .3);

t.go();
STRESC resc;
resc.connect(t $ ST , HW.lpd8.potar[1][6] /* freq */  , HW.lpd8.potar[1][7] /* Q */  );  

STRESC resc1;
resc1.connect(t $ ST , HW.lpd8.potar[1][2] /* freq */  , HW.lpd8.potar[1][3] /* Q */  );  



STGAINC gainc;
gainc.connect(resc $ ST , HW.lpd8.potar[1][5] /* gain */  , 4. /* static gain */  );  

STGAINC gainc1;
gainc1.connect(resc1 $ ST , HW.lpd8.potar[1][1] /* gain */  , 4. /* static gain */  );  


STREV1 rev;
rev.connect(gainc $ ST, .2 /* mix */); 


while(1) {
       100::ms => now;
}
 

