public class END_CONTROL extends end { 
     CONTROLER @ controler;
     CONTROL @ control;
     1 => no_remove; 

     fun void kill_me () {
       if ( controler != NULL && control != NULL ){
         controler.unreg(control);
       }
     }  
  
    fun void conf(end @ e, CONTROLER @ ctler, CONTROL @ ctl) {
      ctler @=> controler;
      ctl @=> control;
      
      me.id() => e.shred_id;
      killer.reg(e);
    } 
  }
