
14 => int mixer;

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
LAUNCHPAD_VIRTUAL.off.set(48); // Trip hop

spork ~  SLIDESERUM1(2000 /* fstart */, 100 /* fstop */, 4* data.tick /* dur */,  .11 /* gain */); 
  3 * data.tick => now;

LAUNCHPAD_VIRTUAL.on.set(71); // TRIBAL



while(1) {
    4 * data.tick => now;
}
 
