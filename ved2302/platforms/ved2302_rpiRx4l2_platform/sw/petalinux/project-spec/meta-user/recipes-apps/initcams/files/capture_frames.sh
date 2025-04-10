cam --list
cam -c1 -C1 --stream width=1920,height=1080,pixelformat=BGR888  -Fcam0.bin
ffmpeg -f rawvideo -s 1920x1080 -pix_fmt rgb24 -i cam0.bin cam0.png
cam -c2 -C1 --stream width=1920,height=1080,pixelformat=BGR888  -Fcam1.bin
ffmpeg -f rawvideo -s 1920x1080 -pix_fmt rgb24 -i cam1.bin cam1.png
cam -c3 -C1 --stream width=1920,height=1080,pixelformat=BGR888  -Fcam2.bin
ffmpeg -f rawvideo -s 1920x1080 -pix_fmt rgb24 -i cam2.bin cam2.png
cam -c4 -C1 --stream width=1920,height=1080,pixelformat=BGR888  -Fcam3.bin
ffmpeg -f rawvideo -s 1920x1080 -pix_fmt rgb24 -i cam3.bin cam3.png
