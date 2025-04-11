init_cams_bgr.sh

cam -c1 -C1 --stream width=1920,height=1080,pixelformat=BGR888  -Fcam0_libcamera_bgr.bin
ffmpeg -f rawvideo -s 1920x1080 -pix_fmt rgb24 -i cam0_libcamera_bgr.bin cam0_libcamera_bgr.png

cam -c2 -C1 --stream width=1920,height=1080,pixelformat=BGR888  -Fcam1_libcamera_bgr.bin
ffmpeg -f rawvideo -s 1920x1080 -pix_fmt rgb24 -i cam1_libcamera_bgr.bin cam1_libcamera_bgr.png

cam -c3 -C1 --stream width=1920,height=1080,pixelformat=BGR888  -Fcam2_libcamera_bgr.bin
ffmpeg -f rawvideo -s 1920x1080 -pix_fmt rgb24 -i cam2_libcamera_bgr.bin cam2_libcamera_bgr.png

cam -c4 -C1 --stream width=1920,height=1080,pixelformat=BGR888  -Fcam3_libcamera_bgr.bin
ffmpeg -f rawvideo -s 1920x1080 -pix_fmt rgb24 -i cam3_libcamera_bgr.bin cam3_libcamera_bgr.png
