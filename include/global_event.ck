public class global_event {

   static Event @ e1;
   static Event @ e2;
   static Event @ e3;
   static Event @ e4;
   static Event @ e5;

   static dur   tick;
   
   // Launcher hold mode
   static Event @ hold_event;
   static int hold_shred_id;
   
   
   
}

Event bar1 @=> global_event.e1 ;
Event bar2 @=> global_event.e2 ;
Event bar3 @=> global_event.e3 ;
Event bar4 @=> global_event.e4 ;
Event bar5 @=> global_event.e5 ;
Event bar6 @=> global_event.hold_event ;
//100::ms => dur foo @=> global_event.tick;

   while(1) 1000::ms => now;
