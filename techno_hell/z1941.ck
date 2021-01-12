140 => data.bpm;   (60.0/data.bpm)::second => data.tick;
53 => data.ref_note;


18 => int mixer;

fun void  SLIDESERUM1  (float fstart, float fstop, dur d, float g){ 
  1 * data.tick => dur attackRelease;

   
   ST st; st $ ST @=> ST @ last;

   STMIX stmix;
   stmix.send(last, mixer);
    //stmix.receive(11); stmix $ ST @=> ST @ last; 
    
   Step stp0 => Envelope e0 =>  SERUM1 s0 => st.mono_in;
   s0.add(23 /* synt nb */ , 2 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  8 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */, attackRelease /* release */ ); 
   s0.add(14 /* synt nb */ , 2 /* rank */ , 0.4 /* GAIN */, 1.0 /* in freq gain */,  0 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */,3* data.tick /* release */ ); 
   s0.add(14 /* synt nb */ , 2 /* rank */ , 0.4 /* GAIN */, 1.001 /* in freq gain */,  0 * data.tick /* attack */, 0 * data.tick /* decay */, 1. /* sustain */,3* data.tick /* release */ ); 

SinOsc sin0 =>  s0.sl[0].inlet;
10.0 => sin0.freq;
60.0 => sin0.gain;



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





// OUTPUT

STMIX stmix;
stmix.receive(mixer); stmix $ ST @=> ST @ last; 

STAUTOPAN autopan;
autopan.connect(last $ ST, .2 /* span 0..1 */, data.tick * 3 / 4 /* period */, 0.95 /* phase 0..1 */ );       autopan $ ST @=>  last; 

STECHO ech;
ech.connect(last $ ST , data.tick * 3 / 4 , .8);  ech $ ST @=>  last; 



SYNC sy;
sy.sync(4 * data.tick);
//sy.sync(16 * data.tick , -8 * data.tick /* offset */); 

WAIT w;
8 *data.tick => w.fixed_end_dur;


    spork ~  SLIDESERUM1(2000 /* fstart */, 37 /* fstop */, 16* data.tick /* dur */,  .11 /* gain */); 
    
    8 * data.tick =>  w.wait; 
    
    LONG_WAV l;
    "../_SAMPLES/CostaRica/processed/ZOOM0014_Processed.wav" => l.read;
    0.4 * data.master_gain => l.buf.gain;
    0 => l.update_ref_time;
    l.AttackRelease(8 * data.tick , 8 * data.tick);
    l.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disable) */ , 0 * data.tick /* END sync */); l $ ST @=>  last;  
    
    8 * data.tick =>  w.wait; 
    
    LONG_WAV l2;
    "../_SAMPLES/Kecak/chants.wav" => l2.read;
    0.7 * data.master_gain => l2.buf.gain;
    0 => l2.update_ref_time;
    l2.AttackRelease(3::ms , 3::ms);
    l2.start(4 * data.tick /* sync */ , 0 * data.tick  /* offset */ , 0 * data.tick /* loop (0::ms == disabl2e) */ , 0 * data.tick /* END sync */); l2 $ ST @=>  last;  
    
    
    
    32::second =>  w.wait; 
    spork ~ l.the_end.kill_me();

spork ~  SLIDESERUM1(37 /* fstart */, 2000 /* fstop */, 12* data.tick /* dur */,  .17 /* gain */); 


16 * data.tick =>  w.wait; 

MASTER_SEQ3.update_ref_times(now - 16 * data.tick + 1::samp, data.tick * 16 * 128 );

LAUNCHPAD_VIRTUAL.on.set(1911);
.25 * data.tick =>  w.wait;
LAUNCHPAD_VIRTUAL.on.set(1912);
LAUNCHPAD_VIRTUAL.on.set(1921);

15.5 * data.tick =>  w.wait;
LAUNCHPAD_VIRTUAL.on.set(1914);
 
4 * data.tick => now;
LAUNCHPAD_VIRTUAL.off.set(1941); // AUTO OFF
1 * data.tick => now;

