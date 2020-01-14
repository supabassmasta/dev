public class ELEMENT {
  0::ms => dur duration; // duration of the event
  0=>int  duration_validity;

  time next_time;
  0=>int  next_time_validity;
  float rel_pos; // relative position in the sequence
  0=>int rel_pos_validity ;
  dur rel_time; // relative time form the begining

  ACTION actions[0];
  ACTION on_actions[0]; // specific action called when the seq On (action to be done in on_time routine)
  ACTION off_actions[0]; // specific action called when the seq Off (action to be done in on_time routine)
  note_info_t note_info_s;

}
