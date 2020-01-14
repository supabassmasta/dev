public class STDUCK extends ST {

	fun void connect(ST @ tone) {
		tone.left() => global_mixer.stduck_l;
		tone.right() => global_mixer.stduck_r; 
  }

}
