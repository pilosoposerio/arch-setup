#!/bin/bash

# copy and backup
cpb (){
    local src=$1
    local dst=$2
    
    # make a back up
    cp $dst "$dst.bak"
    # copy and replace dst
    cp $src $dst
   
}

#
# a function to kill a process
#
patayin () {
    killall -q $1
    while pgrep -u $UID -x $1 > /dev/null; do sleep 1; done
}

