STMIX stmix;
stmix.receive(87); stmix $ ST @=> ST @ last; 

STREV1 rev;
rev.connect(last $ ST, .3 /* mix */);     rev  $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
