TONE t;

19 => int conf;
3=> int rank;

t.reg(SERUM0 s0); s0.config( conf, rank);
t.reg(SERUM0 s1); s1.config( conf, rank);
t.reg(SERUM0 s2); s2.config( conf, rank);
t.reg(SERUM0 s3); s3.config( conf, rank);
//data.tick * 8 =  > t.max; //60::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
/*
_1|3|5|7  
_1|3|5|7  
_1|3|5|7  
_B|0|2  
_1|3|5|7  
_1|3|5|7  
_1|3|5|7  
_B|0|2|c  

_1|3|5|8  
_1|3|5|7  
_1|3|5|7  
_B|0|2 
_1|3|5|8  
_1|3|5|7  
_1|3|5|7  
_B|0|2|c




*/

" {5 }c}c

_1|3|5|8  
_1|3|5|7  
_B|0|2 
__
_1|3|5|8  
_1|3|5|7  
_B|0|2|c
__

" => t.seq;
.21 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;

2 *10::ms => dur a;
10 * 10::ms => dur d;
.00001 => float s;
10::ms => dur r;

t.adsr[0].set(a,d ,s, r);
t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.adsr[1].set(a,d ,s, r);
t.adsr[1].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.adsr[2].set(a,d ,s, r);
t.adsr[2].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.adsr[3].set(a,d ,s, r);
t.adsr[3].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 1 / 4 , .5);  ech $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .2 /* mix */, 6 * 10. /* room size */, 5::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
