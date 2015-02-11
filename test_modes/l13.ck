class A {
		int a;
}

class B extends A {

int b;

}

fun void plus(A arg[]) {
		for (0 => int i; i <  arg.size()     ; i++) {
		arg[i].a ++;
		}
		 
}

B foo[2];

1 => foo[0].a;
2 => foo[1].a;
plus (foo);
<<<"foo[0].a", foo[0].a>>>;
<<<"foo[1].a", foo[1].a>>>;
