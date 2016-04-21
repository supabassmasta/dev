
class synt0 extends SYNT{

    inlet => SinOsc s =>ABSaturator sat =>  outlet;   
        .1 => s.gain;

26 => sat.drive;
4 => sat.dcOffset;


    SinOsc mod => s;
    4 => mod.gain;
    7 => mod.freq;

    SinOsc mod0 => s;
    4 => mod0.gain;
    10 => mod0.freq;

            fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {   }
} 


lpk25 l;
GLIDE g;
l.reg(g);
g.reg(synt0 s);

while(1) {
	     100::ms => now;
}
		
