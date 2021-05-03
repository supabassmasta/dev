public class MASTER_STADSR {
  static STADSR @ list[0][0];

  fun static void reg (STADSR @ in, int group) {  
    <<<"list.size()", list.size()>>>;
    
    if (list.size() <= group) {
      group + 1 => list.size;
    }
    <<<"list.size()", list.size()>>>;
    <<<"list[0].size()", list[0].size()>>>;
    list[group] << in;
  }
  
  fun static void keyOn(int g) {
    if (list.size() <= g) {
      for (0 => int i; i < list[g].size()  ; i++) {
        list[g][i].keyOn();
      }
    }
  }

  fun static void keyOff(int g) {
    if (list.size() <= g) {
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
  
