class SERUM3 extends SYNT{
  0 => int chunk_nb;
  inlet =>SERUM2 s0 => outlet;
  inlet =>SERUM2 s1 => outlet;

  1. => s0.outlet.gain;
  0. => s1.outlet.gain;

  fun void set_pos(float p) {
    if ( chunk_nb > 1 ){
      (p * chunk_nb ) $ int => int c;
      p * chunk_nb - c => float rest;
      if ( c < 0  ){
        s0.set_chunk(0);
        s1.set_chunk(0);
        1. => s0.outlet.gain;
        0. => s1.outlet.gain;
      }
      else if ( c >= chunk_nb - 1 ){
        s0.set_chunk(chunk_nb - 1);
        s1.set_chunk(chunk_nb - 1);
        0. => s0.outlet.gain;
        1. => s1.outlet.gain;
      }
      else {
        s0.set_chunk(c );
        s1.set_chunk(c + 1);
        1 - rest => s0.outlet.gain;
        rest => s1.outlet.gain;
      }
    }
  }

  fun void config(int wn /* wave number */) {
    s0.config(wn);
    s1.config(wn);

    s0.chunk_nb => chunk_nb;
  }

  Gain in ;

  fun void  control_update  (dur d){ 
    in => blackhole;
    spork ~  _control_update (d); 
  } 

  fun void  _control_update (dur d){ 
    while(1) {
      set_pos( in.last() );
      d => now;
    }


  } 


  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 



3 => int n;
0.67 => float i;
( i * (n) ) $ int => int res;
i* (n) - res => float p;
<<<"RES", res, "pos", p>>>;

1::ms => now;


TONE t;
t.reg(SERUM3 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.config(80 /* synt nb */ );
// => s0.in; s0.control_update(10::ms); 
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" 1" => t.seq;
.7 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STEPC stepc; stepc.init(HW.lpd8.potar[1][1], 0 /* min */, 1 /* max */, 50::ms /* transition_dur */);
stepc.out => s0.in; s0.control_update(10::ms);

SinOsc sin0 =>  s0.in;
1.0 => sin0.freq;
0.01 => sin0.gain;


STEPC stepc0; stepc0.init(HW.lpd8.potar[1][2], 100 /* min */, 3000 /* max */, 50::ms /* transition_dur */);
stepc0.out => s0.inlet;  

while(1) {
       100::ms => now;
}
 
