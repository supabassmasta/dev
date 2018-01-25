class synt0 extends SYNT{

		inlet => SinOsc s =>PowerADSR padsr => outlet;		
				.8 => s.gain;
		padsr.set(6::ms , data.tick / 2 , .1, data.tick / 4);
		padsr.setCurves(2.0, 3.0, .5);

						fun void on()  {padsr.keyOn(); }	fun void off() {padsr.keyOff(); }	fun void new_note(int idx)  {	padsr.keyOn();	}
} 

/*
TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c 1___" => t.seq;
.2 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(0::ms, 1000::ms, .00001, 400::ms);
t.go(); 

ST st;

t.raw() => st.mono_in;
*/

lpk25 l;
POLY synta; 
l.reg(synta);
synta.reg(synt0 s0);  synta.a[0].set(3::ms, 30::ms, 1., 100::ms);
synta.reg(synt0 s1);  synta.a[1].set(3::ms, 30::ms, 1., 100::ms);
synta.reg(synt0 s2);  synta.a[2].set(3::ms, 30::ms, 1., 100::ms);
synta.reg(synt0 s3);  synta.a[3].set(3::ms, 30::ms, 1., 100::ms); 

STECHO ech;
ech.connect(synta $ ST , data.tick * 1 / 2 , .5); 

STREV1 rev;
rev.connect(ech $ ST, .2 /* mix */); 

while(1) {
	     100::ms => now;
}
 
