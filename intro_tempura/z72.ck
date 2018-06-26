class synt0 extends SYNT{

      8 => int synt_nb; 0 => int i;
      Gain detune[synt_nb];
      SinOsc s[synt_nb];
      Gain final => outlet; .8 => final.gain;

      inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    1. => s[i].gain; i++;  
      inlet => detune[i] => s[i] => final;    .97 => detune[i].gain;    .06 => s[i].gain; i++;  
      inlet => detune[i] => s[i] => final;    .985 => detune[i].gain;    .06 => s[i].gain; i++;  
      inlet => detune[i] => s[i] => final;    .987 => detune[i].gain;    .06 => s[i].gain; i++;  
      inlet => detune[i] => s[i] => final;    1.01 => detune[i].gain;    .06 => s[i].gain; i++;  
      inlet => detune[i] => s[i] => final;    1.02 => detune[i].gain;    .06 => s[i].gain; i++;  
      inlet => detune[i] => s[i] => final;    1.025 => detune[i].gain;    .06 => s[i].gain; i++;  

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s1);
t.reg(synt0 s2);
t.reg(synt0 s3);
t.reg(synt0 s4);

//data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" :4 }c 
1|3|5|7_
1|3|8_
" => t.seq;
.02 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2000::ms, 10::ms, 1., 4000::ms);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.adsr[1].set(2000::ms, 10::ms, 1., 4000::ms);
t.adsr[1].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.adsr[2].set(2000::ms, 10::ms, 1., 4000::ms);
t.adsr[2].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.adsr[3].set(2000::ms, 10::ms, 1., 4000::ms);
t.adsr[3].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 



//STABSATURATOR stabsat;
//stabsat.connect(last, 5.0 /* drive */, 0.00 /* dc offset */); stabsat $ ST @=>  last;

//STAUTOPAN autopan;
//autopan.connect(last $ ST, .1 /* span 0..1 */, data.tick/12 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

//STHPF hpf;
//hpf.connect(last $ ST , 10 /* freq */  , 1.0 /* Q */  );       hpf $ ST @=>  last; 

//STDUCK duck;
//duck.connect(last $ ST);      duck $ ST @=>  last; 

//STREV2 rev; // DUCKED
//rev.connect(last $ ST, .3 /* mix */);      rev $ ST @=>  last; 

STREV1 rev;
rev.connect(last $ ST, .1 /* mix */);     rev  $ ST @=>  last; 
while(1) {
       100::ms => now;
}
 
