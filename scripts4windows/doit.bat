"C:\Program Files\VideoLAN\VLC\vlc" -I dummy -vvv "%1" --sout=#transcode{vcodec=mp2v,vb=800,scale=1,acodec=mpga,ab=128,channels=2,samplerate=44100}:std{access=file,mux=ts,dst="D:\MEDIA-MPG\%1.mpg"} vlc://quit
