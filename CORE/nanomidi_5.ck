
public class nanomidi {

    // NanoKontrol device name
    "nanoKONTROL MIDI 1" => string device;

    MidiIn min;
    MidiMsg msg;

    // UGen
    Step potar_a[4][9];
    Step fader_a[4][9];
	
	// Gain control
	ADSR env_a[4][9];
	Gain gain_a[4][9];
    
    // ADSR custom
    ADSR adsr_cutom_0_u;
    ADSR adsr_cutom_1_u;
    ADSR adsr_cutom_2_u;
	adsr_cutom_0_u.set(10::ms, 0::ms, 1 , 10::ms);
	adsr_cutom_1_u.set(10::ms, 0::ms, 1 , 10::ms);
	adsr_cutom_2_u.set(10::ms, 0::ms, 1 , 10::ms);
    0=> int adsr_cutom_0_on;
    0=> int adsr_cutom_1_on;
    0=> int adsr_cutom_2_on;

    // Compressor custom
    Dyno compressor;
    Gain Gain_side_comp;
    0=> int compressor_on;
    
    //  Mixer
    Mix2 mix[9];
    
    0=>int midi_rcv_on;
    
//    if( !min.open( device ) ) me.exit();

//   <<< "MIDI device:", min.num(), " -> ", min.name() >>>;
//    <<< "MIDI device not open for test!!!" >>>;
for(0 =>  int i; i < 8; i++ )
{
    // no print err
//    min.printerr( 0 );

    // open the device
    if( min.open( i ) )
    {
				if ( min.name() == device ) {
        <<< "device", i, "->", min.name(), "->", "open: SUCCESS" >>>;
				break;
				}
				else {
//					min.close();
				}

   }
    else break;
}

<<< "MIDI device:", min.num(), " -> ", min.name() >>>;

    fun void button_up_ext (int bank, int group, int val) {<<<"button up ", bank, group," : ",val>>>;}
    fun void button_down_ext (int bank, int group, int val) {<<<"button down ", bank, group," : ",val>>>;}

    fun void button_back_ext (int val) {<<<"button back: ",val>>>;}
    fun void button_play_ext (int val) {<<<"button play: ",val>>>;}
    fun void button_forward_ext (int val) {<<<"button forward: ",val>>>;}
    fun void button_loop_ext (int val) {<<<"button loop: ",val>>>;}
    fun void button_stop_ext (int val) {<<<"button stop: ",val>>>;}
    fun void button_rec_ext (int val) {<<<"button rec: ",val>>>;}

    fun void fader_ext (int bank, int group, int val) {<<<"fader: ", bank, group, val>>>;}
    fun void potar_ext (int bank, int group, int val) {<<<"potar: ", bank, group, val>>>;}
	
