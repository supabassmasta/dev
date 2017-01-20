public class REC extends ST{

  fun void rec (dur d, string name) {
    // sync
    d - ((now - data.wait_before_start)%d) => now;

    dac => WvOut2 w => blackhole;
    name => w.wavFilename;

    d => now ;
    w =< blackhole;
    dac =< w;
  }
}
