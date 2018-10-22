public class note_info_tx {
    note_info_rx rxs[0];

    fun void reg(note_info_rx @ in){
      rxs << in;
    }

    fun void push_to_all(note_info_t @ ni) {
      for (0 => int i; i <  rxs.size() ; i++) {
        rxs[i].push(ni);      
      }
    }
}
