class TB304 extends SYNT{

		inlet => SqrOsc s => LPF f => LPF f2 =>  outlet;		
				.7 => s.gain;
				400 => float fr;
				fr => f.freq;
				fr => f2.freq;

				// Q
				 1.0 => float q;
				 q => f.Q;
				 q => f2.Q;


				Step st => ADSR a => Gain outa => blackhole;
				Step st2 => outa;
				// Limit low freq
				256=> st2.next;
				// Max freq
				385. => st.next;
		
				// Decay time
				a.set(40::ms, 40::ms, 0.1, 0::ms);




				fun void f1 (){ 
						while(1) {
				outa.last() => float fr;
				fr => f.freq;
				fr => f2.freq;
								

							     1::samp => now;
						}
						 
					 } 
					 spork ~ f1 ();
					  

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {a.keyOn();		}
}

TONE t;
t.reg(TB304 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 }c !1" => t.seq;
.05 => t.gain;
 t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(4::ms, 10::ms, 1., 4::ms);
t.go(); 

STDUCK duck;
duck.connect(t $ ST); 

while(1) {
	     100::ms => now;
}
 
