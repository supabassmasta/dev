


class synt0 extends SYNT{

		inlet => TriOsc s => PowerADSR padsr => outlet;		
				.5 => s.gain;
		.97 => s.width;
		padsr.set(0::ms , data.tick / 8 , .0000001, data.tick / 4);
		padsr.setCurves(2.0, 2.0, .5);

						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		padsr.keyOn();}
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.reg(synt0 s2);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.reg(synt0 s3);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.reg(synt0 s4);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c *4
 __1|3|5_ ____  ____ ____   ____ ____ ____ ____ 
 __#0|2|#4_ ____  ____ ____  ____ ____ ____ ____ 
 1|3|5_1|3|5_ ____  ____ ____   ____ ____ ____ ____ 
 __#0|2|#4 #0|2|#4 ____  ____ ____  ____ ____ ____ ____ 

" => t.seq;
.4 => t.gain;
1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 7::ms, .1, 400::ms);
t.adsr[0].set(1::ms, 7::ms, 1, 1::ms);
t.go(); t $ ST @=> ST  last;

STADSR stadsr;
stadsr.set(3::ms /* Attack */, 7::ms /* Decay */, 1 /* Sustain */, .125 * data.tick /* Sustain dur */,  40::ms /* release */);
stadsr.connect(last $ ST, t.note_info_tx_o);  stadsr  $ ST @=>  last;
//stadsr.connect(last $ ST);  stadsr  $ ST @=>  last; 
// stadsr.keyOn(); stadsr.keyOff(); 

STGVERB stgverb;
stgverb.connect(last $ ST, .1/* mix */, 4 * 10. /* room size */, 1::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb $ ST @=>  last; 


STAUTOFILTERX stautobpfx0; BPF_XFACTORY stautobpfx0_fact;
stautobpfx0.connect(last $ ST ,  stautobpfx0_fact, 1.0 /* Q */, 6 * 100 /* freq base */, 17 * 100 /* freq var */, data.tick * 15 / 2 /* modulation period */, 1 /* order */, 1 /* channels */ , 1::ms /* update period */ );       stautobpfx0 $ ST @=>  last;  

//STECHO ech2;
//ech2.connect(last $ ST , data.tick * 1 / 5 , .3);  ech2 $ ST @=>  last; 
STAUTOPAN autopan;
autopan.connect(last $ ST, .6 /* span 0..1 */, data.tick * 3 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 



while(1) {
	     100::ms => now;
}
 

