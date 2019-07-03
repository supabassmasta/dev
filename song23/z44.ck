class NOISEL0 extends SYNT{

		inlet => SinOsc s =>  outlet;		
				.15 => s.gain;
		Noise n => Gain mult => s;
		3 => mult.op;
		inlet => Gain gn => mult;
		1.1 => gn.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		} 0 => own_adsr;
}

TONE t;
t.reg(NOISEL0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(NOISEL0 s2);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
t.reg(NOISEL0 s3);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// t.dor();// t.aeo(); // t.phr();// t.loc();
t.dor();// Lt.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":4:2 }c }c
1|5|8_
" => t.seq;
//1|5|8_
.17 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STSYNCHPF stsynchpf;
stsynchpf.freq(100 /* Base */, 5 * 1000 /* Variable */, 3. /* Q */);
stsynchpf.adsr_set(.0004 /* Relative Attack */, 1./* Relative Decay */, .00001 /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
stsynchpf.connect(last $ ST, t.note_info_tx_o); stsynchpf $ ST @=>  last;  

STLPF lpf;
lpf.connect(last $ ST , 6 * 1000 /* freq */  , 1.0 /* Q */  );       lpf $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

STCOMPRESSOR stcomp;
10. => float in_gain;
stcomp.connect(last $ ST , in_gain /* in gain */, 1./in_gain /* out gain */, 0.3 /* slopeAbove */,  1.0 /* slopeBelow */ , 0.5 /* thresh */, 5::ms /* attackTime */ , 300::ms /* releaseTime */);   stcomp $ ST @=>  last;   


while(1) {
       100::ms => now;
}
 

