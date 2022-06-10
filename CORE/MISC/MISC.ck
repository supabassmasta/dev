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

  fun static int check_output_nb  (){ 
     2 => int outnb; // By default assume there is two outputs

     FileIO fio;
     fio.open( "./output_numbers.txt", FileIO.READ );
     if( !fio.good() )
     {
        return 2;
     }

     fio => outnb;
     // <<<"STTOAUX: output number: ", outnb>>>;
     return outnb;

  } 
}
