AMBIENT s[5];
for (0 => int i; i < 5      ; i++) {

  s[i].load(14);

}


lpk25 l;
POLY synta; 
l.reg(synta);

0 => int i;

synta.reg(s[i]);  synta.a[0].set(3::ms, 30::ms, 1., 1000::ms);i++;
synta.reg(s[i]);  synta.a[1].set(3::ms, 30::ms, 1., 1000::ms);i++;
synta.reg(s[i]);  synta.a[2].set(3::ms, 30::ms, 1., 1000::ms);i++;
synta.reg(s[i]);  synta.a[3].set(3::ms, 30::ms, 1., 1000::ms);i++; 

STGAINC gainc;
gainc.connect(synta $ ST , HW.lpd8.potar[1][1] /* gain */  , 4. /* static gain */  );  

while(1) {
       100::ms => now;
}
 

