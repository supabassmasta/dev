public class ELEMENT {
  time duration; // duration of the event
  int  duration_validity = 0;

  time next_time;
  int  next_time_validity = 0;
  float rel_pos; // relative position in the sequence
  int rel_pos_validity = 0;
  dur rel_time; // relative time form the begining

  ACTION actions[0];


}
