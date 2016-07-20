class synt0 extends SYNT{

		inlet => SinOsc s => ABSaturator sat => LPF f =>  outlet;		
				.7 => s.gain;
13 => sat.drive;
2 => sat.dcOffset;

4 => f.Q;
fun  void fl() {

		400=>f.freq;
		for (0 => int i; i < 20      ; i++) {
		
				8::ms => now;
				f.freq() - 16 => f.freq;
		}
		 


}

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {	spork ~ fl();	}
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); t.ion(); t.mix();t.dor();
t.aeo(); //t.phr();t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 {c----__0_" => t.seq;
 t.element_sync();
 
 // t.no_sync(); t.full_sync();     //t.print();
// t.mono() => dac; t.left() => dac.left; t.right() => dac.right; t.raw => dac;
t.go(); 

while(1) {
	     100::ms => now;
}
 
