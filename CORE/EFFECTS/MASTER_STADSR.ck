class END_MA extends end {
  STADSR @ sta;
  int g;
  fun void kill_me () {
//  <<<"REMOVE STADSR">>>;

  MASTER_STADSR.unreg(sta, g);
}}; 

public class MASTER_STADSR {
  static STADSR @ list[0][0];
  static int   state[];

  fun static void reg (STADSR @ in, int group) {  
    //    <<<"list.size()", list.size()>>>;
    
    if (list.size() <= group) {
      // group doesn't exist
      list.size() => int old_size;
      // increase list size till group number
      group + 1 => list.size ;
      // Allocate array for all new groups created
      for (old_size => int i; i <  list.size(); i++) {
        new STADSR [0] @=> list[i];
      }
    }

    if (state.size() <= group) {
      state.size() => int old_size;
      group + 1  => state.size;
      // initialize state for all new states created
      for (old_size => int i; i <  state.size(); i++) {
        0 => state[i];
      }
    }
    //    <<<"list.size()", list.size()>>>;
    //    <<<"list[0].size()", list[0].size()>>>;
    list[group] << in;
    //    <<<"list[0].size()", list[0].size()>>>;
    END_MA the_end; me.id() => the_end.shred_id; killer.reg(the_end);  
    in @=> the_end.sta;
    group => the_end.g;
    1 => the_end.no_remove;

    if ( state[group] ){
       in.keyOn(); 
    }
    else {
       in.keyOff(); 
    }
  }
  
  fun static void unreg (STADSR @ in, int g) {  
     if (list.size() > g) {
        -1 => int idx;

        for (0 => int i; i <  list[g].size(); i++) {
          if ( list[g][i] == in  ){
              i => idx; 
          }
        }
        if ( idx != -1  ){
          //   <<<"found STADSR">>>;
          for (idx => int i; i < list[g].size() - 1     ; i++) {
            list[g][i+1] @=> list[g][i];
          }

          list[g].size() -1 => list[g].size;
        }
         
     }

  }
  
  fun static void keyOn(int g) {
    if (state.size() <= g) {
      // Group not created yet
      state.size() => int old_size;
      // increase list size till group number
      g + 1  => state.size;
      // initialize state for all new states created, current gropu initialized bellow
      for (old_size => int i; i <  state.size(); i++) {
        0 => state[i];
      }
    }
    if (list.size() > g) {
      for (0 => int i; i < list[g].size()  ; i++) {
        list[g][i].keyOn();
      }
    }
    // update state anyway
    1 => state[g];
  }

  fun static void keyOff(int g) {
    if (state.size() <= g) {
      // Group not created yet
      state.size() => int old_size;
      // increase list size till group number
      g + 1  => state.size;
      // initialize state for all new states created
      for (old_size => int i; i <  state.size(); i++) {
        0 => state[i];
      }
    }
    if (list.size() > g) {
      for (0 => int i; i < list[g].size()  ; i++) {
        list[g][i].keyOff();
      }
    }
    // update state anyway
    0 => state[g];
  }

}

 STADSR  list[0][0] @=> MASTER_STADSR.list;
int dummy_state[0] @=> MASTER_STADSR.state;
 while(1) {
        1::week => now;
 }
  
