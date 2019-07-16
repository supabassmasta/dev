class synt1 extends SYNT{

    inlet => MagicSine s =>  outlet; 
      .5 => s.gain;

       fun void new_note(int idx)  {
          1::samp => now;
            inlet.last() => s.freq;
        }
           

}

class synt0 extends SYNT{

//    inlet => MagicSine s =>  outlet; 
//      .5 => s.gain;


50 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
MagicSine s[synt_nb];
Gain final => outlet; .1 => final.gain;

float fact;
1 => fact;
inlet => detune[i] => blackhole;  s[i] => final;  fact *  1.001 => detune[i].gain;    .6 => s[i].gain; i++;  
inlet => detune[i] => blackhole;  s[i] => final;  fact *  1.00 => detune[i].gain;    .2 => s[i].gain; i++;  
inlet => detune[i] => blackhole;  s[i] => final;  fact *  .0991 => detune[i].gain;    .1 => s[i].gain; i++;  
2 => fact;
inlet => detune[i] => blackhole;  s[i] => final;  fact *  1.001 => detune[i].gain;    .6 / (fact * fact)  => s[i].gain; i++;  
inlet => detune[i] => blackhole;  s[i] => final;  fact *  1.00 => detune[i].gain;    .2  / (fact * fact)=> s[i].gain; i++;  
inlet => detune[i] => blackhole;  s[i] => final;  fact *  .0991 => detune[i].gain;    .1 / (fact * fact) => s[i].gain; i++;  
fact + 1 => fact;
inlet => detune[i] => blackhole;  s[i] => final;  fact *  1.001 => detune[i].gain;    .6 / (fact * fact) => s[i].gain; i++;  
inlet => detune[i] => blackhole;  s[i] => final;  fact *  1.00 => detune[i].gain;    .2  / (fact * fact)=> s[i].gain; i++;  
inlet => detune[i] => blackhole;  s[i] => final;  fact *  .0991 => detune[i].gain;    .1 / (fact * fact) => s[i].gain; i++;  
fact + 1 => fact;
inlet => detune[i] => blackhole;  s[i] => final;  fact *  1.001 => detune[i].gain;    .6 / (fact * fact) => s[i].gain; i++;  
inlet => detune[i] => blackhole;  s[i] => final;  fact *  1.00 => detune[i].gain;    .2  / (fact * fact)=> s[i].gain; i++;  
inlet => detune[i] => blackhole;  s[i] => final;  fact *  .0991 => detune[i].gain;    .1 / (fact * fact) => s[i].gain; i++;  
fact + 1 => fact;
inlet => detune[i] => blackhole;  s[i] => final;  fact *  1.001 => detune[i].gain;    .6 / (fact * fact) => s[i].gain; i++;  
inlet => detune[i] => blackhole;  s[i] => final;  fact *  1.00 => detune[i].gain;    .2  / (fact * fact)=> s[i].gain; i++;  
inlet => detune[i] => blackhole;  s[i] => final;  fact *  .0991 => detune[i].gain;    .1 / (fact * fact) => s[i].gain; i++;  
fact + 1 => fact;
inlet => detune[i] => blackhole;  s[i] => final;  fact *  1.001 => detune[i].gain;    .6 / (fact * fact) => s[i].gain; i++;  
inlet => detune[i] => blackhole;  s[i] => final;  fact *  1.00 => detune[i].gain;    .2  / (fact * fact)=> s[i].gain; i++;  
inlet => detune[i] => blackhole;  s[i] => final;  fact *  .0991 => detune[i].gain;    .1 / (fact * fact) => s[i].gain; i++;  
fact + 1 => fact;
inlet => detune[i] => blackhole;  s[i] => final;  fact *  1.001 => detune[i].gain;    .6 / (fact * fact) => s[i].gain; i++;  
inlet => detune[i] => blackhole;  s[i] => final;  fact *  1.00 => detune[i].gain;    .2  / (fact * fact)=> s[i].gain; i++;  
inlet => detune[i] => blackhole;  s[i] => final;  fact *  .0991 => detune[i].gain;    .1 / (fact * fact) => s[i].gain; i++;  
fact + 1 => fact;
inlet => detune[i] => blackhole;  s[i] => final;  fact *  1.001 => detune[i].gain;    .6 / (fact * fact) => s[i].gain; i++;  
inlet => detune[i] => blackhole;  s[i] => final;  fact *  1.00 => detune[i].gain;    .2  / (fact * fact)=> s[i].gain; i++;  
inlet => detune[i] => blackhole;  s[i] => final;  fact *  .0991 => detune[i].gain;    .1 / (fact * fact) => s[i].gain; i++;  
fact + 1 => fact;
inlet => detune[i] => blackhole;  s[i] => final;  fact *  1.001 => detune[i].gain;    .6 / (fact * fact) => s[i].gain; i++;  
inlet => detune[i] => blackhole;  s[i] => final;  fact *  1.00 => detune[i].gain;    .2  / (fact * fact)=> s[i].gain; i++;  
inlet => detune[i] => blackhole;  s[i] => final;  fact *  .0991 => detune[i].gain;    .1 / (fact * fact) => s[i].gain; i++;  
fact + 1 => fact;
inlet => detune[i] => blackhole;  s[i] => final;  fact *  1.001 => detune[i].gain;    .6 / (fact * fact) => s[i].gain; i++;  
inlet => detune[i] => blackhole;  s[i] => final;  fact *  1.00 => detune[i].gain;    .2  / (fact * fact)=> s[i].gain; i++;  
inlet => detune[i] => blackhole;  s[i] => final;  fact *  .0991 => detune[i].gain;    .1 / (fact * fact) => s[i].gain; i++;  

        fun void on()  { }  fun void off() { } 
        
        fun void new_note(int idx)  {
          1::samp => now;
          for (0 => int i; i <    synt_nb   ; i++) {
            detune[i].last() => s[i].freq;
        }
           
          
        }
        0 => own_adsr;
} 

TONE t;
t.reg(synt1 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c}c13__5_ 8_" => t.seq;
.3 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(300::ms, 4000::ms, .2, 4000::ms);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STTREMOLO sttrem;
.5 => sttrem.mod.gain;  5 => sttrem.mod.freq;
sttrem.pa.set(data.tick *6 , 0::ms , 1., 1700::ms);
sttrem.connect(last $ ST, t.note_info_tx_o);  sttrem  $ ST @=>  last;  

//STFLANGER flang;
//flang.connect(last $ ST); flang $ ST @=>  last; 
//flang.add_line(2 /* 0 : left, 1: right 2: both */, .8 /* delay line gain */,  1::ms /* dur base */, 4::samp /* dur range */, 6 /* freq */); 

STREV1 rev;
rev.connect(last $ ST, .3 /* mix */);     rev  $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
