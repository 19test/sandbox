1) http://www.vlfeat.org/install-matlab.html kur

- http://www.vlfeat.org/download/vlfeat-0.9.20.tar.gz indir - aç ve make
- http://www.vlfeat.org/install-matlab.html

```matlab
>> run('VLFEATROOT/toolbox/vl_setup')
>> vl_version verbose
VLFeat version 0.9.20
    Static config: X64, little_endian, GNU C 40804 LP64, POSIX_threads, SSE2, OpenMP
    8 CPU(s): GenuineIntel MMX SSE SSE2 SSE3 SSE41 SSE42 AVX
    OpenMP: max threads: 8 (library: 8)
    Debug: no
    SIMD enabled: yes
```

- 

## Original Doc
so.m

Small matlab demo, so.m, to explore an answer to this stackoverflow question:

http://dsp.stackexchange.com/questions/1122/how-to-compute-2d-displacement-vector-for-binary-image-registration

so_13_02_2012.m

Small matlab demo for this dsp.stackexchange question:

http://dsp.stackexchange.com/questions/1436/how-can-i-perform-a-registration-to-2d-images-using-rigid-transformation-in/1440#1440

so_25_02_2012
Small unit test for image hash and descriptor function for this SO question

http://dsp.stackexchange.com/questions/1564/good-metric-for-qualitatively-comparing-image-patches
