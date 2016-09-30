public class SIN {
    now => time start;
    1. => float freq;


    fun float value() {
     return Math.sin(( (now - start)/1::second) * 2 * pi* freq);
    }


  }

