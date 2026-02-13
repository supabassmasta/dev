
CK_SRC_PATH=../../chuck/include

CXX=g++
CXXFLAGS=-O3 -I$(CK_SRC_PATH) -I..

all: bench_resynth

bench_resynth: bench_resynth.cpp ../SpectralSynth.cpp ../AudioFFT.cpp ../AudioFFT.h
	$(CXX) $(CXXFLAGS) -o $@ bench_resynth.cpp ../AudioFFT.cpp -lm

clean:
	rm -f bench_resynth

.PHONY: all clean
