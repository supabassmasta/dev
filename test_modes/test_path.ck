<<<me.path()>>>;
<<<me.dir()>>>;
<<<me.dir(2)>>>;
<<<me.dir(1)>>>;
<<<me.dir().length()>>>;

// Get file name
<<<me.path().substring (me.dir().length()+1)>>>;
me.path().substring (me.dir().length()+1) => string f_name;

FileIO fout;

// open for write
Std.system ("mkdir test_dir");
//fout.open( f_name + "/out.txt", FileIO.WRITE );
//fout.open(  ".out.txt", FileIO.WRITE );

// test
if( !fout.good() )
{
    cherr <= "can't open file for writing..." <= IO.newline();
    me.exit();
}

// write some stuff
fout <= 1 <= " " <= 2 <= " " <= "foo" <= IO.newline();

// close the thing
fout.close();
	     100::ms => now;
