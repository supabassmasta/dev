public class WAV {
    SndBuf wav0;
    Pan2 pan_wav0;
    Gain gain_wav0; 
    //PLAY 
    class play_wav extends ACTION {
        SndBuf @ buf;
        fun int on_time() {
            0 => buf.pos;

            return 0;
        }
    }

    play_wav play;
    wav0 @=> play.buf;
    "play_wav  " + wav0.toString() => play.name;

    // PLAY PROBA
    class play_proba extends ACTION {
      float proba;      
      SndBuf @ buf;
        fun int on_time() {
          Math.random2f(0.,1.) => float res;
//          <<<"proba", proba, res, res <= proba >>>;
          if (res <= proba ) {
            0 => buf.pos;
          }
          return 0;
        }
    }

    fun ACTION set_play_proba(float p){
      new play_proba @=> play_proba @ act;
      p => act.proba;
      wav0 @=> act.buf;
      "play_proba  " + wav0.toString() + " " + p => act.name;
      return act $ ACTION;
    }

    // GAIN
    class gain_set extends ACTION {
        SndBuf @ buf;
        .3 => float g;
        fun int on_time() {
//            <<<"GAIN_SET", g>>>;
            g => buf.gain;
            return 0;
        }
    }

    fun ACTION set_gain(float g) {
        new gain_set @=> gain_set @ act;
//        <<<"ACT:", act>>>;
        g => act.g;
        wav0 @=> act.buf;
        "gain_set  " + wav0.toString() + " " + g => act.name;
        return act $ ACTION;
    }

    // PAN
    class pan_set extends ACTION {
        Pan2 @ pan;
        .0 => float p;
        fun int on_time() {
//            <<<"PAN_SET", p>>>;
            p => pan.pan;
            return 0;
        }
    }

    fun ACTION set_pan(float p) {
        new pan_set @=> pan_set @ act;
//        <<<"ACT:", act>>>;
        p => act.p;
        pan_wav0 @=> act.pan;
        "pan_set  " + pan_wav0.toString() + "  " + p => act.name;
        return act $ ACTION;
    }

    // RATE
    class rate_set extends ACTION {
        SndBuf @ buf;
        .3 => float r;
        fun int on_time() {
            r => buf.rate;
//            <<<"RATE:", buf.rate()>>>;
            return 0;
        }
    }
    fun ACTION set_rate(float r) {
        new rate_set @=> rate_set @ act;
        r => act.r;
        wav0 @=> act.buf;
        "rate_set  " + wav0.toString() + "  " + r => act.name;
        return act $ ACTION;
    }







    fun void read(string in) {
        in => wav0.read;
        wav0.samples() => wav0.pos;
    }

    // function to get audio out of object
    fun UGen mono() {
            gain_wav0 =< pan_wav0;
            return gain_wav0;
    }
    fun UGen left() {
            pan_wav0=< dac;
            return pan_wav0.left;
    }
    fun UGen right() {
            pan_wav0=< dac;
            return pan_wav0.right;
    }

    wav0 => gain_wav0 =>  pan_wav0 => dac;
    0. => pan_wav0.pan;
    0.3 => wav0.gain;
    wav0.samples() => wav0.pos;

    fun void gain(float in) {
      in => gain_wav0.gain;
    }

}

