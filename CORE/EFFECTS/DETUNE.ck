public class DETUNE {
  SYNT @ in;
  SYNT @ last_aux;
  fun void base_synt(SYNT @ input) {
    input @=> in;
  }

  fun void reg_aux (SYNT @ aux){
    aux @=> last_aux;
  }

  fun void config_aux(float detune , float aux_gain) {
    if ( in != NULL && last_aux != NULL ){
      in.inlet => Gain det => last_aux => in.outlet;    
      detune => det.gain;
      aux_gain => last_aux.outlet.gain;
    }
    else {
      <<<"ERRROR DETUNE: no base SYNT or no AUX registered">>>;
    }

  }

}

