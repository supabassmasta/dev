class synt0 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
TriOsc s[synt_nb];
Gain final => outlet; .7 => final.gain;

inlet => detune[i] => s[i] => final;    1.012 => detune[i].gain;    .3 => s[i].gain; .7 => s[i].width; i++;  
inlet => detune[i] => s[i] => final;    1.00 => detune[i].gain;    .6 => s[i].gain;  .7 => s[i].width; i++;  
inlet => detune[i] => s[i] => final;    .994 => detune[i].gain;    .3 => s[i].gain;  .7 => s[i].width; i++;  

            fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {   }
} 


TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"
111_ ____
555_ ____
111_ ____
444_ ____
111_ ____
777_ ____


" => t.seq;
.6 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2000::ms, 1000::ms, .8, 4000::ms);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go(); 

STFILTERMOD fmod;
fmod.connect( t , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 4 /* Q */, 10 * 100 /* f_base */ , 6 * 100  /* f_var */, .3 /* f_mod */); 

STAUTOPAN autopan;
autopan.connect(fmod $ ST, .9 /* span 0..1 */, 8*data.tick /* period */, 0.95 /* phase 0..1 */ );  


STREV1 rev;
rev.connect(autopan $ ST, .3 /* mix */); 

while(1) {
       100::ms => now;
}


