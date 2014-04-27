public class Break extends Chubgraph{

	inlet => ADSR a => outlet;

 

 fun void set (int num) {
		if (num >= 8) <<<"ERROR only 0 to 7 break events available">>>;
		else {
				1 => data.break_state[num];
//				1 => data.break_state;
        data.break_ev[num].broadcast();
		}
 }

 fun void release (int num) {
		if (num >= 8) <<<"ERROR only 0 to 7 break events available">>>;
		else {
				0 => data.break_state[num];
//				0 => data.break_state;
        data.break_ev[num].broadcast();
		}
 }

 fun void  follower (int num) {
		while(1) {
			     data.break_ev[num] => now;
//          <<<"follow", num, data.break_state>>>;
					if (data.break_state[num])	{
//					if (data.break_state)	{
							a.keyOff();	
					}
					else {
							a.keyOn();	
          }
		}

 }

 fun void register (int num) {
		if (num >= 8) <<<"ERROR only 0 to 7 break events available">>>;
		else {
         spork ~ follower(num);

					if (!data.break_state[num])	{
            //   if (!data.break_state)	{
			         a.set(0::ms, 0::ms, 1, 3::ms);
               a.keyOn();
               //			<<<"Start on">>>;
          }
         else {
	         // Break ongoing when script start	
		      	a.set(0::ms, 0::ms, 1, 0::ms);
            a.keyOff();
           //			<<<"Start off">>>;

		     }
         a.set(3::ms, 0::ms, 1, 3::ms);
		}
 }


}
