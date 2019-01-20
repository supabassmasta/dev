SYNC sy;
sy.sync(64 * data.tick);
//sy.sync(4 * data.tick , 0::ms /* offset */); 

0 => int b;

while(1) {
       <<<"BEAT ", b>>>;
       1+=> b;
      if ( b > 63  ){
          0 => b;
      }
       data.tick => now;
}
 
