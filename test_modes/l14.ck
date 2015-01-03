class A {
		int a;
}

class B extends A {

int b;

}

class C {

A @ arg[2];

fun void plus() {
		for (0 => int i; i <  arg.size()     ; i++) {
		arg[i].a ++;
		}
		 
  }
}

B foo[2];

1 => foo[0].a;
2 => foo[1].a;
C c;
foo[0] @=> c.arg[0]; 
foo[1] @=> c.arg[1]; 
c.plus ();
<<<"foo[0].a", foo[0].a>>>;
<<<"foo[1].a", foo[1].a>>>;
