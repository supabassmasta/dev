class synt0 extends SYNT{
    inlet => Gain in;
    Gain out =>  outlet;   

    0 => int i;
    Gain opin[8];
    Gain opout[8];
    PowerADSR adsrop[8];
    SinOsc osc[8];

    // build and config operators
    //---------------------
    opin[i] => SawOsc saw => adsrop[i] => opout[i];
    1. => opin[i].gain;
    adsrop[i].set(100::ms, 200::ms, 1. , 5000::ms);
    adsrop[i].setCurves(.6, .4, .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
    1 => adsrop[i].gain;
    i++;

    //---------------------
    opin[i] => TriOsc tri => adsrop[i] => opout[i];
    1./2. + 0.00 => opin[i].gain;
    adsrop[i].set(5000::ms, 1000::ms, .8 , 2400::ms);
    adsrop[i].setCurves(2., .2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
    100 * 1 => adsrop[i].gain;
    i++;

    //---------------------
    opin[i] => osc[i] => adsrop[i] => opout[i];
    1./6. +0.2 => opin[i].gain;
    adsrop[i].set(8000::ms, 2000::ms, .5 , 1800::ms);
    adsrop[i].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
    13 * 10 => adsrop[i].gain;
    i++;

    //---------------------
    opin[i] => osc[i] => adsrop[i] => opout[i];
    1./2. +0.000 => opin[i].gain;
    adsrop[i].set(200::ms, 186::ms, .2 , 400::ms);
    adsrop[i].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
    30 => adsrop[i].gain;
    i++;

    // connect operators
    // main osc
    in => opin[0]; opout[0]=> out; 

    // modulators
    in => opin[1];
    opout[1] => opin[0];

    in => opin[2];
     opout[2] => opin[0];

    in => opin[3];
    // opout[3] => opin[0];


    .5 => out.gain;

    fun void on()  
    {
      for (0 => int i; i < 8      ; i++)
      {
            adsrop[i].keyOn();
                // 0=> osc[i].phase;
      }
            
    } 
        
        fun void off() 
        {
          for (0 => int i; i < 8      ; i++) 
          {
                adsrop[i].keyOff();
          }
                      
                                        
        } 
            
            fun void new_note(int idx)  
            { 
                         
            }
             0 => own_adsr;
}  

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.reg(synt0 s2); 
t.reg(synt0 s3); 
t.reg(synt0 s4); 
t.reg(synt0 s5); 
t.reg(synt0 s6); 
":8:2 
1|3|5|8|b|d_
" => t.seq;
1.5 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();// 
t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2000::ms, 1000::ms, .8, 4000::ms);
t.adsr[1].set(2000::ms, 1000::ms, .8, 4000::ms);
t.adsr[2].set(2000::ms, 1000::ms, .8, 4000::ms);
t.adsr[3].set(2000::ms, 1000::ms, .8, 4000::ms);
t.adsr[4].set(2000::ms, 1000::ms, .8, 4000::ms);
t.adsr[5].set(2000::ms, 1000::ms, .8, 4000::ms);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STSYNCWPDiodeLadder stsyncdl;
stsyncdl.freq(7*100 /* Base */, 10 * 100 /* Variable */, 7. /* resonance */ , true /* nonlinear */, true /* nlp_type */ );
stsyncdl.adsr_set(.1 /* Relative Attack */, 1.3/* Relative Decay */, 0.00001 /* Sustain */, .0 /* Relative Sustain dur */, 0.0 /* Relative release */);
stsyncdl.connect(t $ ST, t.note_info_tx_o); stsyncdl $ ST @=>  last;  

//STSYNCLPF stsynclpf;
//stsynclpf.freq(3*100 /* Base */, 6 * 100 /* Variable */, 6. /* Q */);
//stsynclpf.adsr_set(.4 /* Relative Attack */, .0/* Relative Decay */, 1. /* Sustain */, .2 /* Relative Sustain dur */, 0.4 /* Relative release */);
//stsynclpf.connect(t $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 

//STREV2 rev; // DUCKED
//rev.connect(last $ ST, .3 /* mix */);      rev $ ST @=>  last; 

// WAIT seq to start
10::ms => now;

REC rec;
//rec.rec(8*data.tick, "test.wav", 0 * data.tick /* sync_dur, 0 == sync on full dur */);
rec.rec_no_sync(32*data.tick, "test8.wav"); 


//4 *  data.tick => now;

