class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet;   
        .5 => s.gain;

            fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {   }
} 

TONE t;

t.reg(synt0 s1);
"030419eaRA" => t.seq;
t.element_sync();

t.go();

while(1) {
       100::ms => now;
}
 

