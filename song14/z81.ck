class synt0 extends SYNT{

    inlet => TriOsc s =>  outlet;   
        .5 => s.gain;

            fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {   }
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"1//g____ __" => t.seq;
.4 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();

STECHO ech;
ech.connect(t $ ST , data.tick * 3 / 4 , .7);
STECHO ech2;
ech2.connect(ech $ ST , data.tick * 6 / 2 , .7);


while(1) {
       100::ms => now;
}
 

