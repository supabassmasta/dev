#!/usr/bin/python3

import os

src = "../Mellotron/"
dest = "../_SAMPLES/SYNTWAVS/"

instruments = [
"Cello",
"CombinedChoir",
"GC3Brass",
"M300A",
"M300B",
"MkIIBrass",
"MkIIFlute",
"MkIIViolins",
"StringSection",
"Woodwind2"
]

print (instruments)


notes = {
"G2.wav":  43, 
"G#2.wav": 44,
"A2.wav":  45,
"A#2.wav": 46,
"B2.wav":  47,
"C3.wav":  48,
"C#3.wav": 49,
"D3.wav":  50,
"D#3.wav": 51,
"E3.wav":  52,
"F3.wav":  53,
"F#3.wav": 54,
"G3.wav":  55,
"G#3.wav": 56,
"A3.wav":  57,
"A#3.wav": 58,
"B3.wav":  59,
"C4.wav":  60,
"C#4.wav": 61,
"D4.wav":  62,
"D#4.wav": 63,
"E4.wav":  64,
"F4.wav":  65,
"F#4.wav": 66,
"G4.wav":  67,
"G#4.wav": 68,
"A4.wav":  69,
"A#4.wav": 70,
"B4.wav":  71,
"C5.wav":  72,
"C#5.wav": 73,
"D5.wav":  74,
"D#5.wav": 75,
"E5.wav":  76,
"F5.wav":  77,
}

print (notes)


for i in instruments :
  for n in notes :
    os.symlink(src + i + "/" + n, dest + "MELLOTRON_" + i + "_" + str(notes[n]) + ".wav")


