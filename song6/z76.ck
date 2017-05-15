AMBIENT s[5];
for (0 => int i; i < 5      ; i++) {

  s[i].load(1);

}


lpk25 l;
POLY synta; 
l.reg(synta);

0 => int i;

synta.reg(s[i]);  synta.a[0].set(3::ms, 30::ms, 1., 1000::ms);i++;
synta.reg(s[i]);  synta.a[1].set(3::ms, 30::ms, 1., 1000::ms);i++;
synta.reg(s[i]);  synta.a[2].set(3::ms, 30::ms, 1., 1000::ms);i++;
synta.reg(s[i]);  synta.a[3].set(3::ms, 30::ms, 1., 1000::ms);i++; 

while(1) {
       100::ms => now;
}
 

