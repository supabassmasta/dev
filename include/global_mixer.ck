public class global_mixer {
   static Gain @ line1;
   static Gain @ line2;
   static Gain @ line3 ;
   static Gain @ line4 ;
   static Gain @ line5 ;
   static Gain @ line6 ;
   static Gain @ line7 ;
   static Gain @ line8 ;
   static Gain @ line9 ;
   static Gain @ line10;

   static Gain @ stereo1;
   static Gain @ stereo2;

   static Gain @ kick_freez_in;
   static Gain @ kick_freez_out;

   static Gain @ rev0;
   static Gain @ rev1_right;
   static Gain @ rev1_left;
   static Gain @ rev2_right;
   static Gain @ rev2_left;
   
   static Event @ duck_trig;

   static Dyno @ stduck_l;
   static Dyno @ stduck_r;
}

   Gain bar1 @=> global_mixer.line1;
   Gain bar2 @=> global_mixer.line2;
   Gain bar3 @=> global_mixer.line3;
   Gain bar4  @=> global_mixer.line4 ;
   Gain bar5  @=> global_mixer.line5 ;
   Gain bar6  @=> global_mixer.line6 ;
   Gain bar7  @=> global_mixer.line7 ;
   Gain bar8  @=> global_mixer.line8 ;
   Gain bar9  @=> global_mixer.line9 ;
   Gain bar10 @=> global_mixer.line10;
   
   Gain bar11 @=> global_mixer.kick_freez_in;
   Gain bar12 @=> global_mixer.kick_freez_out;
   
   Gain bar13 @=> global_mixer.stereo1;
   Gain bar14 @=> global_mixer.stereo2;

   
   Event bar15 @=> global_mixer.duck_trig;
   
   Gain bar16 @=> global_mixer.rev0;
   Gain bar17 @=> global_mixer.rev1_right;
   Gain bar18 @=> global_mixer.rev1_left;
   Dyno bar19 @=> global_mixer.stduck_l;
	 bar19 => dac.left;
   Dyno bar20 @=> global_mixer.stduck_r;
	 bar20 => dac.right;
   Gain bar21 @=> global_mixer.rev2_right;
   Gain bar22 @=> global_mixer.rev2_left;

while(1) 1000::ms => now;
