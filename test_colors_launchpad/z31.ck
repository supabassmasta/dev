    -1 => int color;
    FileIO fio;
    fio.open( "red/z11.ck", FileIO.READ );
    if( !fio.good() )
      <<<"NO FILE">>>;
    else {
      fio => color;
      <<<"color", color>>>;

      if ( color  ){
          // Do nothing color is read in the "if"
          <<<"COLOR: ", color>>>;

      }
      else {
        <<<"RED: color:", color>>>;
      }

      fio.close();
    }

    1::ms => now;

