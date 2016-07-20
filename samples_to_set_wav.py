import os
import re

inpath = "_SAMPLES"

letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
i = 0

def find_name (p) :
  pos = p.rfind("/")
  if pos == -1 :
    return p

  pos2 = p.rfind("/", 0, pos)
  if pos2 == -1 :
    return re.sub("\W", "_", p)

  res = p[pos2 +1 ::]

  return re.sub("\W", "_", res)

out = open("seq_3/SET_WAV2.ck", "w")

out.write("public class SET_WAV2 {\n");


for (path, dirs, files) in os.walk(inpath):
    #print path
    #print dirs
    #print files
    #print "----"

    wav_in = 0
    wav_nb = 0
    set_wav_nb = 0
    if len(files) != 0 :
      for f in files :
        if f[-3::] == "wav" or f[-3::] == "WAV"  :
          if wav_in == 0 :
            wav_in = 1
            # create new set_wav
            set_wav_name =  "_" + find_name(path)
            set_wav_name_base = set_wav_name
            #print ">>>>>>>>>>>>>>>>>>" + set_wav_name

            out.write ("fun static void " + set_wav_name + " ( SEQ @ s) {\n")
            out.write ('\t"../' + path + '/"  => string dir;\n\n')


          if wav_nb == 52 :
            # create additional set_wav
            set_wav_nb += 1
            wav_nb = 0
            set_wav_name = set_wav_name_base + "_" + str(set_wav_nb) 
            #print ">>>>>>>>>>>>>>>>>>" + set_wav_name

            out.write("\n}\n\n")
            out.write ("fun static void " + set_wav_name + " ( SEQ @ s) {\n")
            out.write ('\t"../' + path + '/"  => string dir;\n\n')

          #print f

          out.write('\tdir + "' + f + '" => s.wav["' + letters[wav_nb] + '"];\n')
          wav_nb += 1

      if wav_in == 1 :
        out.write("\n}\n\n")


out.write("}\n");

out.close()
