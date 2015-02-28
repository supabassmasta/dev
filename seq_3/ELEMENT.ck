public class ELEMENT {
  dur duration; // duration of the event
  0=>int  duration_validity;

  time next_time;
  0=>int  next_time_validity;
  float rel_pos; // relative position in the sequence
  0=>int rel_pos_validity ;
  dur rel_time; // relative time form the begining

  ACTION actions[0];


}
