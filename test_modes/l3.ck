class synt0 extends SYNT{
LPF lpf;
		inlet => Gain f => SqrOsc s => Gain out =>   lpf =>   outlet;		
	 0.405 => s.width;	



				.3 => s.gain;
		f => Gain two => SinOsc s2 =>  out;		
				.1 => s2.gain;
				2. => two.gain;

		TriOsc mod => ADSR moda => f;
		7 * 100 => mod.gain;
		7 * 100 => mod.freq;
		moda.set(3::ms, 83::ms , .00001, 10::ms);

		SawOsc mod2 => moda;
		6*100 => mod2.gain;
		4*100 => mod2.freq;

						3000 => lpf.freq;
						4 => lpf.Q;
						Step st;
		inlet => ADSR adlpf => blackhole;
		490 => st.next;
		adlpf.set(265::ms, 200::ms, 1, 11::ms);
		12 => 		adlpf.gain;
		fun void f1 (){ 
			while(1) {
						adlpf.last() => lpf.freq;
				     1::ms => now;
			}
			 
			 } 
		 spork ~ f1 ();	 
			  

						fun void on()  { }	fun void off() { moda.keyOff();	adlpf.keyOff();}	fun void new_note(int idx)  {moda.keyOn();	adlpf.keyOn();}
}


FREQ_STR f0; //8 => f0.max; 1=> f0.sync;
"DOR" => f0.scale;
"<f *4 0426  6453 5342 1020 " =>     f0.seq;     
f0.reg(synt0 s0);
//f0.post()  => dac;

while(1) {  100::ms => now; }
//data.meas_size * data.tick => now; 
