class STECHO0C extends ST{

  Gain fbl => outl;
  fbl => Delay dl => fbl;

  Gain fbr => outr;
  fbr => Delay dr => fbr;

  0. =>  dl.gain => dr.gain;
  data.tick => dl.max => dl.delay => dr.max => dr.delay;

  class control_gain extends CONTROL {
    Delay @ dlp;
    Delay @ drp;

    1 => update_on_reg ;
    
    fun void set (float in) {
      in / 100. =>  dlp.gain => drp.gain;
      <<<"control_gain ", dlp.gain()>>>;

    }
  }

  class control_delay extends CONTROL {
    Delay @ dlp;
    Delay @ drp;
    
    1 => update_on_reg ;

    fun void set (float in) {
      <<<"control_delay ", in + 1, " * data.tick / 8.">>>;

       (in + 1) * data.tick / 8. =>  dlp.max => dlp.delay => drp.max => drp.delay; 
    }
  }
  
  control_gain cgain;
  dr @=> cgain.drp; 
  dl @=> cgain.dlp; 

//  control_delay cdelay;
//  dr @=> cdelay.drp; 
//  dl @=> cdelay.dlp; 

  fun void connect(ST @ tone, dur d, CONTROLER g) {
    tone.left() => fbl;
    tone.right() => fbr;

//    d.reg(cdelay);
    g.reg(cgain);
    d => dl.max => dl.delay => dr.max => dr.delay;

  }


}

class synt0 extends SYNT{

		inlet => TriOsc s => LPF filter =>   outlet;		
  	.5 => s.gain;
		.98 => s.width;

		// filter to add in graph:
		// LPF filter =>   BPF filter =>   HPF filter =>   BRF filter => 
		Step base => Gain filter_freq => blackhole;
		Gain mod_out => Gain variable => filter_freq;
		SinOsc mod =>  mod_out; Step one => mod_out; 1=> one.next; .5 => mod_out.gain;

		// params
		8 => filter.Q;
		546 => base.next;
		4502 => variable.gain;
		1::second / (data.tick * 7 ) => mod.freq;
		// If mod need to be synced
		// 1 => int sync_mod;
		// if (idx == 0) { if (sync_mod) { 0=> sync_mod; 0.0 => mod.phase; } }

		fun void filter_freq_control (){ 
			    while(1) {
						      filter_freq.last() => filter.freq;
									      1::ms => now;
												    }
		}
		spork ~ filter_freq_control (); 


						fun void on()  { }	fun void off() { }	fun void new_note(int idx)  {		}
} 


TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; 
39::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();// 
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c *4 
1234 5123 4512 3450 
" => t.seq;




.02 => t.gain;
// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   
//t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
t.go(); t $ ST @=> ST @ last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .9 /* span 0..1 */, 8*data.tick /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 


//STFILTERMOD fmod;
//fmod.connect( last , "LPF" /* "HPF" "BPF" BRF" "ResonZ" */, 4 /* Q */, 3 *100 /* f_base */ , 1400  /* f_var */, 1::second / (10 * data.tick) /* f_mod */);     fmod  $ ST @=>  last; 

//STLPFC lpfc;
//lpfc.connect(last $ ST , HW.lpd8.potar[1][2] /* freq */  , HW.lpd8.potar[1][3] /* Q */  );       lpfc $ ST @=>  last; 

//STDUCK duck;
//duck.connect(autopan $ ST); 
STGAINC gainc;
gainc.connect(last $ ST , HW.lpd8.potar[1][5] /* gain */  , 7. /* static gain */  );       gainc $ ST @=>  last; 

//STECHO0C ech;
//ech.connect(last $ ST , data.tick * 3 / 4  /* freq */ , HW.lpd8.potar[1][4] /* Q */ );      ech $ ST @=>  last;  

STGAINC gainc2;
gainc2.connect(autopan $ ST , HW.lpd8.potar[1][6] /* gain */  , 2. /* static gain */  );       gainc2 $ ST @=>  last; 

STCONVREV stconvrev;
stconvrev.connect(last $ ST , 77 /* ir index */, 1 /* chans */, 10::ms /* pre delay*/, .5 /* rev gain */  , 0.0 /* dry gain */  );       stconvrev $ ST @=>  last;  


<<<"SYNT 1 Solo:\n  -lpd8 potar 1.5: Gain\n  -lpd8 potar 1.6: echo gain">>>;

while(1) {
	     100::ms => now;
}
 
