#!/bin/bash

REMOTE_USER="nancy"
REMOTE_HOST="aurora"
LOCAL_MUSIC_PATH="/Users/nancycantusaldana/server-staging/music/"
LOCAL_TV_PATH="/Users/nancycantusaldana/server-staging/tv/"
LOCAL_MOVIE_PATH="/Users/nancycantusaldana/server-staging/movies/"
REMOTE_MUSIC_PATH="/home/nancy/Jellyfin Server Media/Music"
REMOTE_TV_PATH="/home/nancy/Jellyfin Server Media/Shows"
REMOTE_MOVIE_PATH="/home/nancy/Jellyfin Server Media/Movies"

usage() {
    echo "Usage: $0 [-m | -t | -v]"
    echo "  -m: Sync music files"
    echo "  -t: Sync TV show files"
    echo "  -v: Sync movie files"
    exit 1
}

while getopts "mtv" flag; do
    case "${flag}" in
        m)
            LOCAL_PATH="${LOCAL_MUSIC_PATH%/}/"
            REMOTE_PATH="${REMOTE_MUSIC_PATH%/}/"
            echo "Syncing music files..."
            ;;
        t)
            LOCAL_PATH="${LOCAL_TV_PATH%/}/"
            REMOTE_PATH="${REMOTE_TV_PATH%/}/"
            echo "Syncing TV show files..."
            ;;
        v)
            LOCAL_PATH="${LOCAL_MOVIE_PATH%/}/"
            REMOTE_PATH="${REMOTE_MOVIE_PATH%/}/"
            echo "Syncing movie files..."
            ;;
        *)
            usage
            ;;
    esac
done

if [ $OPTIND -eq 1 ]; then
    usage
fi

scp -r "${LOCAL_PATH}"* "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PATH}"
