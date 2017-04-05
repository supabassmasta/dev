class synt0 extends SYNT{

    8 => int synt_nb; 0 => int i;
    Gain detune[synt_nb];
    SinOsc s[synt_nb];
    Gain final => outlet; .3 => final.gain;

    inlet => detune[i] => s[i] => final;    1.0015 => detune[i].gain;    .6 => s[i].gain; i++;  
    inlet => detune[i] => s[i] => final;    0.9983 => detune[i].gain;    .6 => s[i].gain; i++;  
    inlet => detune[i] => s[i] => final;    1.0023 => detune[i].gain;    .3 => s[i].gain; i++;  
    inlet => detune[i] => s[i] => final;    0.9975 => detune[i].gain;    .3 => s[i].gain; i++;  

            fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {   }
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
t.reg(synt0 s2);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":4}c}c 
  1_|5 88 __4|14|1   
  1_|5 88 __1|51|5   
" => t.seq;
.6 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2000::ms, 1000::ms, .6, 4000::ms);
t.adsr[0].set(2000::ms, 1000::ms, .6, 4000::ms);
t.go(); 

STAUTOPAN autopan;
autopan.connect(t $ ST, .7 /* span 0..1 */, 8*data.tick /* period */, 0.95 /* phase 0..1 */ );  

STECHO ech;
ech.connect(autopan $ ST , data.tick * 1 / 1 , .5); 

STREV1 rev;
rev.connect(ech $ ST, .6 /* mix */); 


while(1) {
       100::ms => now;
}


