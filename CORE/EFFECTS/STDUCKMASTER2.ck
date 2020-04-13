public class STDUCKMASTER2 extends ST {

  fun void connect(ST @ tone) {
    tone.left()  => global_mixer.duck2_sidel => outl;
    tone.right() => global_mixer.duck2_sider => outr; 
  }

}

