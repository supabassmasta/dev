

lpk25 l;
POLY synta; 
l.reg(synta);
synta.reg(STRINGBASS s0);  synta.a[0].set(1000::ms, 300::ms, .7, 1000::ms);
synta.reg(STRINGBASS s1);  synta.a[1].set(1000::ms, 300::ms, .7, 1000::ms);
synta.reg(STRINGBASS s2);  synta.a[2].set(1000::ms, 300::ms, .7, 1000::ms);
synta.reg(STRINGBASS s3);  synta.a[3].set(1000::ms, 300::ms, .7, 1000::ms); 
synta.reg(STRINGBASS s4);  synta.a[4].set(1000::ms, 300::ms, .7, 1000::ms); 
synta.reg(STRINGBASS s5);  synta.a[5].set(1000::ms, 300::ms, .7, 1000::ms); 
synta.reg(STRINGBASS s6);  synta.a[6].set(1000::ms, 300::ms, .7, 1000::ms); 

STREV1 rev;
rev.connect(synta $ ST, .6 /* mix */); 

while(1) {
	     100::ms => now;
}
 

