class LPFC extends Chubgraph{
	10::ms => dur period;

	inlet => LPF lpf => outlet;
  Gain freq => blackhole;

  1 => lpf.Q;

		fun void f1 (){ 
				while(1) {
					  freq.last() => lpf.freq;   
						period => now;
				}
		} 

		spork ~ f1 ();
}	
	
class synt0 extends SYNT{
		LPFC f ;
		//		inlet => SinOsc s => ABSaturator sat /*=>f */ =>  outlet;		
		inlet => SinOsc s => ABSaturator sat =>f  =>  outlet;		
		1.3 => s.gain;
		7 => sat.drive;
		1 => sat.dcOffset;

		9 => f.lpf.Q;

		Step st => Gain gtri =>  f.freq;
		TriOsc tri => gtri;
		TriOsc tri2 => gtri;
		0.8 => tri2.gain;

		2.25 => st.next;
		527 => gtri.gain;

		.5 => tri.width;
		4::second/(data.tick) => tri.freq;
		1::second/(11*data.tick) => tri2.freq;

		//Step st => Envelope e => f.freq;
		//1 => e.value;
		//af.set(40::ms, 160::ms, 0.00001, 10::ms);
		//Step st2 => af;
		//40 => st2.next;
		//fun void env (){
		//		0 => e.target;
		//		160::ms => e.duration;
		//
		//		260::ms => now;
		//		1 => e.value;
		//
		//}


		fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {	
			//						af.keyOn();
			//							spork ~ env();
			0 => tri.phase;
		}
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); t.ion(); t.mix();t.dor();
t.aeo(); //t.phr();t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 {c----_0!0_" => t.seq;
 t.element_sync();
 
 // t.no_sync(); t.full_sync();     //t.print();
// t.mono() => dac; t.left() => dac.left; t.right() => dac.right; t.raw => dac;
t.go(); 

while(1) {
	     100::ms => now;
}
 
