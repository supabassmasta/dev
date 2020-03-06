
class cont extends CONTROL {
   // 0 =>  update_on_reg ;
   0xFFFFFFFF => int last; 
    
   fun void set(float in) {
     int diff;
     if (last ==  0xFFFFFFFF ){
        in $ int => last;    
     }
     else {
        in $ int - last => diff;
        MASTER_SEQ3.offset_ref_times(diff * 1::ms); 
        in $ int => last;
        <<<"Offset REF TIMES: ", diff, " ms">>>; 
     }
   }
}

cont c;
HW.kb.leftright.reg (c);

<<<"'''''''''''OFFSET REF TIME ADJUSTER''''''''''''''''">>>;
<<<"''''''''''' USE left & right key   ''''''''''''''''">>>;



while(1) {
       100::ms => now;
}
 