    fun void start_midi_rcv() {
        int bank_no;
        int group_no;
	   
        while( true )
        {
            min => now;

            while( min.recv(msg) )
            {
                <<< msg.data1, msg.data2, msg.data3 >>>;
				                
				msg.data1 - 175 => group_no;
//				<<<"group_no",group_no>>>;
                
                if ( msg.data2<4) 1=> bank_no;
                else if ( msg.data2<8) 2=> bank_no;
                else if ( msg.data2<12) 3=> bank_no;
                else 4=> bank_no;
                
				// BUTTON BACK
				if (group_no== 1 && msg.data2 == 47) {
					button_back_ext (msg.data3); 
				}
 				// BUTTON play
				else if (group_no== 1 && msg.data2 == 45) {
					button_play_ext (msg.data3); 
				}
 				// BUTTON forward
				else if (group_no== 1 && msg.data2 == 48) {
					button_forward_ext (msg.data3); 
				}
 				// BUTTON loop
				else if (group_no== 1 && msg.data2 == 49) {
					button_loop_ext (msg.data3); 
				}
 				// BUTTON stop
				else if (group_no== 1 && msg.data2 == 46) {
					button_stop_ext (msg.data3); 
				}
 				// BUTTON rec
				else if (group_no== 1 && msg.data2 == 44) {
					button_rec_ext (msg.data3);

				}
				// BUTTON UP
				else if (msg.data2%4 == 1) {
					button_up_ext (bank_no,group_no, msg.data3); 
        			         if (bank_no == 1) {
                        		// Update mixers
			                    if (msg.data3) spork ~ go_pan(group_no - 1, 1);
			                    else           spork ~ go_pan(group_no - 1, 0);
		                    }
                    
				}
 				// BUTTON DOWN
				else if ((msg.data2%4) == 0) {
					button_down_ext (bank_no, group_no, msg.data3); 
					if (msg.data3) spork ~ gain_on(bank_no, group_no); 
					else spork ~ gain_off(bank_no, group_no); 
				}
 				// POTAR
				else if (msg.data2%4 == 3 ) {
					msg.data3 => potar_a[bank_no - 1][group_no - 1].next;
                    potar_ext (bank_no, group_no, msg.data3);

                    if (bank_no == 3)
                    {
                        // Compressor control
                        if(compressor_on && group_no == 7) {(msg.data3 $ float)/127 => compressor.thresh; <<<"compressor.thresh",compressor.thresh() >>>; }
                        if(compressor_on && group_no == 8) {msg.data3::ms => compressor.attackTime; <<<"compressor.attackTime",compressor.attackTime()/1::ms >>>; }
                        if(compressor_on && group_no == 9) {msg.data3::ms => compressor.releaseTime; <<<"compressor.releaseTime",compressor.releaseTime()/1::ms >>>; }
                    }
                    
                    if (bank_no == 4)
                    {
                        // ADSR control
                        if (adsr_cutom_0_on && group_no == 4) { msg.data3::ms *4=> adsr_cutom_0_u.decayTime; <<<"adsr_cutom_0_u.decayTime",adsr_cutom_0_u.decayTime()/1::ms >>>; }
                        if (adsr_cutom_1_on && group_no == 6) { msg.data3::ms *4=> adsr_cutom_1_u.decayTime; <<<"adsr_cutom_1_u.decayTime",adsr_cutom_1_u.decayTime()/1::ms >>>; }
                        if (adsr_cutom_2_on && group_no == 8) { msg.data3::ms *4=> adsr_cutom_2_u.decayTime; <<<"adsr_cutom_2_u.decayTime",adsr_cutom_2_u.decayTime()/1::ms >>>; }
                        if (adsr_cutom_0_on && group_no == 5) { (msg.data3 $ float)/127 => adsr_cutom_0_u.sustainLevel; <<<"adsr_cutom_0_u.sustainLevel",adsr_cutom_0_u.sustainLevel() >>>; }
                        if (adsr_cutom_1_on && group_no == 7) { (msg.data3 $ float)/127 => adsr_cutom_1_u.sustainLevel; <<<"adsr_cutom_1_u.sustainLevel",adsr_cutom_1_u.sustainLevel() >>>; }
                        if (adsr_cutom_2_on && group_no == 9) { (msg.data3 $ float)/127 => adsr_cutom_2_u.sustainLevel; <<<"adsr_cutom_2_u.sustainLevel",adsr_cutom_2_u.sustainLevel() >>>; }
                    }
                    
                }
                // FADER
				else if (msg.data2%4 == 2) {
					msg.data3 => fader_a[bank_no - 1][group_no - 1].next;
                    fader_ext (bank_no, group_no, msg.data3);
                    
					// Gain control
                    (msg.data3 $ float)/127 => gain_a[bank_no - 1][group_no-1].gain;
                   // <<<"fader gain", gain_a[bank_no - 1][group_no-1].gain()>>>;
                    
                    if (bank_no == 3)
                    {
                        // Compressor control
                        if(compressor_on && group_no == 6) {(msg.data3 $ float)/42 => Gain_side_comp.gain ; <<<"Gain_side_comp.gain ",Gain_side_comp.gain () >>>; }
                        if(compressor_on && group_no == 7) {(msg.data3 $ float)/127 => compressor.slopeBelow ; <<<"compressor.slopeBelow ",compressor.slopeBelow () >>>; }
                        if(compressor_on && group_no == 8) {(msg.data3 $ float)/127 => compressor.slopeAbove  ; <<<"compressor.slopeAbove  ",compressor.slopeAbove  () >>>; }
                        if(compressor_on && group_no == 9) {(msg.data3 $ float)/42 => compressor.gain  ; <<<"compressor.gain  ",compressor.gain  () >>>; }
                        
                    }
                    
                    if (bank_no == 4)
                    {
                        // ADSR control
                        if (adsr_cutom_0_on && group_no == 4) { msg.data3::ms *4=> adsr_cutom_0_u.attackTime; <<<"adsr_cutom_0_u.attackTime",adsr_cutom_0_u.attackTime()/1::ms >>>; }
                        if (adsr_cutom_1_on && group_no == 6) { msg.data3::ms *4=> adsr_cutom_1_u.attackTime; <<<"adsr_cutom_1_u.attackTime",adsr_cutom_1_u.attackTime()/1::ms >>>; }
                        if (adsr_cutom_2_on && group_no == 8) { msg.data3::ms *4=> adsr_cutom_2_u.attackTime; <<<"adsr_cutom_2_u.attackTime",adsr_cutom_2_u.attackTime()/1::ms >>>; }
                        if (adsr_cutom_0_on && group_no == 5) { msg.data3::ms * 10 => adsr_cutom_0_u.releaseTime; <<<"adsr_cutom_0_u.releaseTime",adsr_cutom_0_u.releaseTime()/1::ms >>>; }
                        if (adsr_cutom_1_on && group_no == 7) { msg.data3::ms * 10 => adsr_cutom_1_u.releaseTime; <<<"adsr_cutom_1_u.releaseTime",adsr_cutom_1_u.releaseTime()/1::ms >>>; }
                        if (adsr_cutom_2_on && group_no == 9) { msg.data3::ms * 10 => adsr_cutom_2_u.releaseTime; <<<"adsr_cutom_2_u.releaseTime",adsr_cutom_2_u.releaseTime()/1::ms >>>; }
                    }
                    
				}
				
                    save_nano();
            }
        }
    }
    
