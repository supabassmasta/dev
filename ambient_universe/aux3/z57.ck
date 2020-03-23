STMIX stmix;
//stmix.send(last, 11);
stmix.receive(58); stmix $ ST @=> ST @ last; 

//STGAIN stgain;
//stgain.connect(last $ ST , 0. /* static gain */  );       stgain $ ST @=>  last; 


STSAMPLER stsampler;
stsampler.connect(last $ ST, 32*data.tick, "../../_SAMPLES/ambient_universe/" /* path for wav */,  "sample" /* wav name, /!\ NO EXTENSION */, 4 * data.tick /* sync_dur, 0 == sync on full dur */, 0 /* no sync */ ); stsampler $ ST @=>  last;  

STGVERB stgverb;
stgverb.connect(last $ ST, .2 /* mix */, 14 * 10. /* room size */, 11::second /* rev time */, 0.4 /* early */ , 0.9 /* tail */ ); stgverb $ ST @=>  last; 

while(1) {
       100::ms => now;
}
 
