// array pass by reference test - should change values?

class A {
		int a;
}

class B extends A {

int b;

}


// function that takes array
fun void mirror( A arg[] )
{
    // assign 0th element to 1st element
    arg[0].a => arg[1].a;
}

// declare array
B foo[2];
2 => foo[0].a;
1 => foo[1].a;

// call the function
B $ A[]  @=>  A @ foo2;
mirror( foo2 );

// test
if ( foo[0].a == foo[1].a ) <<<"success">>>;

