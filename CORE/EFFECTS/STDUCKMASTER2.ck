public class STDUCKMASTER2 extends ST {

  fun void connect(ST @ tone) {
    tone.left()  => global_mixer.duck2_sidel ;
    tone.right() => global_mixer.duck2_sider ; 

    tone.left()  =>  outl;
    tone.right() =>  outr; 
  }

}

