SEQ s;
SET_WAV.DUBSTEP(s);
s.element_sync();
//data.tick * 8 => s.max;
"*1 k_s_ " => s.seq;
//"(9f)9d" => s.seq;
s.go();
//s.left() => NRev rev =>   dac.left;
//s.right() => NRev rev2 =>  dac.right;
//.1=> rev.mix;
//.1=> rev2.mix;

class synt0 extends SYNT{

    inlet => SqrOsc s => LPF f => outlet;   
    1000 => f.freq;
    .9 => s.width;
        .5 => s.gain;

            fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {   }
            } 


TONE t;

t.reg(synt0 s1);
8 * data.tick => t.max;
t.seq("{c 0_0__a/0_d *8*2 decjppj__erf_gr___");
t.seq("__8_32__8_32__8_32__8_32__8_32__8_32_ "); 
t.seq(":8:2 0_0__a/0_ *8*2 decjppj__erf_gr___");
//t.seq("{c 0_0__a/0_ *8*2 decjppj__erf_gr___:8:8:8 _");
t.seq("{c 0 ");
//t.seq("{c 0_0__a/0_ g ");
t.element_sync();

t.go();

while(1) {  100::ms => now; }
