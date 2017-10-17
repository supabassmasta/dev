AMBIENT2 s1;
s1.load(28);
AMBIENT2 s2;
s2.load(28);
AMBIENT2 s3;
s3.load(28);



TONE t;
t.reg(s1); t.reg(s2); t.reg(s3);//data.tick * 8 => t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
" :2
1|!3 1|3 !5|!8 !3|8
1|!3 1|3 !4|!9 !7|9
" => t.seq;
.3 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go(); 

STAUTOPAN autopan;
autopan.connect(t $ ST, .6 /* span 0..1 */, 4*data.tick /* period */, 0.95 /* phase 0..1 */ );  

STECHO ech;
ech.connect(autopan $ ST , data.tick * 3 / 1 , .4); 



STREV1 rev;
rev.connect(ech $ ST, .2/* mix */); 

ST st;

// filter to add in graph:
// LPF filter =>   BPF filter
ech.mono() =>   BPF filter => st.mono_in;
Step base => Gain filter_freq => blackhole;
Gain mod_out => Gain variable => filter_freq;
SinOsc mod =>  mod_out; Step one => mod_out; 1=> one.next; .5 => mod_out.gain;

1.5 =>filter.gain;

// params
4 => filter.Q;
161 => base.next;
551 => variable.gain;
1::second / (data.tick * 4 ) => mod.freq;
// If mod need to be synced
// 1 => int sync_mod;
// if (idx == 0) { if (sync_mod) { 0=> sync_mod; 0.0 => mod.phase; } }

fun void filter_freq_control (){ 
	    while(1) {
				      filter_freq.last() => filter.freq;
							      1::ms => now;
										    }
}
spork ~ filter_freq_control (); 


STAUTOPAN autopan2;
autopan2.connect(st $ ST, .6 /* span 0..1 */, 3*data.tick /* period */, 0.95 /* phase 0..1 */ );  



while(1) {
       100::ms => now;
}
 

