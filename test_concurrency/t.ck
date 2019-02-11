1000::ms => dur T;
<<<"START ", now>>>;

T - (now % T) => now;
0 => int i;
while(1) {
  <<<i, now>>>;
  1+=>i;
       T => now;
}
 
