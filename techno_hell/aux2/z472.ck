10 => int n;
0 => int m;

TONE t;
t.reg(SERUM0 s0); s0.config(n,m);

//data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4  }c
8_h/G_ 1_1/G_ 0!3!1_ 3_*25151:2
1_3_ 8!1/8__ *4 5!1!0!2 :4_G/d_ 1!8!5!8

" => t.seq;
.5 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

ARP arp;
arp.t.dor();
50::ms => arp.t.glide;
"*4 1538158  " => arp.t.seq;
arp.t.go();   

// CONNECT SYNT HERE
3 => s0.inlet.op;
arp.t.raw() => s0.inlet; 



STSYNCLPF stsynclpf;
stsynclpf.freq(100 /* Base */, 13 * 100 /* Variable */, 2. /* Q */);
stsynclpf.adsr_set(.1 /* Relative Attack */, .3/* Relative Decay */, .000001 /* Sustain */, .1 /* Relative Sustain dur */, 0.1 /* Relative release */);
stsynclpf.connect(last $ ST, t.note_info_tx_o); stsynclpf $ ST @=>  last; 

//STECHO ech;
//ech.connect(last $ ST , data.tick * 3 / 4 , .4);  ech $ ST @=>  last; 

//STGVERB stgverb;
//stgverb.connect(last $ ST, .06 /* mix */, 3 * 10. /* room size */, 1::second /* rev time */, 0.1 /* early */ , 0.1 /* tail */ ); stgverb $ ST @=>  last; 

//STFADEIN fadein;
//fadein.connect(last, 32*data.tick);     fadein  $ ST @=>  last; 

ST st;
TriOsc tri => st.mono_in;
40 => tri.gain;
4 => tri.freq;


st @=> last;

STCUTTER stcutter;
" __1__1___11____1__" => stcutter.t.seq;
stcutter.connect(last, 3::ms /* attack */, 3::ms /* release */ );   stcutter $ ST @=> last; 

last.mono() => Gain add => s0.inlet;
Step ste => add;
1 => ste.next;

while(1) {
       100::ms => now;
}
 
