// SYNTWAV LAB FOR PROGRESSIVE TRANCE AMBIANT PADS


"../_SAMPLES/Progressive-Trance-Loops---Samples/Progressive_Trance_Loops_&_Samples/Ambient&Trance_Pads&Strings/WAV_Multisamples/" => string src_path;

"../_SAMPLES/SYNTWAVS/" => string dest_path;

["Agitato","Breathchoir","FlangOrg","MellowStrings","Stalactite","AnalogStr","BriteString","FreezePad","Neptune","StereoString","AnaOrch","ClearBell","GlassChoir","No.9String","Telesa","AnLayer","CloudNine","GlassMan","Phasensemble","VelocityEns","Apollo","ComeOnHigh","HollowPad","PulseString","BigStrings+","Dreamsphere","Kemuri","SkyOrgan","BigWave","DynaPWM","l.txtSmokePad","BottledOut","EnsembleMix","Mars","SoftString"] @=> string synts[];

24 => int C1;
100::ms => dur release;
SndBuf buf => ADSR a;
// TOREMOVE
.3 => buf.gain; a => dac;

//for (0 => int i; i <  synts.size()     ; i++) {
  1 => int i;
  <<<synts[i]>>>;
  for (1 => int j; j <   6    ; j++) {
//      3 => int j;
      
      for (-6 => int k; k < 6      ; k++) {
        C1 + 12*(j-1) + k => int n;

        a.set(0::ms, 0::ms, 1., release);
        a.keyOn();
        src_path + synts[i] + "/C" + j + ".wav" => buf.read;

        Std.mtof(n) / Std.mtof(C1 + 12*(j-1)) => float rate;
        rate => buf.rate;
        <<<"RATE", rate>>>;



        buf.length()/rate - release => now;
//        1::second => now;
        a.keyOff();
        release => now;
      
        100::ms => now;
      }
       
  


  }
   
  


//}
 

1::ms => now;


