class END_MA extends end {
  STADSR @ sta;
  fun void kill_me () {
  <<<"REMOVE STADSR">>>;

  MASTER_STADSR.unreg(sta, 0);
}}; 
public class MASTER_STADSR {
  static STADSR @ list[0][0];

  fun static void reg (STADSR @ in, int group) {  
    <<<"list.size()", list.size()>>>;
    
    if (list.size() <= group) {
      group + 1 => list.size;
      new STADSR [0] @=> list[group];
    }
    <<<"list.size()", list.size()>>>;
    <<<"list[0].size()", list[0].size()>>>;
    list[group] << in;
    <<<"list[0].size()", list[0].size()>>>;
    END_MA the_end; me.id() => the_end.shred_id; killer.reg(the_end);  
    in @=> the_end.sta;
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
          <<<"found STADSR">>>;
          for (idx => int i; i < list[g].size() - 1     ; i++) {
            list[g][i+1] @=> list[g][i];
          }

          list[g].size() -1 => list[g].size;
        }
         
     }

  }
  
  fun static void keyOn(int g) {
    if (list.size() > g) {
      for (0 => int i; i < list[g].size()  ; i++) {
        list[g][i].keyOn();
      }
    }
  }

  fun static void keyOff(int g) {
    if (list.size() > g) {
      for (0 => int i; i < list[g].size()  ; i++) {
        list[g][i].keyOff();
      }
    }
  }

}

 STADSR  list[0][0] @=> MASTER_STADSR.list;

 while(1) {
        1::week => now;
 }
  
