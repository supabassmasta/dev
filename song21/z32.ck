class filter0 extends SYNT{
  1::samp => dur refresh;

  inlet => blackhole;

  STDIGIT stdigit;

  fun void f1 (){ 
    dur e;
    float i;
    while(1) {
      inlet.last() => i;
      if (i == 0)
        1::samp => e;
      else if (  i > 10000  ){
        1::samp => e;
      }
      else
        1::second / inlet.last() => e;
      e => stdigit.digl.ech =>  stdigit.digr.ech;
//      1::ms => stdigit.digl.ech =>  stdigit.digr.ech;
      e => now;
    }


  } 
  spork ~ f1 ();

fun void f2 (){ 

while(1) {
       <<<"stdigit.digl.ech", stdigit.digl.ech / 1::ms, " ms">>>;

       1000::ms => now;
}
 
   } 
   spork ~ f2 ();
    

  fun void  connect (ST @ in){
    stdigit.connect(in , 1::samp /* ech */ , 0.0 /* quant */  );   
  }

  fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE tone_filter;
tone_filter.reg(filter0 filt0);  //data.tick * 8 => tone_filter.max; //60::ms => tone_filter.glide;  // tone_filter.lyd(); // tone_filter.ion(); // tone_filter.mix();// 
tone_filter.dor();// tone_filter.aeo(); // tone_filter.phr();// tone_filter.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c}c
*2*8

zzzz zzzz zzzz zzzz 
zzzz zzzz zzzz zzzz 
zzzz zzzz zzzz {c0518}c 
zzzz zzzz {c9158 }c zzzz 
zzzz zzzz zzzz zzzz 
zzzz zzzz zzzz zzzz 
zzzz z4zz zz55 zzzz 
zzzz zzzz 23zz z45z 
zzzz zzzz zzzz zzzz 
zzzz zzzz zzzz 1////8 
zzzz zzzz zzzz 8////1
zzzz zzzz zzzz zzzz 

" => tone_filter.seq;
.9 * data.master_gain => tone_filter.gain;
//tone_filter.sync(4*data.tick);// tone_filter.element_sync();//  tone_filter.no_sync();//  tone_filter.full_sync();  // 16 * data.tick => tone_filter.extra_end;   //tone_filter.print(); //tone_filter.force_off_action();
// tone_filter.mono() => dac;//  tone_filter.left() => dac.left; // tone_filter.right() => dac.right; // tone_filter.raw => dac;
tone_filter.adsr[0].set(20::ms, 0::ms, 1., 400::ms);
tone_filter.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
tone_filter.go();   tone_filter $ ST @=> ST @ last; 

//////////////////////////////////////////////
//            PUT YOUR SYNT/SEQ HERE :       //
//            Beware of "last" declaration  //


class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .5 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s1);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"}c *6
1818B150
" => t.seq;
.9 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=>  last; 


//////////////////////////////////////////////

filt0.connect(last); filt0.stdigit $ ST @=> last; 


while(1) {
       100::ms => now;
}
 
