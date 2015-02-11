//<<<me.path()>>>;

fun string get_file_name_wo_ext() {
  me.path() => string path;
  path.rfind('/') => int pos;
  path.erase(0, pos+1);

  path.rfind('.') =>  pos;
  path.substring(0, pos) => path;
//<<<path>>>;

  return path;  
}

get_file_name_wo_ext() => string dir;

fun void sav_param (string p, int i) {
  FileIO fout;
  
  // open for write
  fout.open( dir + "/" + p, FileIO.WRITE );
  
  // test
  if( !fout.good() )
  {
    <<<"Can't open file to sav param, check ", dir, " directory exists">>>; 
  }
  else {
    fout.write(i);
    fout.close();
  }
}

sav_param("param", 9);

fun int read_param(string p){

  FileIO fout;
  
  // open for write
  fout.open( dir + "/" + p, FileIO.READ );
  
  // test
  if( !fout.good() )
  {
    <<<"Parameter", p, "doesn't exists return 0">>>; 
  }
  else {
    fout => int val;
    fout.close();
    return val;
  }

}

<<<"Res", read_param("param") >>>;
1::ms => now;
