public class LPD8_CONTROLLER extends lpd8 {

  CONTROLER  pad[5][9];
  CONTROLER  potar[5][9];

  fun void potar_ext (int group_no, int pad_nb, int val) {
    if (group_no < 175 || group_no > 179 || pad_nb < 1 || pad_nb > 8)
      <<<"ERROR LPD8 mode not managed in lpd8_master class">>>; 
    else
      potar[group_no - 175][pad_nb].set(val);
  }

  fun void pad_ext (int group_no, int pad_nb, int val) {
    if (group_no < 144 || group_no > 148 || pad_nb < 36 || pad_nb > 44)    
      <<<"ERROR LPD8 mode not managed in lpd8_master class">>>; 
    else
      pad[group_no - 144][pad_nb-36].set(val);
  }

}
