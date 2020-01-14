class A {
  fun void doit(){
    <<<"Origin">>>;
  }
}

class B extends A{
  
  fun void doit(){
    <<<"B">>>;
  }

  class C {
    A @ mother;

    fun void do_mom() {
      mother.doit();
    }
  } 

  C c;
  this @=> c.mother;

}


B b;

b.c.do_mom();

1::ms => now;
