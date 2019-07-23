#!/usr/bin/env bash

set -e

file=sampledata100.tsv
depth=500

rm -rf test

mkdir test && cd test

echo "=== Baseline ==="
mkdir baseline && cd baseline
cp ../../$file .
/usr/bin/time -o time ../../../bin/gliph-group-discovery.pl --tcr $file --simdepth=$depth > out 2> err
cd ..

echo "=== Baseline Repeat ==="
mkdir baseline-repeat && cd baseline-repeat
cp ../../$file .
# copy over the simulated data
cp ../baseline/$file-kmer_resample_*.txt .
/usr/bin/time -o time ../../../bin/gliph-group-discovery.pl --tcr $file --simdepth=$depth > out 2> err

cd ..
../compare.py clone baseline/*clone-network.txt baseline-repeat/*clone-network.txt
echo
../compare.py convergence baseline/*convergence-groups.txt baseline-repeat/*convergence-groups.txt
echo

echo "=== Faster ==="
mkdir faster && cd faster
cp ../../$file .
# copy over the simulated data
cp ../baseline/$file-kmer_resample_*.txt .
/usr/bin/time -o time ../../../bin/gliph-group-discovery-faster.pl --tcr $file --simdepth=$depth > out 2> err

cd ..
../compare.py clone baseline/*clone-network.txt faster/*clone-network.txt
echo
../compare.py convergence baseline/*convergence-groups.txt faster/*convergence-groups.txt
echo
