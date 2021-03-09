mkdir Video2
cd Video2
mkdir blurVideo2
#download the videos
youtube-dl $(curl -H "user-agent: 'your bot 0.1'" https://www.reddit.com/r/TikTokCringe/top.json?limit=12 | jq '.' | grep url_overridden_by_dest | grep -Eoh "https:\/\/v\.redd\.it\/\w{13}")
#blur the background of the videos
for f in *.mp4; do ffmpeg -i $f -lavfi '[0:v]scale=ih*16/9:-1,boxblur=luma_radius=min(h\,w)/20:luma_power=1:chroma_radius=min(cw\,ch)/20:chroma_power=1[bg];[bg][0:v]overlay=(W-w)/2:(H-h)/2,crop=h=iw*9/16' -y -vb 800k blurVideo2/$f ; done
#remove all the videos that arent blurred
rm nothing.mp4
#go to the folder with all the blurred videos
cd blurVideo2
#make a file list with all the videos names that need to be complied
for f in nothing.mp4; do echo "file $f" >> file_list.txt ; done
#compile the video
ffmpeg -f concat -i file_list.txt final.mp4


