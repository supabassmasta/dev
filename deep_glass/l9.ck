
// STK BandedWG

// patch
BandedWG bwg => dac;

// scale
[0, 2, 4, 7, 8, 11] @=> int scale[];

int preset;

// infinite time loop
while( true )
{
    // ding!
    Math.random2f( 0, 1 ) => float pluck; 
    Math.random2f( 0, 128 ) => float bowPressure;
    Math.random2f( 0, 128 ) => float bowMotion;
    Math.random2f( 0, 128 ) => float strikePosition;
    Math.random2f( 0, 128 ) => float vibratoFreq;
    Math.random2f( 0, 128 ) => float gain;
    Math.random2f( 0, 128 ) => float bowVelocity;
    Math.random2f( 0, 128 ) => float setStriking;
    Math.random2f( 0, 3 ) => float preset;
    Math.random2f( 0, 1) => float bowRate; 
  

    <<<"CONFIG:">>>;

    pluck=> bwg.pluck;                     <<<pluck, " => bwg.pluck;">>>;
    bowRate => bwg.bowRate;                <<<bowRate, " => bwg.bowRate;">>>;
    bwg.controlChange( 2, bowPressure);    <<<"bwg.controlChange( 2, ", bowPressure, " /* bowPressure */ );">>>;
    bwg.controlChange( 4, bowMotion);      <<<"bwg.controlChange( 4, ", bowMotion,"/* bowMotion */);">>>;
    bwg.controlChange( 8, strikePosition); <<<"bwg.controlChange( 8, ", strikePosition,"/* strikePosition */);">>>;
    bwg.controlChange( 11, vibratoFreq);   <<<"bwg.controlChange( 11, ", vibratoFreq,"/* vibratoFreq */);">>>;
    bwg.controlChange( 1, gain);           <<<"bwg.controlChange( 1, ", gain,"/* gain */);">>>;
    bwg.controlChange( 128, bowVelocity);  <<<"bwg.controlChange( 128, ", bowVelocity,"/* bowVelocity */);">>>;
    bwg.controlChange( 64, setStriking);   <<<"bwg.controlChange( 64, ", setStriking,"/* setStriking */);">>>;
	  0 =>  preset; bwg.controlChange(16, preset);  <<<"bwg.controlChange( 16, ", preset,"/* preset */);">>>;
    /*
    <<< "---", "" >>>;
    <<< "strike position:", bwg.strikePosition() >>>;
    <<< "bow rate:", bwg.bowRate() >>>;
    <<< "bow Pressure:", bwg.bowPressure() >>>;
    */

    // set freq
    scale[Math.random2(0,scale.size()-1)] => int winner;
    57 + Math.random2(0,2)*12 + winner => Std.mtof => bwg.freq;


    <<< "pluck -> bow", "" >>>;

    .9 => bwg.startBowing;
    1::second => now;
    1.0 => bwg.stopBowing;


    /*
    <<< "--", "" >>>;
    Math.random2(0, 3) => int p;
    bwg.controlChange(16, p);

    <<< "preset:", bwg.preset(), p >>>;    
    <<< "strike position:", bwg.strikePosition() >>>;
    <<< "bow rate:", bwg.bowRate() >>>;
    <<< "bow Pressure:", bwg.bowPressure() >>>;

    // set freq
    57 + Math.random2(0,2)*12 + winner => Std.mtof => bwg.freq;
    // go
    .8 => bwg.noteOn;

    // advance time
    1::second => now;
    1.0 => bwg.noteOff;
    .5::second => now;
*/
/*
    <<< "pluck -> bow", "" >>>;

    .8 => bwg.startBowing;
    1::second => now;
    1.0 => bwg.stopBowing;
    */
}
