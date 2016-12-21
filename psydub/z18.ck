class synt0 extends SYNT{

8 => int synt_nb; 0 => int i;
Gain detune[synt_nb];
SinOsc s[synt_nb];
Gain final => BPF bpf => outlet; .30 => final.gain;

inlet => detune[i] => s[i] => final;    1. => detune[i].gain;    .8 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    2. => detune[i].gain;    .1 => s[i].gain; i++;  
inlet => detune[i] => s[i] => final;    3. => detune[i].gain;    .04 => s[i].gain; i++;  
						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}

200 => bpf.freq;
.9 => bpf.Q;

SIN si;
1::second / (16 * data.tick) => si.freq;

fun void f1 (){ 
while(1) {
	si.value() * 400 + 501 => bpf.freq; 
	     100::ms => now;
}
 
	 } 
	 spork ~ f1 ();
	  


} 

TONE t;
t.reg(synt0 s1); 
t.reg(synt0 s2); 
t.reg(synt0 s3); 
t.reg(synt0 s4); 
t.reg(synt0 s5); 

//data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c *4 ____ 1|3|5|1___" => t.seq;
// t.element_sync();//  t.no_sync();//  t.full_sync();     //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(9::ms, 10::ms,  .6, 20::ms);
t.adsr[1].set(9::ms, 10::ms, .6, 20::ms);
t.adsr[2].set(9::ms, 10::ms, .6, 20::ms);
t.adsr[3].set(9::ms, 10::ms, .6, 20::ms);
t.go(); 


STREV1 rev;
rev.connect(t $ ST, .2 /* mix */); 

STECHO ech;
ech.connect(rev $ ST ,  3 * data.tick/4, .6); 

STAUTOPAN autopan;
autopan.connect(ech $ ST, .6 /* span 0..1 */, 8*data.tick /* period */, 0.95 /* phase 0..1 */ );  

//STDUCK duck;
//duck.connect(t $ ST); 




while(1) {
	     100::ms => now;
}
 