    fun void gain_on(int bank_no, int group_no){
        // gain_a[bank_no - 1][group_no-1] => env_a[bank_no - 1][group_no-1];
        env_a[bank_no - 1][group_no-1].keyOn();
    }

    fun void gain_off(int bank_no, int group_no){
        env_a[bank_no - 1][group_no-1].keyOff();
        // 5::ms => now;
        // gain_a[bank_no - 1][group_no-1] =< env_a[bank_no - 1][group_no-1];
    }
    
     fun UGen gain_fader_1_1(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[0][0] => env_a[0][0] => out; 	 0=>gain_a[0][0].gain; 		env_a[0][0].set( 5::ms, 0::ms, 1, 5::ms );      env_a[0][0].keyOff(); 		return out;	}
     fun UGen gain_fader_1_2(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[0][1] => env_a[0][1] => out; 	 0=>gain_a[0][1].gain; 		env_a[0][1].set( 5::ms, 0::ms, 1, 5::ms );      env_a[0][1].keyOff(); 		return out;	}
     fun UGen gain_fader_1_3(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[0][2] => env_a[0][2] => out; 	 0=>gain_a[0][2].gain; 		env_a[0][2].set( 5::ms, 0::ms, 1, 5::ms );      env_a[0][2].keyOff(); 		return out;	}
     fun UGen gain_fader_1_4(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[0][3] => env_a[0][3] => out; 	 0=>gain_a[0][3].gain; 		env_a[0][3].set( 5::ms, 0::ms, 1, 5::ms );      env_a[0][3].keyOff(); 		return out;	}
     fun UGen gain_fader_1_5(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[0][4] => env_a[0][4] => out; 	 0=>gain_a[0][4].gain; 		env_a[0][4].set( 5::ms, 0::ms, 1, 5::ms );      env_a[0][4].keyOff(); 		return out;	}
     fun UGen gain_fader_1_6(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[0][5] => env_a[0][5] => out; 	 0=>gain_a[0][5].gain; 		env_a[0][5].set( 5::ms, 0::ms, 1, 5::ms );      env_a[0][5].keyOff(); 		return out;	}
     fun UGen gain_fader_1_7(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[0][6] => env_a[0][6] => out; 	 0=>gain_a[0][6].gain; 		env_a[0][6].set( 5::ms, 0::ms, 1, 5::ms );      env_a[0][6].keyOff(); 		return out;	}
     fun UGen gain_fader_1_8(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[0][7] => env_a[0][7] => out; 	 0=>gain_a[0][7].gain; 		env_a[0][7].set( 5::ms, 0::ms, 1, 5::ms );      env_a[0][7].keyOff(); 		return out;	}
     fun UGen gain_fader_1_9(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[0][8] => env_a[0][8] => out; 	 0=>gain_a[0][8].gain; 		env_a[0][8].set( 5::ms, 0::ms, 1, 5::ms );      env_a[0][8].keyOff(); 		return out;	}
                                                                                                                                       
