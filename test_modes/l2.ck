SEQ_STR s0;  4 => s0.max; 1 => s0.sync;

s0.reg(0, "../_SAMPLES/FreeDrumKits.net - 9th Wonder Kit/Kicks/Wal_K.wav");
s0.reg(1, "../_SAMPLES/FreeDrumKits.net - 9th Wonder Kit/Snares/Wsc_Snr2.wav");
s0.reg(2, "../_SAMPLES/FreeDrumKits.net - 9th Wonder Kit/Hi-Hats/Str_H1.wav");
s0.reg(3, "../_SAMPLES/FreeDrumKits.net - 9th Wonder Kit/Percussions/Bngo_3.wav");


"*4 4_C_4|b_DC" => s0.seq; //s0.post() =>  dac;

s0.go();


class synt0 extends SYNT{

		inlet => SinOsc s =>  outlet;		
				.5 => s.gain;

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
}


FREQ_STR f0; //8 => f0.max;
1=> f0.sync;
"<a *8 ____0_0_" =>     f0.seq;     
f0.adsr.set(10::ms, 10::ms, 0.7, 100::ms);
f0.reg(synt0 S0);
//f0.post()  => dac;


class synt1 extends SYNT{
		inlet => SqrOsc s => BPF lpf => /* BPF bpf2 =>*/  outlet;		
		.2 => s.width;
				.06=> s.gain;

		2 => lpf.gain;
		3 => lpf.Q;
		2000 => lpf.freq;
		Step step => ADSR ad => BPF bpfad => blackhole;
		1000 => bpfad.freq;
		1 => step.next;

		60::ms => dur trans;
		ad.set(trans, trans, .1, 20::ms);

		fun void f1 (){ 
				while(1) {
				ad.last() *2500 => lpf.freq ;
					     1::ms => now;
				}
		 } 
	 spork ~ f1 ();
	  
						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {	ad.keyOn();	}
} 

FREQ_STR f1; //8 => f0.max;
1=> f1.sync;
//"<a >c  *4  0405 0405 0405 0405   0405 0406 0502 0406 " =>     f1.seq;     
//"<a >7  *4  0405 0405 0405 0405   0405 0406 0502 0406 " =>     f1.seq;     
"<a >c  *4 0405 0405 0406 0406  0432 1042 0432 1046  " =>     f1.seq;     
"<a >c  *4 0405 0405 0406 0406  0432 1042 0123 4567  " =>     f1.seq;     
"<a >7  *4 0405 0405 0406 0406  0432 1042 0123 4566  " =>     f1.seq;     
"<a >7  *4 0405 0405 0406 0406  0432 1042 0123 4567  " =>     f1.seq;     
f1.reg(synt1 s1);
//f0.post()  => dac;






while(1) { 100::ms => now; }
//data.meas_size * data.tick => now; 
