class synt0 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
SinOsc s[synt_nb];
Gain final => outlet; .8 => final.gain;

//inlet => detune[i] => s[i] => final;    1.02 => detune[i].gain;    .3 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.012 => detune[i].gain;    .3 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.00 => detune[i].gain;    .6 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    .994 => detune[i].gain;    .3 => s[i].gain; i++;  
//inlet => detune[i] => s[i] => final;    .98 => detune[i].gain;    .3 => s[i].gain; i++;  

            fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {   }
} 


TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"
111_ ____
555_ ____


" => t.seq;
.9 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2000::ms, 1000::ms, .8, 4000::ms);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go(); 

STREV1 rev;
rev.connect(t $ ST, .3 /* mix */); 

while(1) {
       100::ms => now;
}


