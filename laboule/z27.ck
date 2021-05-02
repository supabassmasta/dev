
16 => int mixer;
fun void  PLOC  (){ 
   

TONE t;
t.reg(PLOC0 s0);  //data.tick * 8 => t.max; 
33::ms => t.glide;  // t.lyd(); // t.ion(); // t.mix();//
t.dor();// t.aeo(); // t.phr();// t.loc(); t.double_harmonic(); t.gypsy_minor();
// _ = pause , | = add note to current , * : = mutiply/divide bpm , <> = groove , +- = gain , () = pan , {} = shift base note , ! = force new note , # = sharp , ^ = bemol  
"*4 }c ____ ____ ____ ____ ____ 8___ ____ ____ 
       ____ ____ ____ ____ ____ 5___ ____ ____ 


" => t.seq;
1.6 * data.master_gain => t.gain;
//t.sync(4*data.tick);// t.element_sync();//  t.no_sync();//  t.full_sync(); // 1 * data.tick => t.the_end.fixed_end_dur;  // 16 * data.tick => t.extra_end;   //t.print(); //t.force_off_action();
// t.mono() => dac;//  t.left() => dac.left; // t.right() => dac.right; // t.raw => dac;
//t.adsr[0].set(2::ms, 10::ms, .2, 400::ms);
//t.adsr[0].setCurves(1.0, 1.0, 1.0); // curves: > 1 = Attack concave, other convexe  < 1 Attack convexe others concave
t.go();   t $ ST @=> ST @ last; 



//STGVERB stgverb;
//stgverb.connect(last $ ST, .1 /* mix */, 14 * 10. /* room size */, 11::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb $ ST @=>  last; 

16 * data.tick => now;
}

fun void  SLIDESERUM1  (float fstart, float fstop, dur d, float g){ 
  3::ms => dur attackRelease;

   
   ST st; st $ ST @=> ST @ last;

   STMIX stmix;
   stmix.send(last, mixer);
    //stmix.receive(11); stmix $ ST @=> ST @ last; 
    
   Step stp0 => Envelope e0 =>  SERUM1 s0 => st.mono_in;
   s0.add(0 /* synt nb */ , 0 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  2 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 
   s0.add(46 /* synt nb */ , 3 /* rank */ , 0.4 /* GAIN */, 1.001 /* in freq gain */,  2 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, 3* data.tick /* release */ ); 


   fstart => e0.value;
   fstop => e0.target;
   d => e0.duration ;// => now;
   
   1.0 => stp0.next;
   
   g => st.gain;

   s0.on();

   d => now;

   s0.off();
   attackRelease => now;
    
} 

//spork ~  SLIDESERUM1(2000 /* fstart */, 100 /* fstop */, 16* data.tick /* dur */,  .11 /* gain */); 

//////////////////////////////////////////////////////////////////////////////////////////////////
// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .6);  ech $ ST @=>  last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .2 /* span 0..1 */, data.tick * 1 / 2 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

//////////////////////////////////////////////////////////////////////////////////////////////////
SYNC sy;
//sy.sync(4 * data.tick);
sy.sync(16 * data.tick , -4.0*data.tick /* offset */); 
LAUNCHPAD_VIRTUAL.off.set(82); // TRIBAL


spork ~  SLIDESERUM1(100 /* fstart */, 2000 /* fstop */, 4* data.tick /* dur */,  .09 /* gain */); 
  3 * data.tick => now;

LAUNCHPAD_VIRTUAL.on.set(55); // Thunder
  spork ~   PLOC (); 

  16 * data.tick => now;

LAUNCHPAD_VIRTUAL.off.set(55); // Thunder

LAUNCHPAD_VIRTUAL.on.set(48); // Trip hop


while(1) {
    4 * data.tick => now;
}
 
