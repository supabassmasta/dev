public class STABSATURATOR extends ST{
   ABSaturator satl   =>   outl;
   ABSaturator satr   =>   outr;
   2.0 => satl.drive;
   0.0 => satl.dcOffset; 
   2.0 => satr.drive;
   0.0 => satr.dcOffset; 


   fun void connect(ST @ tone, float drive, float dc) {
     drive => satl.drive=> satr.drive;
     dc => satl.dcOffset=> satr.dcOffset; 

     tone.left() => satl;
     tone.right() => satr;

   }
}


