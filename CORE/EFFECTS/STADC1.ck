public class STADC1 extends ST{
  Gain gainl => outl;
  Gain gainr => outr;

  1. => gainl.gain => gainr.gain;

  adc => gainl;
  adc => gainr;

}


