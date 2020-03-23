#!/bin/bash

reflector \
    --latest 10 \
    --sort rate \
    --protocol http \
    --protocol https \
    --country Japan \
    --country China \
    --country Singapore \
    --country Taiwan \
    --country "Hong Kong" \
    --country "Malaysia" \
    --country "Australia" \
    --save /etc/pacman.d/mirrorlist
