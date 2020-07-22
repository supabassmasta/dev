TONE t;
t.reg(SERUM0 s0); s0.config(23, 0);  //data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*8 8_3_5_1_ " => t.seq;
.4 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 


STCUTTER stcutter;
" *2 11__ ____ 111_ ____" => stcutter.t.seq;
stcutter.connect(last, 3::ms /* attack */, 3::ms /* release */ );   stcutter $ ST @=> last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

ARP arp;
arp.t.dor();
50::ms => arp.t.glide;
"*4  1538 3851 0083 B " => arp.t.seq;
arp.t.go();   

// CONNECT SYNT HERE
3 => s0.inlet.op;
arp.t.raw() => s0.inlet; 


// MOD ////////////////////////////////

SinOsc mod => SinOsc s => OFFSET o => s0.inlet;
1::second / (13 * data.tick) => s.freq;

.2 => mod.freq;

1.2 => o.offset;
.7 => o.gain;

// MOD ////////////////////////////////


while(1) {
       100::ms => now;
}
 
