public class CELLO1 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
CELLO0 s[synt_nb];
Gain final => outlet; .5 => final.gain;

inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .9 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.007 => detune[i].gain;    .4 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    0.996 => detune[i].gain;    .4 => s[i].gain; i++;  

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {
          1::samp => now;
          for (0 => int i; i <  synt_nb     ; i++) {
            s[i].new_note(0);
          }
           


 } 0 => own_adsr;
} 

