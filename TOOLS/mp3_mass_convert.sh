# TO execute in the directory containing wavs

for i in *.wav; do ffmpeg -i "$i" -acodec mp3 -ab 128K "$(basename "$i" .wav)".mp3 ; done
