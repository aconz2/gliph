This repo contains some simple changes to improve the speed of [gliph](https://github.com/immunoengineer/gliph)

The faster version is located (gliph-group-discovery-faster.pl)[bin/gliph-group-discovery-faster.pl]

# Improvements
See (this commit)[https://github.com/aconz2/gliph/commit/bea1a556f0c3bce2d13f6cc7106c567cbb12c3f5] for the diff.

The 2 improvements just precompute data outside of their respective "main" loops instead of recomputing on every iteration.

You will only see speed differences for larger input files.

# Verification
There is a test script (test.sh)[test/test.sh] that executes the original version to compare against the -faster version to verify they are the same. Since the sampling information is not deterministic, we simply copy over the `-kmer_resample_500_log.txt` and `-kmer_resample_500_minp0.001_ove10.txt` after generating them once in the first test. We do a repeat of the original version to show that this makes for deterministic output, followed by the -faster version.

The outputs are compared with a utility (compare.py)[test/compare.py] to compare them for equivalence (pretty much just set equality) because (without more modifications) the output order is not deterministic so we cannot do a naive bit-level comparison.

I wanted as small a diff as possible to make it easy to review and because I am not a Perl programmer
