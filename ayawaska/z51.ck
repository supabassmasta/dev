class synt0 extends SYNT{

		inlet => PowerADSR padsr => SinOsc s =>  outlet;		
		padsr.set(4*8*data.tick, 20::ms, .7 , 200::ms);
		padsr.setCurves(1.6, .4, .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
				.5 => s.gain;

						fun void on()  { padsr.keyOn(); }	fun void off() { }	fun void new_note(int idx)  {		} 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();//
t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":8 {c{c{c{c{c
1////}c}c}c}c}c}c}c}c}c}c}c}c1

" => t.seq;
.01 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2::ms, 32*data.tick, .2, 400::ms);
t.adsr[0].setCurves(1.0, .8, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

//STLPF lpf;
//lpf.connect(last $ ST , 14000 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 

STHPF hpf;
hpf.connect(last $ ST , 100 /* freq */  , 1.0 /* Q */  );       hpf $ ST @=>  last; 

Delay d[32];
hpf.mono() => Gain in => dac;

for (0 => int i; i <  32    ; i++) {
data.tick * 2 * i => d[i].max => d[i].delay;
in => d[i]=>dac; 
}
 

/*
data.tick * 2 => d[i].max => d[i].delay;
in => d[i]=>dac; i++;
data.tick * 4 => d[i].max => d[i].delay;
in => d[i]=>dac; i++;
data.tick * 6 => d[i].max => d[i].delay;
in => d[i]=>dac; i++;
data.tick * 8 => d[i].max => d[i].delay;
in => d[i]=>dac; i++;
data.tick * 10 => d[i].max => d[i].delay;
in => d[i]=>dac; i++;
data.tick * 12 => d[i].max => d[i].delay;
in => d[i]=>dac; i++;
data.tick * 14 => d[i].max => d[i].delay;
in => d[i]=>dac; i++;
data.tick * 16 => d[i].max => d[i].delay;
in => d[i]=>dac; i++;
data.tick * 18 => d[i].max => d[i].delay;
in => d[i]=>dac; i++;
data.tick * 20 => d[i].max => d[i].delay;
in => d[i]=>dac; i++;
data.tick * 22 => d[i].max => d[i].delay;
in => d[i]=>dac; i++;
data.tick * 24 => d[i].max => d[i].delay;
in => d[i]=>dac; i++;
data.tick * 26 => d[i].max => d[i].delay;
in => d[i]=>dac; i++;
data.tick * 28 => d[i].max => d[i].delay;
in => d[i]=>dac; i++;
data.tick * 30 => d[i].max => d[i].delay;
in => d[i]=>dac; i++;
data.tick * 32 => d[i].max => d[i].delay;
in => d[i]=>dac; i++;
*/
while(1) {
       100::ms => now;
}
 
