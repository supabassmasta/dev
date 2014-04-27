public class launcher {

    string file_path;

    10 => int max_file_nb;
    20 => int max_common_file_nb;
    0 => int file_nb;
    0 => int common_file_nb;
    
    string file_name_a[max_file_nb];
    string common_files_a[max_common_file_nb];
    int common_files_id_a[max_common_file_nb];
    int shred_id[max_file_nb];
     [0,0,0,0,0, 0,0,0,0,0]@=> int shred_active[];
     [0,0,0,0,0, 0,0,0,0,0]@=> int shred_single[];
     [0,0,0,0,0, 0,0,0,0,0]@=> int shred_group[];
     0 => int replace;
     0 => int save_replace;
     0xFF => int last_shred_active;
    
    fun void load_file(string file_path_l){    
        FileIO fio;
        StringTokenizer tok;
        string new_line;
        0=>int comment;
        0=>int blank_line;
        1=>int no_error;
        string id_cmd;


        // Save file path
        file_path_l => file_path;
        // open a file
        fio.open( file_path_l, FileIO.READ );

        if( !fio.good() ){
            cherr <= "can't open file: " <= file_path_l <= " for reading..."
                  <= IO.newline();
            me.exit();
        }

        while( fio.more() &&  file_nb < max_file_nb && no_error )
        {
            //chout <= fio.readLine() <= IO.newline();
              fio.readLine() => new_line;
             tok.set(new_line);

            0=>comment;
            1=>int blank_line;

            while( tok.more() && no_error && !comment ) {
                0=>blank_line;
            
                tok.next() => id_cmd;

                if (id_cmd == "#") {
                        1 => comment;
                    }
                else if (id_cmd == "SINGLE") {
                    1=>shred_single[file_nb - 1];
                    }
                else if (id_cmd == "ON") {
                    1=>shred_active[file_nb - 1];
                    }
                else if (id_cmd == "GROUP") {
                    Std.atoi(tok.next())=>shred_group[file_nb - 1];
                    }
                else if (id_cmd == "COMMON") {
                    tok.next()=>common_files_a[common_file_nb];
                    common_file_nb ++;
                    }
                 else {
                  id_cmd => file_name_a[file_nb];
                  <<<"file_name_a",file_nb, file_name_a[file_nb]>>>;

                 file_nb++;
                 }
            }     
        }
        <<<"common_files">>>; 
        for (0=> int i; i< common_file_nb; i++) {
            Machine.add( common_files_a[i]) => common_files_id_a[i];
        }
        
        <<<"shred_active">>>;
        for (0=> int i; i< max_file_nb; i++) {
            <<<i, shred_active[i], shred_single[i]>>>;
            if (shred_active[i]){
                Machine.add( file_name_a[i]) => shred_id[i];
                i => last_shred_active;
            }
        }
        //--------------------------------------------//
        //               kb Init                      //
        //--------------------------------------------//
        Hid hi;

        // open keyboard 0
        if( !hi.openKeyboard( 0 ) ) me.exit();
        <<< "keyboard '" + hi.name() + "' ready", "" >>>;

        spork ~ kb_management(hi);

    }
    
    fun void replace_all() {
        for (0=> int i; i< max_file_nb; i++) {
            if (shred_active[i]){
                Machine.replace(shred_id[i], file_name_a[i]);
            }
        }
    }
    
    fun void manage_groups (int shred_num) {
        if (shred_group[shred_num] != 0) {
            for (0=> int i; i<max_file_nb; i++) {
                if ((shred_group[shred_num] == shred_group[i]) && (shred_active[i] == 1)){
                    Machine.remove(shred_id[i]);
                    0=>shred_active[i];
                }
            }
        }
    }
    
    
    fun int kb_convert(int whitch) {
        if (whitch == 82) return 0;
        else if (whitch == 79) return 1;
        else if (whitch == 80) return 2;
        else if (whitch == 81) return 3;
        else if (whitch == 75) return 4;
        else if (whitch == 76) return 5;
        else if (whitch == 77) return 6;
        else if (whitch == 71) return 7;
        else if (whitch == 72) return 8;
        else if (whitch == 73) return 9;
        else return 0xFF;
    }
    
    fun void kb_management (Hid hi)
    {
        HidMsg msg; 
        int num;
        // infinite event loop
        while( true )
        {
            // wait on event
            hi => now;
        
            // get one or more messages
            while( hi.recv( msg ) )
            {
                //<<<"note_active 1",note_active>>>;
                // check for action type
                if( msg.isButtonDown() )
                {
                     //<<< "down:", msg.which, "(code)", msg.key, "(usb key)", msg.ascii, "(ascii)" >>>;
                    //<<<"kb_convert",kb_convert(msg.which)>>>;
    
                    kb_convert(msg.which) => num;
                    if (num != 0xFF && num<file_nb){
                        if (!shred_active[num] || shred_single[num]){
                                Machine.add( file_name_a[num]) => shred_id[num];
                                manage_groups(num);
                                if (!shred_single[num])
                                    1=>shred_active[num];
                                
                                num => last_shred_active;
                        }
                        else {
                            if (!replace) {
                                Machine.remove(shred_id[num]);
                                0=>shred_active[num];
                                
                                if (num == last_shred_active){
                                    0xFF => last_shred_active;
                                }
                            }
                            else {
                                Machine.replace(shred_id[num], file_name_a[num]);
                            }
                            
                        }
                    }
                    
                    //--------------------------------------------//
                    //            Replace mode ./Suppr Down       //
                    //--------------------------------------------//
                    if(msg.which == 83)
                    {
                        1=>replace;
                    }
                    //--------------------------------------------//
                    //      Save/replace mode Activate * down     //
                    //--------------------------------------------//
                    else if(msg.which == 55) {
                        1=>save_replace;
                        <<<"Save/replace mode Activated">>>;
                        }
                    //      Save/replace mode Desactivate / down   //
                    //--------------------------------------------//
                    else if(msg.which == 181) {
                        0=>save_replace;
                        <<<"Save/replace mode Desactivated">>>;
                        }
                   //--------------------------------------------//
                   //      Save/replace mode : do                //
                   //--------------------------------------------//
                   else if(msg.which == 31 && save_replace && last_shred_active!=0xFF) {
                            10::ms => now;

                            if (last_shred_active == 0xAA){
                                // Replace all
                                replace_all();
                            }
                            else{
                                if (!shred_single[last_shred_active])
                                    Machine.replace(shred_id[last_shred_active], file_name_a[last_shred_active]);
                                else
                                    Machine.add( file_name_a[last_shred_active]) => shred_id[last_shred_active];
                            }
                        }
                    //--------------------------------------------//
                    //      Replace all active + down             //
                    //--------------------------------------------//
                    else if(msg.which == 78) {
                            <<<"Replace all active">>>;
                            replace_all();
                            0xAA => last_shred_active;

                        }
                    //--------------------------------------------//
                    //      Replace common files - down             //
                    //--------------------------------------------//
                    else if(msg.which == 74) {
                        for (0=> int i; i< common_file_nb; i++) {
                                Machine.replace(common_files_id_a[i], common_files_a[i]);
                            } 
                    }
                    //--------------------------------------------//
                }
                else
                {
                    //<<< "up:", msg.which, "(code)", msg.key, "(usb key)", msg.ascii, "(ascii)" >>>;
 
                    //--------------------------------------------//
                    //            Replace mode ./Suppr Down       //
                    //--------------------------------------------//
                    if(msg.which == 83)
                    {
                        0=>replace;
                    }

                    <<<"**************** SHREDS **************">>>;
                    for (0=> int i; i< max_file_nb; i++) {
                        if (shred_active[i]) 
                            <<<i, file_name_a[i]>>>;
                    }
                    <<<"**************** SHREDS **************">>>;
                
                }  

                
                
                
            } 
        }
    }
}

// Test
/*
launcher laun;

laun.load_file("files.txt");

while(1) 1::ms=> now;
*/

