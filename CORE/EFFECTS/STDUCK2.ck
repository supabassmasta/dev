public class STDUCK2 extends ST {
   Dyno dl;
   Dyno dr;
   dl.duck();
   dr.duck();

   Gain sidein_l => blackhole;
   Gain sidein_r => blackhole;


   fun void side_process(){ 

     while(1) 
     {
       sidein_l.last() =>  dl.sideInput;
       sidein_r.last() =>  dr.sideInput;
       1::samp => now;
     }

   } 

   fun void connect(ST @ tone, float in_gain, float tresh, float slope, dur attack, dur release) {
     in_gain => sidein_l.gain;
     in_gain => sidein_r.gain;

     tresh =>   dl.thresh;
     tresh =>   dr.thresh;

     slope =>   dl.slopeAbove;
     slope =>   dr.slopeAbove;

     attack =>  dl.attackTime;
     attack =>  dr.attackTime;

     release => dl.releaseTime;
     release => dr.releaseTime;


     global_mixer.duck2_sidel => sidein_l;
     global_mixer.duck2_sider => sidein_r;

     tone.left()  => dl => outl;
     tone.right() => dr => outr; 

     spork ~ side_process();

   }

}


