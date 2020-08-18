#! /bin/sh

# If the music isn't downloaded with -o <output template>, then 
# The filename of the downloaded music looks like this : 
# %(title)-%(youtube-id-of-the-video).%(extension)
# This line transforms it to : 
# %(title).ogg
find . -maxdepth 1 -type f | egrep "^.*-(\w{11})\.\w{2,}$" | awk  '{n=split($0,a,"-");str = a[1];for (i = 2; i <= n-1; ++i)str = str a[i];print "\""$0"\" \""str".ogg\""}' | xargs -n2 -L1 -r mv

# Next we need to convert all those files to opus format (the best)
find . -maxdepth 1 -type f | awk '{n=split($0,a,".");str = a[1];for (i = 2; i <= n-1; ++i)str = str a[i];print "\""str"\""}' | xargs -n2 -L1 -r -I{} ffmpeg -i ".{}.ogg" ".{}.opus" -y

# We finally delete all files except opus files
find . -maxdepth 1 -type f | egrep -v "*.opus" | awk '{print "\""$0"\""}' | xargs -n1 -L1 -r rm
