public class STGVERB extends ST{

  GVerb gverbl  => outl;
  GVerb gverbr  => outr;

  .0 => gverbl.gain => gverbr.gain;

  30        => gverbl.roomsize=> gverbr.roomsize;        // roomsize: (float) [1.0 - 300.0], default 30.0   
  1::second => gverbl.revtime => gverbr.revtime;   // revtime: (dur), default 5::second
  0.8       => gverbl.dry     => gverbr.dry;             // dry (float) [0.0 - 1.0], default 0.6                
  0.5       => gverbl.early   => gverbr.early;           // early (float) [0.0 - 1.0], default 0.4
  0.3       => gverbl.tail    => gverbr.tail;            // tail (float) [0.0 - 1.0], default 0.5       


  fun void connect(ST @ tone, float mix, float rooms, dur rt, float earl, float tail) {
    tone.left() => gverbl;
    tone.right() => gverbr;

    rooms     => gverbl.roomsize=> gverbr.roomsize;        // roomsize: (float) [1.0 - 300.0], default 30.0   
    rt        => gverbl.revtime => gverbr.revtime;   // revtime: (dur), default 5::second
    1. - mix  => gverbl.dry     => gverbr.dry;             // dry (float) [0.0 - 1.0], default 0.6         
    earl      => gverbl.early   => gverbr.early;           // early (float) [0.0 - 1.0], default 0.4
    tail      => gverbl.tail    => gverbr.tail;            // tail (float) [0.0 - 1.0], default 0.5       

    1.0 => gverbl.gain => gverbr.gain;

  }


}