     fun UGen gain_fader_2_1(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[1][0] => env_a[1][0] => out; 	 0=>gain_a[1][0].gain; 		env_a[1][0].set( 5::ms, 0::ms, 1, 5::ms );      env_a[1][0].keyOff(); 		return out;	}
     fun UGen gain_fader_2_2(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[1][1] => env_a[1][1] => out; 	 0=>gain_a[1][1].gain; 		env_a[1][1].set( 5::ms, 0::ms, 1, 5::ms );      env_a[1][1].keyOff(); 		return out;	}
     fun UGen gain_fader_2_3(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[1][2] => env_a[1][2] => out; 	 0=>gain_a[1][2].gain; 		env_a[1][2].set( 5::ms, 0::ms, 1, 5::ms );      env_a[1][2].keyOff(); 		return out;	}
     fun UGen gain_fader_2_4(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[1][3] => env_a[1][3] => out; 	 0=>gain_a[1][3].gain; 		env_a[1][3].set( 5::ms, 0::ms, 1, 5::ms );      env_a[1][3].keyOff(); 		return out;	}
     fun UGen gain_fader_2_5(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[1][4] => env_a[1][4] => out; 	 0=>gain_a[1][4].gain; 		env_a[1][4].set( 5::ms, 0::ms, 1, 5::ms );      env_a[1][4].keyOff(); 		return out;	}
     fun UGen gain_fader_2_6(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[1][5] => env_a[1][5] => out; 	 0=>gain_a[1][5].gain; 		env_a[1][5].set( 5::ms, 0::ms, 1, 5::ms );      env_a[1][5].keyOff(); 		return out;	}
     fun UGen gain_fader_2_7(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[1][6] => env_a[1][6] => out; 	 0=>gain_a[1][6].gain; 		env_a[1][6].set( 5::ms, 0::ms, 1, 5::ms );      env_a[1][6].keyOff(); 		return out;	}
     fun UGen gain_fader_2_8(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[1][7] => env_a[1][7] => out; 	 0=>gain_a[1][7].gain; 		env_a[1][7].set( 5::ms, 0::ms, 1, 5::ms );      env_a[1][7].keyOff(); 		return out;	}
     fun UGen gain_fader_2_9(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[1][8] => env_a[1][8] => out; 	 0=>gain_a[1][8].gain; 		env_a[1][8].set( 5::ms, 0::ms, 1, 5::ms );      env_a[1][8].keyOff(); 		return out;	}
                                                                                                                                       
