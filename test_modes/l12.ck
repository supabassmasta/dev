class A {
		int a;
}

class B extends A {

int b;

}

fun void plus(A arg) {
		arg.a ++;
}

B foo;

1 => foo.a;
plus (foo);
<<<"foo.a", foo.a>>>;
