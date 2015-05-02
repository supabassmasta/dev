public class WAV {
  SndBuf wav0;

  class play_wav extends ACTION {
    SndBuf @ buf;
    fun int on_time() {
      0 => buf.pos;

      return 0;
    }
  }

  play_wav play;
  wav0 @=> play.buf;

  fun void read(string in) {
    in => wav0.read;
  }

  wav0 => dac;
  0.3 => wav0.gain;
  wav0.samples() => wav0.pos;

}