     fun UGen gain_fader_3_1(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[2][0] => env_a[2][0] => out; 	 0=>gain_a[2][0].gain; 		env_a[2][0].set( 5::ms, 0::ms, 1, 5::ms );      env_a[2][0].keyOff(); 		return out;	}
     fun UGen gain_fader_3_2(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[2][1] => env_a[2][1] => out; 	 0=>gain_a[2][1].gain; 		env_a[2][1].set( 5::ms, 0::ms, 1, 5::ms );      env_a[2][1].keyOff(); 		return out;	}
     fun UGen gain_fader_3_3(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[2][2] => env_a[2][2] => out; 	 0=>gain_a[2][2].gain; 		env_a[2][2].set( 5::ms, 0::ms, 1, 5::ms );      env_a[2][2].keyOff(); 		return out;	}
     fun UGen gain_fader_3_4(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[2][3] => env_a[2][3] => out; 	 0=>gain_a[2][3].gain; 		env_a[2][3].set( 5::ms, 0::ms, 1, 5::ms );      env_a[2][3].keyOff(); 		return out;	}
     fun UGen gain_fader_3_5(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[2][4] => env_a[2][4] => out; 	 0=>gain_a[2][4].gain; 		env_a[2][4].set( 5::ms, 0::ms, 1, 5::ms );      env_a[2][4].keyOff(); 		return out;	}
     fun UGen gain_fader_3_6(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[2][5] => env_a[2][5] => out; 	 0=>gain_a[2][5].gain; 		env_a[2][5].set( 5::ms, 0::ms, 1, 5::ms );      env_a[2][5].keyOff(); 		return out;	}
     fun UGen gain_fader_3_7(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[2][6] => env_a[2][6] => out; 	 0=>gain_a[2][6].gain; 		env_a[2][6].set( 5::ms, 0::ms, 1, 5::ms );      env_a[2][6].keyOff(); 		return out;	}
     fun UGen gain_fader_3_8(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[2][7] => env_a[2][7] => out; 	 0=>gain_a[2][7].gain; 		env_a[2][7].set( 5::ms, 0::ms, 1, 5::ms );      env_a[2][7].keyOff(); 		return out;	}
     fun UGen gain_fader_3_9(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[2][8] => env_a[2][8] => out; 	 0=>gain_a[2][8].gain; 		env_a[2][8].set( 5::ms, 0::ms, 1, 5::ms );      env_a[2][8].keyOff(); 		return out;	}
                                                                                                                                       
     fun UGen gain_fader_4_1(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[3][0] => env_a[3][0] => out; 	 0=>gain_a[3][0].gain; 		env_a[3][0].set( 5::ms, 0::ms, 1, 5::ms );      env_a[3][0].keyOff(); 		return out;	}
     fun UGen gain_fader_4_2(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[3][1] => env_a[3][1] => out; 	 0=>gain_a[3][1].gain; 		env_a[3][1].set( 5::ms, 0::ms, 1, 5::ms );      env_a[3][1].keyOff(); 		return out;	}
     fun UGen gain_fader_4_3(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[3][2] => env_a[3][2] => out; 	 0=>gain_a[3][2].gain; 		env_a[3][2].set( 5::ms, 0::ms, 1, 5::ms );      env_a[3][2].keyOff(); 		return out;	}
     fun UGen gain_fader_4_4(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[3][3] => env_a[3][3] => out; 	 0=>gain_a[3][3].gain; 		env_a[3][3].set( 5::ms, 0::ms, 1, 5::ms );      env_a[3][3].keyOff(); 		return out;	}
     fun UGen gain_fader_4_5(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[3][4] => env_a[3][4] => out; 	 0=>gain_a[3][4].gain; 		env_a[3][4].set( 5::ms, 0::ms, 1, 5::ms );      env_a[3][4].keyOff(); 		return out;	}
     fun UGen gain_fader_4_6(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[3][5] => env_a[3][5] => out; 	 0=>gain_a[3][5].gain; 		env_a[3][5].set( 5::ms, 0::ms, 1, 5::ms );      env_a[3][5].keyOff(); 		return out;	}
     fun UGen gain_fader_4_7(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[3][6] => env_a[3][6] => out; 	 0=>gain_a[3][6].gain; 		env_a[3][6].set( 5::ms, 0::ms, 1, 5::ms );      env_a[3][6].keyOff(); 		return out;	}
     fun UGen gain_fader_4_8(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[3][7] => env_a[3][7] => out; 	 0=>gain_a[3][7].gain; 		env_a[3][7].set( 5::ms, 0::ms, 1, 5::ms );      env_a[3][7].keyOff(); 		return out;	}
     fun UGen gain_fader_4_9(UGen @ in){Gain out; if (!midi_rcv_on){spork ~ start_midi_rcv(); 1 => midi_rcv_on;}	in => gain_a[3][8] => env_a[3][8] => out; 	 0=>gain_a[3][8].gain; 		env_a[3][8].set( 5::ms, 0::ms, 1, 5::ms );      env_a[3][8].keyOff(); 		return out;	}


