/*
class AMB0 extends SYNT{

  AMBIENT2 s0;
  s0.load(27);

  inlet => Gain gin => s0  => ADSR a =>  outlet;   

  .5 => a.gain;
  a.set(2000::ms, 10::ms, 1., 4000::ms);

  .25 => gin.gain;

  fun void on()  {s0.on(); a.keyOn(); }  fun void off() {s0.off(); a.keyOff(); }  fun void new_note(int idx)  {   } 

  1 => own_adsr;
} 

class AMB1 extends SYNT{

  AMBIENT2 s0;
  s0.load(4);

  inlet => Gain gin => s0  => ADSR a =>  outlet;   

  .5 => a.gain;
  a.set(2000::ms, 10::ms, 1., 4000::ms);

  .25 => gin.gain;

  fun void on()  {s0.on(); a.keyOn(); }  fun void off() {s0.off(); a.keyOff(); }  fun void new_note(int idx)  {   } 

  1 => own_adsr;
} 

class AMB2 extends SYNT{

  AMBIENT2 s0;
  s0.load(3);

  inlet => Gain gin => s0  => ADSR a =>  outlet;   

  .5 => a.gain;
  a.set(2000::ms, 10::ms, 1., 4000::ms);

  .25 => gin.gain;

  fun void on()  {s0.on(); a.keyOn(); }  fun void off() {s0.off(); a.keyOff(); }  fun void new_note(int idx)  {   } 

  1 => own_adsr;
} 

class AMB3 extends SYNT{

  AMBIENT2 s0;
  s0.load(2);

  inlet => Gain gin => s0  => ADSR a =>  outlet;   

  .7 => a.gain;
  a.set(2000::ms, 10::ms, 1., 4000::ms);

  .25 => gin.gain;

  fun void on()  {s0.on(); a.keyOn(); }  fun void off() {s0.off(); a.keyOff(); }  fun void new_note(int idx)  {   } 

  1 => own_adsr;
} 
class AMB4 extends SYNT{

  AMBIENT2 s0;
  s0.load(24);

  inlet => Gain gin => s0  => ADSR a =>  outlet;   

  .7 => a.gain;
  a.set(2000::ms, 10::ms, 1., 4000::ms);

  .25 => gin.gain;

  fun void on()  {s0.on(); a.keyOn(); }  fun void off() {s0.off(); a.keyOff(); }  fun void new_note(int idx)  {   } 

  1 => own_adsr;
} 

class AMB5 extends SYNT{

  AMBIENT2 s0;
  s0.load(21);

  inlet => Gain gin => s0  => ADSR a =>  outlet;   

  .7 => a.gain;
  a.set(2000::ms, 10::ms, 1., 4000::ms);

  .25 => gin.gain;

  fun void on()  {s0.on(); a.keyOn(); }  fun void off() {s0.off(); a.keyOff(); }  fun void new_note(int idx)  {   } 

  1 => own_adsr;
} 
class AMB6 extends SYNT{

  AMBIENT2 s0;
  s0.load(19);

  inlet => Gain gin => s0  => ADSR a =>  outlet;   

  .7 => a.gain;
  a.set(2000::ms, 10::ms, 1., 4000::ms);

  1 => gin.gain;

  fun void on()  {s0.on(); a.keyOn(); }  fun void off() {s0.off(); a.keyOff(); }  fun void new_note(int idx)  {   } 

  1 => own_adsr;
} 

class AMB7 extends SYNT{

  AMBIENT2 s0;
  s0.load(17);

  inlet => Gain gin => s0  => ADSR a =>  outlet;   

  .7 => a.gain;
  a.set(2000::ms, 10::ms, 1., 4000::ms);

  1 => gin.gain;

  fun void on()  {s0.on(); a.keyOn(); }  fun void off() {s0.off(); a.keyOff(); }  fun void new_note(int idx)  {   } 

  1 => own_adsr;
} 

class AMB8 extends SYNT{

  AMBIENT2 s0;
  s0.load(11);

  inlet => Gain gin => s0  => ADSR a =>  outlet;   

  .7 => a.gain;
  a.set(2000::ms, 10::ms, 1., 4000::ms);

  .5 => gin.gain;

  fun void on()  {s0.on(); a.keyOn(); }  fun void off() {s0.off(); a.keyOff(); }  fun void new_note(int idx)  {   } 

  1 => own_adsr;
} 

class AMB9 extends SYNT{

  AMBIENT2 s0;
  s0.load(10);

  inlet => Gain gin => s0  => ADSR a =>  outlet;   

  .7 => a.gain;
  a.set(2000::ms, 10::ms, 1., 4000::ms);

  1. => gin.gain;

  fun void on()  {s0.on(); a.keyOn(); }  fun void off() {s0.off(); a.keyOff(); }  fun void new_note(int idx)  {   } 

  1 => own_adsr;
} 

class AMB10 extends SYNT{

  AMBIENT2 s0;
  s0.load(6);

  inlet => Gain gin => s0  => ADSR a =>  outlet;   

  .7 => a.gain;
  a.set(2000::ms, 10::ms, 1., 4000::ms);

  1. => gin.gain;

  fun void on()  {s0.on(); a.keyOn(); }  fun void off() {s0.off(); a.keyOff(); }  fun void new_note(int idx)  {   } 

  1 => own_adsr;
} 

class AMB11 extends SYNT{

  AMBIENT2 s0;
  s0.load(5);

  inlet => Gain gin => s0  => ADSR a =>  outlet;   

  .7 => a.gain;
  a.set(2000::ms, 10::ms, 1., 4000::ms);

  1. => gin.gain;

  fun void on()  {s0.on(); a.keyOn(); }  fun void off() {s0.off(); a.keyOff(); }  fun void new_note(int idx)  {   } 

  1 => own_adsr;
} 
*/
TONE t;
t.reg(AMB5 s0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
":8   _11_" => t.seq;
.8 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2000::ms, 10::ms, 1., 4000::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go(); 

STDUCK duck;
duck.connect(t $ ST); 

while(1) {
       100::ms => now;
}

