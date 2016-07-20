class synt0 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
SawOsc s[synt_nb];
Gain final => outlet; .2 => final.gain;

inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .6 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.01 => detune[i].gain;    .6 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.03 => detune[i].gain;    .6 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    1.07 => detune[i].gain;    .6 => s[i].gain; i++;  

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
}		

TONE t;
t.reg(synt0 s1);  data.tick * 8 => t.max;
//60::ms => t.glide;  // t.lyd(); t.ion(); t.mix();t.dor();t.aeo(); t.phr();t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"{c{c g///0__" => t.seq;

 t.element_sync();// t.no_sync(); t.full_sync();     //t.print();
 t.mono() => dac;
 t.mono() => Gain rev => global_mixer.rev0;
 .5 => rev.gain;

 //t.left() => dac.left; t.right() => dac.right; t.raw => dac;
t.go(); 

while(1) {
	     100::ms => now;
}
 
