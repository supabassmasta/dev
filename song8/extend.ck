class ext extends def {
//fun void a() { <<<"a from ext">>>;}
fun void b() { <<<"b from ext">>>;}
fun void c() { <<<"c from ext">>>;}

}

ext e;
e.a();
e.b();
e.c();

10::ms=> now;
