How to run the tracker

# Introduction #

Currently, we use DPM detector by Felzenszwalb et al as a baseline method. The main tracking algorithm requires to pre-process images with Matlab version of DPM detector and generate list file for images and corresponding confidence files.


# Details #

1. Move to directory matlab

2. run "process\_all\_confidence" to download required packages and process images. In case, you want to track objects other than human use "process\_all\_confidence\_object" instead.

3. generate image and confidence list files using commands like
> ls seq02-img-left/**.jpg > seq02\_imlist.txt**

> ls seq02-img-left/**.conf > seq02\_conflist.txt**

4. modify "track.sh" in "standalone\_tracker" accordingly and run the tracker.