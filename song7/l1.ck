class synt0 extends SYNT{

    inlet => TriOsc s =>  outlet;   
        .8 => s.gain;
       .69 => s.width; 

            fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {   }
} 


TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c *4 _11_ " => t.seq;
1.9 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(data.tick/2 , data.tick /6, .00001,data.tick/3  );
t.adsr[0].setCurves(3.4, 3., .3);

t.go();

STREV1 rev;
rev.connect(t $ ST, .1 /* mix */); 

while(1) {
       100::ms => now;
}
 