    fun UGen potar(int bank_no, int potar_no) {

        if (potar_no>9 || potar_no==0){
            <<<"ERROR: potar",potar_no,"does not exist">>>;
            return potar_a[0][1];
        }
        else {
            if (!midi_rcv_on){
                spork ~ start_midi_rcv();
                1 => midi_rcv_on;
            }
            potar_a[bank_no - 1][potar_no-1].next(0);
            return potar_a[bank_no - 1][potar_no-1];
        }    
    }
    
    fun UGen fader(int bank_no, int fader_no) {

        if (fader_no>9 || fader_no==0){
            <<<"ERROR: fader",fader_no,"does not exist">>>;
            return fader_a[0][1];
        }
        else {
            if (!midi_rcv_on){
                spork ~ start_midi_rcv();
                1 => midi_rcv_on;
            }
            fader_a[bank_no - 1][fader_no-1].next(0);
            return fader_a[bank_no - 1][fader_no-1];
        }    
    }

    fun UGen adsr_0 (UGen @ in){
       if (!midi_rcv_on){
            spork ~ start_midi_rcv();
            1 => midi_rcv_on;
        }
 
        1 => adsr_cutom_0_on;
        in => adsr_cutom_0_u;
        return adsr_cutom_0_u;
    }

    fun UGen adsr_1 (UGen @ in){
       if (!midi_rcv_on){
            spork ~ start_midi_rcv();
            1 => midi_rcv_on;
        }
 
        1 => adsr_cutom_1_on;
        in => adsr_cutom_1_u;
        return adsr_cutom_1_u;
    }

    fun UGen adsr_2 (UGen @ in){
       if (!midi_rcv_on){
            spork ~ start_midi_rcv();
            1 => midi_rcv_on;
        }
        1 => adsr_cutom_2_on;
        in => adsr_cutom_2_u;
        return adsr_cutom_2_u;
    }
    
    // Compressor
    fun UGen comp (UGen @ in){
       if (!midi_rcv_on){
            spork ~ start_midi_rcv();
            1 => midi_rcv_on;
        }
 
        1=>compressor_on;
        compressor.compress();
        in => compressor;
        return compressor;
    }

    fun void side_comp (UGen @ in){
        compressor.duck();
        in => Gain_side_comp;
        spork ~ side_comp_run(Gain_side_comp);
    }

