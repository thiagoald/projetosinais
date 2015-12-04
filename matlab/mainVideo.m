v = VideoReader('video.mp4');

while hasFrame(v)
    video = readFrame(v);
    detectarFarois(video);
     pause;
end