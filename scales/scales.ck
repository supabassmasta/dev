public class scales {

static int a[][];

    fun static int conv_to_note(int rel_notes_i, string val_s, int ref_note)
    {
        int j, k;
        int distance_i;
        int result_i;
        int scale_nb;
        
        // Find scale
        
                    if (val_s == "PENTA_MAJ") 0 => scale_nb;
                    //Gamme Majeur
                    else if (val_s == "MAJ") 1 => scale_nb;
                    // Gamme Mineur
                    else if (val_s == "MIN") 2 => scale_nb;
                    // Gamme Pentatonique Mineure
                    else if (val_s == "PENTA_MIN") 3 => scale_nb;
                    // Blues
                    else if (val_s == "BLUES") 4 => scale_nb;
                    // All notes
                    else if (val_s == "ALL") 5 => scale_nb;
        //ADONAI_MALAKH
                    else if (val_s == "ADONAI_MALAKH") 6 => scale_nb;
        //
                    else if (val_s == "ALGERIAN") 7 => scale_nb;
        //
                    else if (val_s == "BI_YU") 8 => scale_nb;
        //
                    else if (val_s == "AEOLIAN_FLAT_1") 9 => scale_nb;
        //
                    else if (val_s == "CHAD_GADYO") 10=> scale_nb;
        //
                    else if (val_s == "CHAIO") 11=> scale_nb;
        //
                    else if (val_s == "CHROMATIC_BEBOP") 12=> scale_nb;
        //
                    else if (val_s == "ESKIMO_HEXATONIC_2") 13=> scale_nb;
        //
                    else if (val_s == "HAWAIIAN") 14=> scale_nb;
        //
                    else if (val_s == "HIRA_JOSHI") 15=> scale_nb;
        //
                    else if (val_s == "HONCHOSHI_PLAGAL_FORM") 16=> scale_nb;
        //

        
        
        
        /* Compute distance to note */
        if (rel_notes_i == 0)
        {
            0 => distance_i;
        }
        else if (rel_notes_i > 0)
        {
            0 => distance_i;
            for (0 => j; j<rel_notes_i; j++)
            {
                a[scale_nb][ j % a[scale_nb].cap()] +=> distance_i;
            }
        }
        else /* rel_notes_i < 0 */
        {
            0 => distance_i;
            for (0 => j; j< -rel_notes_i; j++)
            {
                a[scale_nb].cap() - 1 - (j % a[scale_nb].cap()) => k;
                a[scale_nb][ k ] -=> distance_i;
            }
        }
        
        /* Convert Note */
        ref_note + distance_i => result_i;
        
        return result_i;  
    }


}

        // Gamme Majeur: 1 , 1 , 1/2 , 1 , 1 , 1 , 1/2 
        // Gamme Mineure: 1 , 1/2 , 1 , 1 , 1/2 , 1 et 1/2 , 1/2
        // Gamme Pentatonique Majeure: 1 ton - 1 ton - 1 ton et demi - 1 ton - 1 ton et demi
        // Gamme Pëntatonique Mineure: 1 ton et demi - 1 ton - 1 ton - 1 ton et demi - 1 ton.
        // Blues 1 ton et demi - 1 ton - 1 demi ton - 1 demi ton - 1 ton - 1 ton et demi - 1 ton.
        [[2,2,3,2,3],     //Pentatonique Majeure
         [2,2,1,2,2,2,1], //Gamme Majeur
         [2,1,2,2,1,3,1], // Gamme Mineur
         [3,2,2,3,2],     // Gamme Pentatonique Mineure
         [3,2,1,1,2,3,2], // Blues
         [1,1]            // All notes
	 ,[1,1,1,2,2,2,1,2] // ADONAI_MALAKH (Israel)
	 ,[2,1,2,1,1,1,3,1] // ALGERIAN
	 ,[3,4,3,2] // BI_YU (CHINA)
	 ,[3,1,2,2,1,2,1] // AEOLIAN_FLAT_1
	 ,[2,1,2,2,5] // CHAD_GADYO (Israel)
	 ,[2,3,3,2,2] // CHAIO (China)
	 ,[1,1,2,1,2,2,1,1,1] // CHROMATIC_BEBOP
	 ,[2,2,2,2,3,1] // ESKIMO_HEXATONIC_2 (North America)
	 ,[2,1,4,2,2,1] // HAWAIIAN
	 ,[2,1,4,1,4] // HIRA_JOSHI (Japan)
	 ,[1,2,2,1,4,2] // HONCHOSHI_PLAGAL_FORM (Japan)
]@=> int foo[][];

foo @=> scales.a;

   while(1) 1000::ms => now;
