class synt0 extends SYNT{
    inlet => Gain in;
    Gain out =>  outlet;   

    0 => int i;
    Gain opin[8];
    Gain opout[8];
    PowerADSR adsrop[8];
    TriOsc osc[8];

    // build and config operators
    //---------------------
    opin[i] => SinOsc s => adsrop[i] => opout[i];
    1. => opin[i].gain;
    adsrop[i].set(1::ms, 380::ms, .1 , 200::ms);
    adsrop[i].setCurves(.6, .4, .3); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
    1 => adsrop[i].gain;
//    .5 =>osc[i].width;
    i++;

    //---------------------
    opin[i] => osc[i] => adsrop[i] => opout[i];
    1./3. + 0.03 => opin[i].gain;
    adsrop[i].set(3::ms, data.tick/4, .00001 , 200::ms);
    adsrop[i].setCurves(.2, 2, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
    10 * 7 => adsrop[i].gain;
    .8 =>osc[i].width;
    i++;

    //---------------------
    opin[i] => osc[i] => adsrop[i] => opout[i];
    1./8. +0.0 => opin[i].gain;
    adsrop[i].set(100::ms, 186::ms, .5 , 1800::ms);
    adsrop[i].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
    8 => adsrop[i].gain;
    .5 =>osc[i].width;
    i++;

    //---------------------
    opin[i] => osc[i] => adsrop[i] => opout[i];
    1./2. +0.000 => opin[i].gain;
    adsrop[i].set(200::ms, 186::ms, .2 , 400::ms);
    adsrop[i].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
    30 => adsrop[i].gain;
    .5 =>osc[i].width;
    i++;

    // connect operators
    // main osc
    in => opin[0]; opout[0]=> out; 

    // modulators
    in => opin[1];
    opout[1] => opin[0];

    in => opin[2];
    // opout[2] => opin[0];

    in => opin[3];
    // opout[3] => opin[0];


    .5 => out.gain;

    fun void on()  
    {
            
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
      for (0 => int i; i < 8      ; i++)
      {
            adsrop[i].keyOn();
                // 0=> osc[i].phase;
      }
                         
            }
}  

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; 
6::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"  
{c *8 
1111111111111111
4444000055558888
1111111111111111
4444000055558888
1111111111111111
4444000055558888
1111111111111111
4444000055558888

1111111111111111
4444000055558888
1111111111111111
4444000055558888
1111111111111111
444400005dacg888
1111f1111f1f11f1
4444000055558888
1111111111111111

4444000055558888
1111111111111111
4444000055558888
1111a11c111c1111
4444000055c5f888
1111111111111111
4444000055558888

1111111111111111
4444000055558888
1111111111111111
444400e055558888
1111111111111111
4444000fafadcc88
1111111111111111
44440000f55f8888
" => t.seq;
1.2 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
t.adsr[0].set(2::ms, 10::ms, .8, 100::ms);
t.adsr[0].setCurves(1.0, 1.0, 2.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go(); 


while(1) {
       100::ms => now;
}
 

