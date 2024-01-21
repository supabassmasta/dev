class STATES {
  0 => int test;

}

class cont extends CONTROL {
     STATES @ states;
     // 0 =>  update_on_reg ;
        fun void set(float in) {
          1+=> states.test;
          <<<in, states.test>>>;
          HW.launchpad.color(states.test%128,states.test%128);
        }
} 

STATES s;
cont c;
s @=> c.states;
HW.launchpad.keys[16*5 + 0].reg(c);


while(1) {
       100::ms => now;
}
 
