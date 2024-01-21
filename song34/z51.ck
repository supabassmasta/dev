class STATES {
  0 => int test;

}

class cont extends CONTROL {
     STATES @ states;
     // 0 =>  update_on_reg ;
        fun void set(float in) {
          1+=> states.test;
          <<<in, states.test>>>;
          HW.launchpad.color(16*5 + 0,states.test%128); // pad 61 (z61.ck)

        }
} 

STATES s;
cont c;
s @=> c.states;
HW.launchpad.keys[16*5 + 0].reg(c);

// Find file number
<<<me.path()>>>;
me.path() => string num;
num.erase(num.find('.'), 3);
num.erase(0, num.rfind('z')+1);
num.toInt() => int n;
n/ 10 -1 => int i;
n%10 -1 => int j;
<<<"num",num, n, i, j>>>;
<<<"MISC.file_nb()", MISC.file_nb(me.path())>>>;

while(1) {
       100::ms => now;
}
 
