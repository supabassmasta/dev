class synt0 extends SYNT{

    inlet => blackhole;

    SinOsc s1 => blackhole;

    .3 => s1.freq;
   SinOsc s2 => blackhole;
    2 => s2.freq;

   SinOsc s3 => blackhole;
    .5 => s3.freq;

    
    SqrOsc s => LPF f =>  outlet;   
    1600 => f.freq;
    9 => f.Q;
        1 => s.gain;

    fun void f1 (){ 
        while(1) {
            (s1.last() + 1) * 7 + 3  => s.freq;

               1::ms => now;
        }
         
       } 
       spork ~ f1 ();
        
    fun void f2 (){ 
        while(1) {
            (s2.last() + 1) * 3800 + 700  => f.freq;

               1::ms => now;
        }
         
       } 
       spork ~ f2 ();

    fun void f3 (){ 
        while(1) {
            (s3.last() + 1)*4 + 7  => f.Q;

               1::ms => now;
        }
         
       } 
       spork ~ f3 ();


            fun void on()  { 
            }  fun void off() { }
            
            fun void new_note(int idx)  { 
              if (idx == 0) {
                .5 => s1.phase;
                .3 => s2.phase;
                .7 => s3.phase;

              }
              
              }
} 


TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 ____ _11_ __1_ ___1 _11_ ____ _1_1 ____ __1_ ____ 1111 1111 _1__ ____ __1_ __1_ " => t.seq;
.07 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go(); 

STAUTOPAN autopan;
autopan.connect(t $ ST, .9 /* span 0..1 */, 7*data.tick/13 /* period */, 0.5 /* phase 0..1 */ );  

STREV1 rev;
rev.connect(autopan $ ST, .05 /* mix */); 
while(1) {
       100::ms => now;
}
 
