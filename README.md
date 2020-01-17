# FFmpeg 4.2.2

Compiled with [rtools-backports](https://github.com/r-windows/rtools-backports/tree/master/mingw-w64-ffmpeg) with dependencies from [rtools-packages](https://github.com/r-windows/rtools-packages).

Example linking flags:

```
  -lavfilter -lswscale -lpostproc -lavformat -lavcodec -lswresample -lavutil \
  -lvorbis -lvorbisenc -logg -lvpx \
  -lbz2 -lsecur32 -lws2_32 -liconv -lz -lmp3lame -lx264 \
  -lxvidcore -lole32 -lm -luser32 -lbcrypt
```
