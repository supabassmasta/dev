class synt0 extends SYNT{

    inlet => SqrOsc s => LPF lpf =>  outlet;   
    288 => lpf.freq;
    3 * 10 => lpf.Q;

    SinOsc mod => blackhole;
     1::second/ (2 *data.tick) => mod.freq;

    fun void f1 (){ 
      while(1) {
        (mod.last() + 1) * 630 + 103 => lpf.freq;


        1::ms => now;
      }
 
    } 
    spork ~ f1 ();
        

        .2 => s.gain;

            fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { .69 => mod.phase;  }
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
//"*8 {c{c{c 0_0_ _36_ _4__ 6__7" => t.seq;
//"*4 {c{c{c f////00////z :8 __________ __________" => t.seq;
"*4 {c{c{c f////////0 :8 __________ __________" => t.seq;
//"____ R//c ____ 6__7" => t.seq;
.3 => t.gain;
// t.element_sync();//  t.no_sync();//  t.full_sync();  
t.sync(data.tick);
16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
t.go(); 


STECHO ech;
ech.connect(t $ ST , data.tick * 2 / 1 , .6); 

STAUTOPAN autopan;
autopan.connect(ech $ ST, .9 /* span 0..1 */, 2*data.tick /* period */, 0.05 /* phase 0..1 */ );  

STREV1 rev;
rev.connect(autopan $ ST, .3 /* mix */); 

16 * data.tick => now; 
 
