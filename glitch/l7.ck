class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet;   
        .5 => s.gain;

            fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {   }
} 

TONE t;

t.reg(synt0 s1);
//60::ms => t.glide;
//data.tick * 7 => t.max; 
 // t.lyd(); t.ion(); t.mix();t.dor();t.aeo(); t.phr();t.loc();
"*2 01010101 " => t.seq;
  t.lyd(); 
" 0123456 " => t.seq;
  t.ion(); 
" 0123456 " => t.seq;
  t.mix();
" 0123456 " => t.seq;
 t.dor();
" 0123456 " => t.seq;
 t.aeo(); 
" 0123456 " => t.seq;
t.phr();
" 0123456 " => t.seq;
t.loc();
" 0123456 " => t.seq;
//t.element_sync();
//t.print();
t.go();

while(1) {
       100::ms => now;
}
 

