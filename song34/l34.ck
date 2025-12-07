public class SERUM1t extends SYNT{

  ADSR @ al[0];
  SERUM0 @ sl[0]; // to access synt after, to hack it
  SYNT @ syntl[0]; // to access synt after, to hack it

  fun void  add(int n, int k, float g, float ifg, dur  at, dur d, float su, dur r ){ 

    new  Gain   @=> Gain @ i ;
    new  SERUM0 @=>SERUM0 @ s; 
    new  ADSR  @=> ADSR @ a ; 
    inlet =>  i =>  s =>  a  => outlet; 
    g => s.outlet.gain;
    ifg => i.gain;
    s.config(n, k);
    a.set(at, d, su, r);
    al << a;
    sl << s;
  } 

  fun void  add(SYNT @ in, float g, float ifg, dur  at, dur d, float su, dur r ){ 
    new  Gain   @=> Gain @ i ;
    new  ADSR  @=> ADSR @ a ; 
    inlet =>  i => in=>  a  => outlet; 
    g => in.outlet.gain;
    ifg => i.gain;
    a.set(at, d, su, r);
    al << a;
    syntl << in;
  } 

  fun void on()  { 
    for (0 => int i; i < al.size() ; i++) {
      al[i].keyOn();
    }
    for (0 => int i; i < syntl.size() ; i++) {
      syntl[i].on();
    }

  }

  fun void off() { 
    for (0 => int i; i < al.size() ; i++) {
      al[i].keyOff();
    }
    for (0 => int i; i < syntl.size() ; i++) {
      syntl[i].off();
    }
  } 

  fun void new_note(int idx)  {
    on();  
    for (0 => int i; i < syntl.size() ; i++) {
      syntl[i].new_note(idx);
    }
  }

  1 => own_adsr;
} 

TONE t;
t.reg(SERUM1t s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
s0.add(3 /* synt nb */ , 0 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  10::ms /* attack */, 10::ms /* decay */, 1. /* sustain */, 3* data.tick /* release */ );
// s0.add(synt0 /* SYNT, to declare outside */, 0.4 /* GAIN */, 1.5 /* in freq gain */,  0 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 

t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c 1_" => t.seq;
.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.set_adsrs(2::ms, 10::ms, .2, 400::ms);
//t.set_adsrs_curves(2.0, 2.0, 0.5); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
1 => t.set_disconnect_mode;
t.go();   t $ ST @=> ST @ last; 


while(1) {
       100::ms => now;
}
 
