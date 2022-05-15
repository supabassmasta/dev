public class MISC {
  fun static int file_exist (string filename){ 
    FileIO fio;
    fio.open( filename, FileIO.READ );
    if( !fio.good() )
      return 0;
    else {
      fio.close();
      return 1;
    }
  } 
}
