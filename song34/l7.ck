class COUNTDOWN {
  fun void  _start  (dur d, dur step){ 
    SYNC sy;
    sy.sync(step);
    d - (now - data.wait_before_start)%d => dur remaining;
    ( remaining / step ) => float count_f;
    // Add 0.1 to be sure count_f is just above integer value
    // If not done, the cast gives sometimes a count minus 1.
    (count_f  + 0.1)$ int => int count;
    // <<<"count_f ", count_f, " count ", count>>>;

    while(count > -1) {
      <<<"********************">>>; 
      <<<"***      " + count + "      ****">>>; 
      <<<"********************">>>; 

      1 -=> count;
      step => now;
    }
  } 

  fun void start (dur d, dur step){ 
    spork ~   _start (d, step); 
  }
}
//sy.sync(4 * data.tick , 0::ms /* offset */); 
//<<<"$$$ TEST $$$$: ", 11.5::ms/1::ms>>>;


COUNTDOWN countdown;
countdown.start(8*data.tick, 2*data.tick);

SYNC sy;
sy.sync(8 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 

<<<"GO">>>;
10000::ms=> now;

