public class SAVE {

  string dir;

  fun string init(string path) {
    
    path.rfind('/') => int pos;
    path.erase(0, pos+1);

    path.rfind('.') =>  pos;
    path.substring(0, pos) => path;
    //<<<path>>>;

    path => dir;  
  }

  // Get file name where the instance is called
//  get_file_name_wo_ext() => dir;
//  <<<"file name:", dir>>>;

  fun void save(string p, int i) {
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

  fun void save(string p, float i) {
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

  fun int read(string p){

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

  fun float read_float(string p){

    FileIO fout;

    // open for write
    fout.open( dir + "/" + p, FileIO.READ );

    // test
    if( !fout.good() )
    {
      <<<"Parameter", p, "doesn't exists return 0">>>; 
    }
    else {
      fout => float val;

      fout.close();
      return val;
    }

  }



}
