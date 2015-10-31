class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet;   
        .5 => s.gain;

            fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {   }
} 

TONE t;

t.reg(synt0 s1);
//60::ms => t.glide;
//data.tick * 7 => t.max; 
"*2 0j05_ " => t.seq;
t.element_sync();
//t.print();
t.go();

while(1) {
       100::ms => now;
}
 

