class synt0 extends SYNT{

    8 => int synt_nb; 0 => int i;
    Gain detune[synt_nb];
    SinOsc s[synt_nb];
    Gain final  => outlet; .3 => final.gain;

    inlet => detune[i] => s[i] => final;    1.0 => detune[i].gain;    .8 => s[i].gain; i++;  
    inlet => detune[i] => s[i] => final;    1.01 => detune[i].gain;    .1 => s[i].gain; i++;  
    inlet => detune[i] => s[i] => final;    .98 => detune[i].gain;    .1 => s[i].gain; i++;  

            fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {   }
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; 
//160::ms => t.glide;  // t.lyd(); 
t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
//" *4 !0!0!0!0!0!0!0!5!0!0!7!0!3!4" => t.seq;
"*4 }c}c}c  1__1 _3__ 2_5_" => t.seq;


//" *4 _0_0 _0!0!0" => t.seq;
//"    _4_0 _0!5!0" => t.seq;
1.6 => t.gain;
// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2::ms, 13::ms, .1, 400::ms);
t.go(); 

//STDUCK duck;
//duck.connect(t $ ST); 

STECHO ech;
ech.connect(t $ ST , data.tick * 5 /1 , .4); 

STAUTOPAN autopan;
autopan.connect(ech $ ST, .7 /* span 0..1 */, 4*data.tick /* period */, 0.05 /* phase 0..1 */ );  

STREV1 rev;
rev.connect(ech $ ST, .4 /* mix */); 

while(1) {
       100::ms => now;
}
 
