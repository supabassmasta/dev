  class B {

    fun void say(){
      <<<"I m B">>>;
    }


  }

public class A {
  B b;

  fun void say(){
    <<<"I m A">>>;
    b.say();
  }
}

