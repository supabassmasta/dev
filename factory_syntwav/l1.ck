// SYNTWAV LAB FOR PROGRESSIVE TRANCE AMBIANT PADS

// PART 2, cause too many file open in l0.ck
// Start at 16

"../_SAMPLES/Progressive-Trance-Loops---Samples/Progressive_Trance_Loops_&_Samples/Ambient&Trance_Pads&Strings/WAV_Multisamples/" => string src_path;

"../_SAMPLES/SYNTWAVS/" => string dest_path;

["Agitato","Breathchoir","FlangOrg","MellowStrings","Stalactite","AnalogStr","BriteString","FreezePad","Neptune","StereoString","AnaOrch","ClearBell","GlassChoir","No.9String","Telesa","AnLayer","CloudNine","GlassMan","Phasensemble","VelocityEns","Apollo","ComeOnHigh","HollowPad","PulseString","BigStrings+","Dreamsphere","Kemuri","SkyOrgan","BigWave","DynaPWM","l.txtSmokePad","BottledOut","EnsembleMix","Mars","SoftString"] @=> string synts[];

24 => int C1;
100::ms => dur release;
SndBuf buf => ADSR a;
// TOREMOVE
//.3 => buf.gain; a => dac;

for (16 => int i; i <  32     ; i++) {
  <<<synts[i]>>>;
  for (1 => int j; j <   6    ; j++) {
      
      for (-6 => int k; k < 6      ; k++) {
        C1 + 12*(j-1) + k => int n;

        a.set(0::ms, 0::ms, 1., release);
        a.keyOn();
        src_path + synts[i] + "/C" + j + ".wav" => buf.read;

        Std.mtof(n) / Std.mtof(C1 + 12*(j-1)) => float rate;
        rate => buf.rate;
        <<<"RATE", rate>>>;

         a => WvOut w  => blackhole;
        dest_path +  synts[i] + n + ".wav" => string name => w.wavFilename;
        <<<"REC", name>>>;



        buf.length()/rate - release => now;
//        1::second => now;
        a.keyOff();
        release => now;

         w =< blackhole;
         "dummy_file" => buf.read;
     
        1::ms => now;
      }
       
  


  }
   
  


}
 

1::ms => now;


