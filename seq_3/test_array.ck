class A {
    fun void hey() {
        <<<"HEYY">>>;
    }

}


A a[0];

new A @=> a["k"];
"0" => string s ;
s.setCharAt(0, 'k');
if ( a["k"] != NULL)
    <<<"allocated", a["k"], "k", 'k', s >>>;
a["k"].hey();
if (a["r"] == NULL)
    <<<"Not allocated" ,a["r"] >>>;


