#!/bin/bash
#
# copy and backup
#
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

#
# create directory and enter it
#
function md() {
    mkdir -p "$@" && cd "$@"
}

#
# create a better format for 'ls'
#
__awk_format='
    {
        k=0
        for (i=0;i<=8;i++) {
            k+=(substr($1,i+2,1)~/[rwx]/) *2^(8-i);
        }
        if(k) {
            printf("%0o ", k);
            printf(" %9s %4s %3s %2s %5s %6s %s %s %s\n",
                $3, $4, $6, $7, $8, $5, $9, $10, $11);
        }
    }'

#
# list all files, long format, colored, permissions octal
#
function la() {
    ls -l "$@" | awk "$__awk_format"
}

function ll() {
    ls -l -Aflh "$@" | awk "$__awk_format"
}

#
# list all directories only
function lld() {
    ls -lh "$@" | grep "^d" | awk "$__awk_format"
}


