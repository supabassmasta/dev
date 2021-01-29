public class SERUM3 extends SYNT{
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


