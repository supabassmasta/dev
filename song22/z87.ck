class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet; 
      .8 => s.gain;

        fun void on()  { }  fun void off() { }  fun void new_note(int idx)  { } 0 => own_adsr;
} 

lpk25 l;
POLY synta; 
l.reg(synta);
synta.reg(synt0 s0);  synta.a[0].set(6::ms, 22::ms, .3, 400::ms);
synta.reg(synt0 s1);  synta.a[1].set(6::ms, 22::ms, .3, 400::ms);
synta.reg(synt0 s2);  synta.a[2].set(6::ms, 22::ms, .3, 400::ms);
synta.reg(synt0 s3);  synta.a[3].set(6::ms, 22::ms, .3, 400::ms); 

synta $ ST @=> ST @ last; 


STGVERB stgverb;
stgverb.connect(last $ ST, .06 /* mix */, 8 * 10. /* room size */, 8::second /* rev time */, 0.1 /* early */ , 0.3 /* tail */ ); stgverb $ ST @=>  last; 

//STREV1 rev;
//rev.connect(last $ ST, .1 /* mix */);     rev  $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