    fun void side_comp_run (UGen @ in){
        in => blackhole;
        while(1) {
            in.last() => compressor.sideInput;
            1::samp => now;
        }
    }

//  Mixer
    fun UGen mixer_main_1(UGen @ in){Gain two; two.gain(2); if (!midi_rcv_on){ spork ~ start_midi_rcv();1 => midi_rcv_on;} in => mix[0].left;	-1 => mix[0].pan; mix[0] =>two; return two;  }
    fun UGen mixer_main_2(UGen @ in){Gain two; two.gain(2); if (!midi_rcv_on){ spork ~ start_midi_rcv();1 => midi_rcv_on;} in => mix[1].left;	-1 => mix[1].pan; mix[1] =>two; return two;  }
    fun UGen mixer_main_3(UGen @ in){Gain two; two.gain(2); if (!midi_rcv_on){ spork ~ start_midi_rcv();1 => midi_rcv_on;} in => mix[2].left;	-1 => mix[2].pan; mix[2] =>two; return two;  }
    fun UGen mixer_main_4(UGen @ in){Gain two; two.gain(2); if (!midi_rcv_on){ spork ~ start_midi_rcv();1 => midi_rcv_on;} in => mix[3].left;	-1 => mix[3].pan; mix[3] =>two; return two;  }
    fun UGen mixer_main_5(UGen @ in){Gain two; two.gain(2); if (!midi_rcv_on){ spork ~ start_midi_rcv();1 => midi_rcv_on;} in => mix[4].left;	-1 => mix[4].pan; mix[4] =>two; return two;  }
    fun UGen mixer_main_6(UGen @ in){Gain two; two.gain(2); if (!midi_rcv_on){ spork ~ start_midi_rcv();1 => midi_rcv_on;} in => mix[5].left;	-1 => mix[5].pan; mix[5] =>two; return two;  }
    fun UGen mixer_main_7(UGen @ in){Gain two; two.gain(2); if (!midi_rcv_on){ spork ~ start_midi_rcv();1 => midi_rcv_on;} in => mix[6].left;	-1 => mix[6].pan; mix[6] =>two; return two;  }
    fun UGen mixer_main_8(UGen @ in){Gain two; two.gain(2); if (!midi_rcv_on){ spork ~ start_midi_rcv();1 => midi_rcv_on;} in => mix[7].left;	-1 => mix[7].pan; mix[7] =>two; return two;  }
    fun UGen mixer_main_9(UGen @ in){Gain two; two.gain(2); if (!midi_rcv_on){ spork ~ start_midi_rcv();1 => midi_rcv_on;} in => mix[8].left;   -1 => mix[8].pan; mix[8] =>two; return two;  }
    
    fun void mixer_div_1(UGen @ in){ in => mix[0].right; }
    fun void mixer_div_2(UGen @ in){ in => mix[1].right; }
    fun void mixer_div_3(UGen @ in){ in => mix[2].right; }
    fun void mixer_div_4(UGen @ in){ in => mix[3].right; }
    fun void mixer_div_5(UGen @ in){ in => mix[4].right; }
    fun void mixer_div_6(UGen @ in){ in => mix[5].right; }
    fun void mixer_div_7(UGen @ in){ in => mix[6].right; }
    fun void mixer_div_8(UGen @ in){ in => mix[7].right; }
    fun void mixer_div_9(UGen @ in){ in => mix[8].right; }

    fun void go_pan(int mixer_no, int pan_target) {
        if (pan_target != mix[mixer_no].pan()){
            if (pan_target == 1) {
                while (mix[mixer_no].pan() < 1) {
                    0.1 + mix[mixer_no].pan() => mix[mixer_no].pan;
                    1::ms => now;
                }
				1=> mix[mixer_no].pan;
			}
			else /* pan_target == 0 */
            {
                while (mix[mixer_no].pan() > -1) {
                    mix[mixer_no].pan() - 0.1 => mix[mixer_no].pan;
                    1::ms => now;
                }
				-1 => mix[mixer_no].pan;
            }
        }
	<<<"mix[mixer_no].pan()",mix[mixer_no].pan()>>>;
    }
    
    
    // Init function
    fun void init_potar (int bank_no, int group_no, int val) {val => potar_a[bank_no - 1][group_no - 1].next;}
    fun void init_fader (int bank_no, int group_no, int val) {val => fader_a[bank_no - 1][group_no - 1].next;}
    fun void init_gain  (int bank_no, int group_no, int on, float val) {
        val => gain_a[bank_no - 1][group_no-1].gain; 
        if (on) spork ~ gain_on(bank_no, group_no); 
        else spork ~ gain_off(bank_no, group_no); 
    }

