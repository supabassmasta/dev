Machine.add("../include/include.ck");
me.yield();

if( me.args() == 0) {
    <<<"please set a .ck as input">>>;
    me.exit;   
}

Machine.add("_save_replace_down.ck:" + me.arg(0) );

while (1) 1000::ms=>now;

