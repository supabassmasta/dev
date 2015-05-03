SEQ s;
"../_SAMPLES/FreeDrumKits.net - 9th Wonder Kit/Snares/Wsc_Snr2.wav" => s.wav["s"];
"../_SAMPLES/FreeDrumKits.net - 9th Wonder Kit/Hi-Hats/Str_H1.wav" => s.wav["h"];
"../_SAMPLES/FreeDrumKits.net - 9th Wonder Kit/Kicks/Wal_K.wav" =>s.wav["k"];
"*2k$k:2_s|k _" => s.seq;
s.full_sync();

SEQ s2;    

"../_SAMPLES/FreeDrumKits.net - 9th Wonder Kit/Kicks/Tub_K.wav" => s2.wav["k"];
"../_SAMPLES/FreeDrumKits.net - 9th Wonder Kit/Snares/Smk_Sn.wav" => s2.wav["s"];
"../_SAMPLES/FreeDrumKits.net - 9th Wonder Kit/Hi-Hats/Bck_H.wav" => s2.wav["h"];
4*300::ms => s2.max;
"_h_h" => s2.seq;
s2.full_sync();


s.go();
s2.go();

while(1) {
     100::ms => now;
     }
       
