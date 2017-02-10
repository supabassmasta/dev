class synt0 extends SYNT{

    inlet => TriOsc s => ResonZ z => outlet;   
        .7 => s.gain;
        .1 => s.width;

        800 => z.freq;
        7 => z.Q;

    SinOsc mod => blackhole;
     1::second/ (8 *data.tick) => mod.freq;

    fun void f1 (){ 
      while(1) {
        (mod.last() + 1) * 901 + 403 => z.freq;


        1::ms => now;
      }
 
    } 
    spork ~ f1 ();
        

            fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {   }
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd();
t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
//"*8 {c{c{c 0_0_ _36_ _4__ 6__7" => t.seq;
"*8 }c }c ____ ____ 1_1_ 5274 ____ ____ ____ ____ " => t.seq;
"         ____ ____ ____ ____ _7_7 _5_5 _4__ 4_00 " => t.seq;
"         ____ ____ 8017 _B9A 7___ ____ ____ ____ " => t.seq;
"         ____ ____ ____ ____ _3_3 _66_ __47 _7_7 " => t.seq;
//"*8 }c }c 0////ff////0 _____________" => t.seq;
//"____ R//c ____ 6__7" => t.seq;
.9 => t.gain;
// t.element_sync();
//  t.no_sync();//  t.full_sync();  
16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
t.go(); 

STAUTOPAN autopan;
autopan.connect(t $ ST, .9 /* span 0..1 */, 8*data.tick /* period */, 0.95 /* phase 0..1 */ );  

//////STECHO ech;
////ech.connect(autopan $ ST , data.tick * 3 / 1 , .7); 

STREV1 rev;
rev.connect(autopan $ ST, .3 /* mix */); 

while(1) {
       100::ms => now;
}
 
