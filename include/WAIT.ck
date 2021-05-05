public class WAIT {
  class END extends end { 
    0 => int trigged;
    0 => int sync_mode;
    1::ms => dur fixed_dur;    
    1::ms => dur sync_dur;    

    fun void kill_me () {
      <<<"Wait THE END">>>;  
      1 => trigged;
      if ( sync_mode  ){
         SYNC sy;
         sy.sync(sync_dur);
      }
      else {
        fixed_dur => now;  
      }
      <<<"Wait THE real END">>>;   
    }
  }

  END the_end;
  me.id() => the_end.shred_id; killer.reg(the_end);  

  fun void fixed_end_dur(dur d){
    d => the_end.fixed_dur;
  }

  fun void sync_end_dur(dur d){
    1 => the_end.sync_mode;
    d => the_end.sync_dur;
  }

  fun void wait(dur d) {
    d => now;
    if(the_end.trigged) {
      // END ongoing don't get out of wait until Real end
      while(1) {
        10000::ms => now;
      }
    }
  }

}

