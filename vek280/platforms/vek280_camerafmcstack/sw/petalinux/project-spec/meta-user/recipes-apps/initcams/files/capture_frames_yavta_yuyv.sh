init_cams_yuyv.sh

yavta -F /dev/video0 -n 1 -c1 -s 1920x1080 -f YUYV
ffmpeg -f rawvideo -s 1920x1080 -pix_fmt yuyv422 -i frame-000000.bin cam0_yavta_yuyv.png

yavta -F /dev/video1 -n 1 -c1 -s 1920x1080 -f YUYV
ffmpeg -f rawvideo -s 1920x1080 -pix_fmt yuyv422 -i frame-000000.bin cam1_yavta_yuyv.png

yavta -F /dev/video2 -n 1 -c1 -s 1920x1080 -f YUYV
ffmpeg -f rawvideo -s 1920x1080 -pix_fmt yuyv422 -i frame-000000.bin cam2_yavta_yuyv.png

yavta -F /dev/video3 -n 1 -c1 -s 1920x1080 -f YUYV
ffmpeg -f rawvideo -s 1920x1080 -pix_fmt yuyv422 -i frame-000000.bin cam3_yavta_yuyv.png

