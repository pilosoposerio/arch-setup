#!/bin/bash

# note that this must be inside the repository

for F in $(cat manifest.txt); do
    cp -r $F . # copy file or folder here
done
