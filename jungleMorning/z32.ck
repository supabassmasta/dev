class synt0 extends SYNT{

    inlet => SinOsc s =>  outlet;   
        .5 => s.gain;

            fun void on()  { }  fun void off() { }  fun void new_note(int idx)  {   } 0 => own_adsr;
} 

TONE t;
t.reg(synt0 s0);  //data.tick * 7 => t.max; 
20::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc();
16 * data.tick => t.the_end.fixed_end_dur; // _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
//" ZYXWVU TSRQPON MLKJIHG FEDCBA0 1234567 89abcde fghijkl mnopqrs tuvwxyz"
//"1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567"
 
"*8 }c}c
1_1_1_1_1_1_1_1_
1_1_1_1_1_1_1_1_
1_1_1_1_1_1_1_1_
1_1_1_1_1_1_1_1_
5_5_5_5_5_5_5_5_
5_5_5_5_5_5_5_5_
5_5_5_5_5_5_5_5_
5_5_5_5_5_5_5_5_
" => t.seq;
.4 => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync();  // 16 * data.tick => t.extra_end;   //t.print();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 

STOVERDRIVE stod;
stod.connect(last $ ST, 1.4 /* drive 1 == no drive, > 1 == drive */ ); stod $ ST @=> last; 

ARP arp;
arp.t.dor();
50::ms => arp.t.glide;
"___ *8 5B81 :8__ *8 B/8 :8  " => arp.t.seq;
16 * data.tick =>arp.t.the_end.fixed_end_dur;
arp.t.go();   

// CONNECT SYNT HERE
3 => s0.inlet.op;
arp.t.raw() => s0.inlet; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .9 /* span 0..1 */, data.tick * 8 / 1 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

STGVERB stgverb;
stgverb.connect(last $ ST, .15 /* mix */, 4 * 10. /* room size */, 1::second /* rev time */, 0.2 /* early */ , 0.6 /* tail */ ); stgverb $ ST @=>  last; 


while(1) {
       100::ms => now;
}
 