    fun void save_nano() {

        FileIO fout;
        int i;
        int bank;

        // open for write
        fout.open( "nano_save.txt", FileIO.WRITE );

            
        // test
        if( !fout.good() )
        {
            cherr <= "can't open file nano_save.txt for writing..." <= IO.newline();
            me.exit();
        }

        for( 0=>bank; bank<4; bank++) {

            fout.write( "\n\n// POTAR\n// -----\n" );
            for (0=>i ; i<9; i++) {
                fout <= "\nnano.init_potar(" <= bank+1 <=  ", " <= i+1 <= ", " <= potar_a[bank][i].last() <= " );" ;
            }
            
            fout.write( "\n\n// FADER\n// -----\n" );
            for (0=>i ; i<9; i++) {
                fout <= "\nnano.init_fader(" <= bank+1 <=  ", " <= i+1 <= ", " <= fader_a[bank][i].last() <= " );" ;
            }
            
            fout.write( "\n\n// GAIN\n// -----\n" );
            for (0=>i ; i<9; i++) {
                fout <= "\nnano.init_gain(" <= bank+1 <=  ", " <= i+1 <= ", 1," <= gain_a[bank][i].gain() <= " );" ;
            }
            
        }
        
        fout.write( "\n\n// ADSR\n// -----\n" );

        fout <= "\nnano.adsr_cutom_0_u.set(" <= adsr_cutom_0_u.attackTime() / 1::ms <= "::ms, " <= adsr_cutom_0_u.decayTime() / 1::ms <= "::ms, " <= adsr_cutom_0_u.sustainLevel() <= ", " <=  adsr_cutom_0_u.releaseTime()/1::ms <= "::ms );" ;
        fout <= "\nnano.adsr_cutom_1_u.set(" <= adsr_cutom_1_u.attackTime() / 1::ms <= "::ms, " <= adsr_cutom_1_u.decayTime() / 1::ms <= "::ms, " <= adsr_cutom_1_u.sustainLevel() <= ", " <=  adsr_cutom_1_u.releaseTime()/1::ms <= "::ms );" ;
        fout <= "\nnano.adsr_cutom_2_u.set(" <= adsr_cutom_2_u.attackTime() / 1::ms <= "::ms, " <= adsr_cutom_2_u.decayTime() / 1::ms <= "::ms, " <= adsr_cutom_2_u.sustainLevel() <= ", " <=  adsr_cutom_2_u.releaseTime()/1::ms <= "::ms );" ;
        
        fout.write( "\n\n// COMPRESSOR\n// -----\n" );

        fout <= "\nnano.compressor.thresh(" <= compressor.thresh() <= ");\nnano.compressor.attackTime(" <= compressor.attackTime()  / 1::ms <= "::ms );\nnano.compressor.releaseTime(" <= compressor.releaseTime()/1::ms <= "::ms );" ;
        fout <= "\nnano.compressor.slopeBelow(" <= compressor.slopeBelow() <= ");" ;
        fout <= "\nnano.compressor.slopeAbove(" <= compressor.slopeAbove() <= ");" ;
        fout <= "\nnano.compressor.gain(" <= compressor.gain() <= ");" ;

        fout <= "\n\nnano.Gain_side_comp.gain(" <= Gain_side_comp.gain() <= ");" ;


        
        // close the thing
        fout.close();
    }

spork ~ start_midi_rcv();
}



// TEST 1 

/*
nanomidi nano;

nano.potar(1) => Gain g_f => SawOsc s => Gain g_out => dac;
g_f.gain(10);

g_out.op(3);
g_out.gain(0.3);
nano.fader(1) => Gain g_gain => g_out;
(0.008)=>g_gain.gain;
<<<g_gain.gain()>>>;
while (1) 1::ms => now;
*/

// TEST 2


/*
nanomidi nano;

nano.potar(2) => Gain g_f => TriOsc s => nano.gain_fader_2 => Gain g_out => dac;
g_f.gain(10);
g_out.gain(0.3);

nano.potar(9) => Gain g_f2 => TriOsc s2 => nano.gain_fader_9 => Gain g_out2 => dac;
g_f2.gain(10);
g_out2.gain(0.3);


//g_out.op(3);
//nano.fader(2) => Gain g_gain => g_out;
//(0.008)=>g_gain.gain;
//<<<g_gain.gain()>>>;
while (1) 1::ms => now;
*/
/*
// TEST 3
nanomidi nano;
nano.potar(7 )=>blackhole;
nano.init_potar(7, 12 );

1::ms => now;

nano.save_nano();
*/
