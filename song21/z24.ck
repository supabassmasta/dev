class filter0 extends SYNT{
    1::samp => dur refresh;

    inlet => blackhole;
    
    STLPF lpf;
//    STWPDiodeLadder lpf;
    
    fun void f1 (){ 
      while(1) {
        inlet.last() => lpf.lpfl.freq =>  lpf.lpfr.freq;
//        inlet.last() => lpf.lpfl.cutoff =>  lpf.lpfr.cutoff;
        refresh => now;
      }
       
      
    } 
    spork ~ f1 ();

    fun void  connect (ST @ in, float q){
      lpf.connect(in , 1000 /* freq */  , 1.0 /* Q */  );   
      q => lpf.lpfl.Q =>  lpf.lpfr.Q;
//      lpf.connect(in , 1000 /* cutoff */  , 5. /* resonance */ , true /* nonlinear */, true /* nlp_type */  );   
//      q => lpf.lpfl.resonance=>  lpf.lpfr.resonance;

    }


        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE tone_filter;
tone_filter.reg(filter0 filt0);  //data.tick * 8 => tone_filter.max; //60::ms => tone_filter.glide;  // tone_filter.lyd(); // tone_filter.ion(); // tone_filter.mix();// 
tone_filter.dor();// tone_filter.aeo(); // tone_filter.phr();// tone_filter.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"" => tone_filter.seq;
.9 * data.master_gain => tone_filter.gain;
//tone_filter.sync(4*data.tick);// tone_filter.element_sync();//  tone_filter.no_sync();//  tone_filter.full_sync();  // 16 * data.tick => tone_filter.extra_end;   //tone_filter.print(); //tone_filter.force_off_action();
// tone_filter.mono() => dac;//  tone_filter.left() => dac.left; // tone_filter.right() => dac.right; // tone_filter.raw => dac;
tone_filter.adsr[0].set(20::ms, 0::ms, 1., 400::ms);
tone_filter.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
tone_filter.go();   tone_filter $ ST @=> ST @ last; 

//////////////////////////////////////////////
//            PUT YOUR SYNT/SEQ HERE :       //
//            Beware of "last" declaration  //




//////////////////////////////////////////////

filt0.connect(last, 6.0); filt0.lpf @=> last;

 
